class Sensor < ActiveRecord::Base
  belongs_to :sprinkler
  attr_accessible :identifier, :port_index

  validate :port_index, presence: true
  validate :identifier, presence: true
  
  has_many :sensor_readings, dependent: :destroy

end
