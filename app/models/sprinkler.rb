class Sprinkler < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :sensors, dependent: :destroy
  has_many :valves, dependent: :destroy
  has_many :sprinkler_plans, dependent: :destroy

  attr_accessible :identifier, :latitude, :longitude, :mac_address, :machine_version, :refresh_rate_seconds 
end
