class ValfIrregation < ActiveRecord::Base
  include DateTimeHelper

  belongs_to :valf
  attr_accessible :amount, :start_time, :end_time
  
  validates :amount, :numericality => {:greater_than_or_equal_to => 0, :message => I18n.t(:only_numbers)}
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :times_are_dates
  validates :valf_id, presence: true
  before_validation :update_times

  protected
  def update_times
    self.start_time = to_time(start_time)
    self.end_time = to_time(end_time)
  end
  
  def times_are_dates
    if(start_time)
      errors.add(:start_time, I18n.t(:must_be_a_valid_date)) unless start_time.is_a?(Time)
      if(end_time)
        errors.add(:end_time, I18n.t(:must_be_a_valid_date)) unless end_time.is_a?(Time)        
        errors.add(:end_time, I18n.t("errors.messages.greater_than", count: I18n.t(:start_time))) unless end_time >= start_time
      end
    end
  end
end
