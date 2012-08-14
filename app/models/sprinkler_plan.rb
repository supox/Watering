class SprinklerPlan < ActiveRecord::Base
  include IceCube

  validate :schedule, presence:true
  
  serialize :schedule, Hash
  
  attr_accessible :start_date
  
  belongs_to :sprinkler
  
  def schedule=(new_schedule)
    write_attribute(:schedule, new_schedule.to_hash)
  end

  def schedule
    Schedule.from_hash(read_attribute(:schedule))
  end
  
end
