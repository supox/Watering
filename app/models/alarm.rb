class Alarm < ActiveRecord::Base
  belongs_to :sensor
  
  attr_accessible :alarm_title, :alarm_value, :condition_type
  classy_enum_attr :condition_type, :enum => 'ConditionType'
  
  validates :alarm_value, :numericality => {:message => I18n.t(:only_numbers)}
  validates :alarm_title,:length => {maximum:50}
  
  def title
    return "#{condition_type.text} #{alarm_value}" if !self.alarm_title.is_a?(String) || self.alarm_title.blank?
    return self.alarm_title
  end
  
  def will_alarm?(sensor_value)
    condition_type.condition_meet?(sensor_value, alarm_value)
  end

end
