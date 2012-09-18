class ValfPlan < ActiveRecord::Base
  belongs_to :sprinkler_plan
  belongs_to :valf
  
  attr_accessible :amount, :valf, :valf_id, :sprinkler_plan, :sprinkler_plan_id, :enabled
  
  validates :amount, :numericality => {:greater_than_or_equal_to => 0 }, :if=>:enabled
  validates :valf, presence: true, :if=>:enabled
  validates :sprinkler_plan, presence: true, :if=>:enabled
  validate :same_sprinkler, :if=>:enabled
  
  def enabled
    return @enabled || !self.new_record?
  end
  
  def enabled=(v)
    @enabled=(v=="1" || v==true)
  end
  
  protected
  def same_sprinkler
    return unless enabled
    if( !(sprinkler_plan && valf) )
      logger.info "No sprinkler_plan or Valf"
      errors.add(:schedule, I18n.t("errors.messages.invalid_type") )
    end
    if(sprinkler_plan.sprinkler != valf.sprinkler)
      errors.add(:schedule, I18n.t("errors.messages.invalid_type") )
    end
  end
end
