class SprinklerLog < ActiveRecord::Base
  include DateTimeHelper

  belongs_to :sprinkler
  
  attr_accessible :event_time, :event_type, :port_index
  classy_enum_attr :event_type, :enum => 'SprinklerLogType'

  before_validation :update_time
  validate :event_time_is_date
  validates :event_time, presence: true
  validate :valid_port_index
    
  default_scope order: 'sprinkler_logs.event_time DESC'

  protected
  def update_time
    self.event_time = to_time(event_time)
  end
  
  def event_time_is_date
   if(event_time)
      errors.add(:event_time, I18n.t(:must_be_a_valid_date)) unless event_time.is_a?(Time)
    end
  end
  
  def valid_port_index
    return if (event_type && !event_type.has_port?)
    return if sprinkler.valves.find_by_port_index(port_index)
    return if sprinkler.sensors.find_by_port_index(port_index)

    errors.add(:port_index, I18n.t("errors.messages.inclusion"))
  end
end
