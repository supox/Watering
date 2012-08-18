class Sprinkler < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :sensors, dependent: :destroy
  has_many :valves, dependent: :destroy
  has_many :sprinkler_plans, dependent: :destroy

  attr_accessible :identifier, :latitude, :longitude, :mac_address, :machine_version, :refresh_rate_seconds
  
  def plans( to = Time.now+30.days, from = Time.now )
    occurerences = sprinkler_plans.collect do |plan|
      if plan.schedule
        plan.schedule.occurrences_between( from, to ).collect do |p|
          {date:p, title:plan.title, id:plan.id}
        end
      end
    end
    return occurerences.compact.flatten.sort {|a,b| a[:date] <=> b[:date] }
  end
end
