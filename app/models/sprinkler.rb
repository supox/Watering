class Sprinkler < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :identifier, :ios, :latitude, :longitude, :mac_address, :machine_version, :refresh_rate_seconds 
end
