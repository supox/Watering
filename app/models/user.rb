class User < ActiveRecord::Base
  attr_accessible :name, :email, :phone, :password, :password_confirmation, :time_zone
  
  has_secure_password
  
  has_and_belongs_to_many :sprinklers

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates_length_of :name, in: 4..50, allow_blank: false
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create
  validates_length_of :password, in: 6..32, allow_blank: true
  validates_format_of :phone, 
    :message => I18n.t("errors.messages.invalid_type"),
    :with => /^[\(\)0-9\- \+\.]{10,20}$/ 

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def create_reset_code
    generate_reset_password_token! if should_generate_reset_token?
    UserMailer.email_reset_password(self, self.reset_password_token).deliver
  end
  
  def reset_password(reset_token, new_password, new_password_confirmation)
    return false unless valid_reset_token?(reset_token)
    
    self.password = new_password
    self.password_confirmation = new_password_confirmation
  
    if valid?
      clear_reset_password_token
      save
      return true
    end
    
    return false
  end

  private
  
  # Check if the token is valid for reset.
  def valid_reset_token?(token)
    token.is_a?(String) && reset_password_period_valid? && reset_password_token == token
  end

  # return true unless there is a valid reset_token is valid  
  def should_generate_reset_token?
    reset_password_token.nil? || !reset_password_period_valid?
  end

  # Check if the period of the reset token is valid
  def reset_password_period_valid?
    reset_password_within = 3.days
    reset_password_sent_at && reset_password_sent_at.utc >= reset_password_within.ago
  end
  
  # Generates a new random token for reset password
  def generate_reset_password_token!
    characters = ('a'..'z').to_a + ('A'..'Z').to_a 
    self.reset_password_sent_at = Time.zone.now.utc
    self.reset_password_token = (1..12).map{characters.sample}.join # Generate a 12-length random string
    save(:validate => false)
  end

  # Removes reset_password token
  def clear_reset_password_token
    self.reset_password_token = nil
    self.reset_password_sent_at = nil
  end
  
end
  