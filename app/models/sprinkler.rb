class Sprinkler < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :sensors, dependent: :destroy
  has_many :valves, dependent: :destroy
  has_many :sprinkler_plans, dependent: :destroy

  attr_accessible :identifier, :latitude, :longitude,
                  :mac_address, :machine_version, :refresh_rate_seconds,
                  :main_valve_timing, :main_valve_delay
  classy_enum_attr :main_valve_timing, :allow_nil => false  
  
  # TODO - add verifies
  
  def plans( to = Time.now+30.days, from = Time.now )
    occurerences = sprinkler_plans.collect do |plan|
      if plan.schedule
        
        plan.schedule.occurrences_between( from, [to, (plan.end_date or to)].min ).collect do |p|
          {date:p, title:plan.title, id:plan.id}
        end
      end
    end
    return occurerences.compact.flatten.sort {|a,b| a[:date] <=> b[:date] }
  end
end
