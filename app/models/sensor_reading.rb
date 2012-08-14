class SensorReading < ActiveRecord::Base
  attr_accessible :sensor_value, :read_time
  
  belongs_to :sensor

  validate :sensor_value, presence: true
  validates_numericality_of :sensor_value, :only_integer => true, :message => I18n.t(:only_numbers)
  
  validate :read_time, presence: true
  validate :read_time_is_date?
  
  validate :sensor_id, presence: true

  default_scope order: 'sensor_readings.created_at'
  
  private

  def read_time_is_date?
    if !read_time.is_a?(Time)
      errors.add(:read_time, I18n.t(:must_be_a_valid_date))
    end
  end
  
end
