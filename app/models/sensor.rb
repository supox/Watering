class Sensor < ActiveRecord::Base
  belongs_to :sprinkler
  has_many :alarms, dependent: :destroy
  has_one :valf
  
  attr_accessible :identifier, :port_index, :sensor_type, :convert_ratio, :valf_id, :no_water_pulse_reaction_delay
  classy_enum_attr :sensor_type, :enum => 'SensorType', :allow_nil => false

  validates :identifier, presence: true
  validates :port_index, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}, :uniqueness => { :scope => :sprinkler_id }
  validates :convert_ratio, :numericality => { :greater_than_or_equal_to => 0 }, :allow_nil => true
  validates :valf_id, :numericality => { :only_intgeger => true }, :allow_nil => true
  validates :no_water_pulse_reaction_delay, :numericality => { :integer => true, :greater_than_or_equal_to => 0 }, :allow_nil => true
  validate :validate_valf
  
  default_scope order: 'port_index'

  has_many :sensor_readings, dependent: :destroy

  def last_readings(events_time = Time.zone.now-3.days)
   self.sensor_readings.all(limit:5, :conditions => ["read_time >= ?", events_time])
  end
  
  def last_reading
    self.sensor_readings.first 
  end
  
  private
  def validate_valf
    if sensor_type.has_valf?
      errors.add(:convert_ratio, I18n.t("errors.messages.empty")) unless convert_ratio
      errors.add(:valf_id, I18n.t("errors.messages.empty")) unless valf_id
      errors.add(:valf_id, I18n.t("errors.messages.inclusion")) unless sprinkler.valves.find_by_id(valf_id)
      errors.add(:no_water_pulse_reaction_delay, I18n.t("errors.messages.empty")) unless no_water_pulse_reaction_delay 
    end
  end
end
