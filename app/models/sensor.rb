class Sensor < ActiveRecord::Base
  belongs_to :sprinkler
  has_many :alarms, dependent: :destroy
  attr_accessible :identifier, :port_index, :sensor_type
  classy_enum_attr :sensor_type, :enum => 'SensorType'

  validates :identifier, presence: true
  validates :port_index, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}, :uniqueness => { :scope => :sprinkler_id }
  validates :sensor_type, presence:true

  default_scope order: 'port_index'

  has_many :sensor_readings, dependent: :destroy

  def last_readings(events_time = 3.days.ago)
   self.sensor_readings.all(limit:5, :conditions => ["read_time >= ?", events_time])
  end
  
  def last_reading
    self.sensor_readings.first 
  end
end
