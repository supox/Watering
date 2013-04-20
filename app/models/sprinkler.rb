class Sprinkler < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :sensors, dependent: :destroy
  has_many :valves, dependent: :destroy
  has_many :sprinkler_plans, dependent: :destroy
  has_many :sprinkler_logs, dependent: :destroy

  attr_accessible :identifier, :latitude, :longitude,
                  :mac_address, :machine_version, :refresh_rate_seconds,
                  :main_valf,
                  :main_valve_timing, :main_valve_delay
  classy_enum_attr :main_valve_timing, :allow_nil => false
  
  validates :refresh_rate_seconds, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :main_valve_delay, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :identifier, presence: true, length: { maximum: 50 }
  VALID_MACADDRESS_REGEX = /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i  
  validates :mac_address, length: { minimum:5, maximum: 50 },
                          format: { with: VALID_MACADDRESS_REGEX }   
  validates :machine_version, presence: true, length: { maximum: 50 }  
  validate :main_valf_valid
  
  
  def plans( to = Time.zone.now+30.days, from = Time.zone.now )
    occurerences = sprinkler_plans.collect do |plan|
      if plan.schedule
        
        plan.schedule.occurrences_between( from, [to, (plan.end_date or to)].min ).collect do |p|
          {date:p, title:plan.title, id:plan.id}
        end
      end
    end
    return occurerences.compact.flatten.sort {|a,b| a[:date] <=> b[:date] }
  end
  
  def timing(to = Time.zone.now+30.days, from = Time.zone.now )
    timings = sprinkler_plans.collect do |plan|
      next if plan.valf_plans.empty?
      valves_offsets = plan.valf_plans.collect do |valf_plan|
        { start_time: 0, valf_id: valf_plan.valf.id, irrigation_mode: valf_plan.valf.irrigation_mode, amount: valf_plan.amount.to_i }
      end
      if plan.schedule
        plan.schedule.occurrences_between( from, [to, (plan.end_date or to)].min ).collect do |p|
          valves_offsets.collect do |o|
            oc = o.clone
            oc[:start_time] = oc[:start_time] + p.to_time.to_i
            oc
          end
        end
      end
    end
    return timings.compact.flatten.sort {|a,b| a[:offset] <=> b[:offset] }    
  end
  
  def get_config
    attributes
  end
  
  def alarms
    sensors.collect{|s| s.alarms}.flatten
  end
  
  def main_valf_delay
      main_valve_timing * main_valve_timing.sign
  end
  
  def last_logs(from_date = Time.zone.now-3.days)
    sprinkler_logs.find(:all, :conditions => ["event_time > ? ", from_date])
  end
  
  private
  def main_valf_valid
    return unless main_valf
    errors.add(:main_valf, I18n.t("errors.messages.inclusion")) unless valves.find_by_id(main_valf)
  end
  
end
