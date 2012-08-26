class SensorReading < ActiveRecord::Base
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
    begin
      if read_time.is_a?(Integer)
        self.read_time=Time.at(read_time)
      elsif(read_time.is_a?(String))
        self.read_time=Time.parse(read_time)
      end
    rescue Exception => e
      logger.debug "Rescue. ex = " + e.message
    end
  end
end
