class SensorReading < ActiveRecord::Base
  include DateTimeHelper

  attr_accessible :sensor_value, :read_time

  belongs_to :sensor

  validates :sensor_value, :numericality => {:message => I18n.t(:only_numbers)}
  validate :read_time_is_date
  validates :sensor_id, presence: true
  before_validation :update_time

  default_scope order: 'sensor_readings.read_time DESC'

  protected
  def read_time_is_date
    errors.add(:read_time, I18n.t(:must_be_a_valid_date)) unless read_time.is_a?(Time)
  end

  def update_time
    self.read_time = to_time(read_time)
  end
end
