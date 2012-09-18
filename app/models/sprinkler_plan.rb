class SprinklerPlan < ActiveRecord::Base
  include IceCube

  belongs_to :sprinkler
  
  attr_accessible :start_date, :end_date, :title, :repeat, :weekly, :day_of_month, :plan_type, :valf_ids, :valf_plans, :valf_plans_attributes
  classy_enum_attr :plan_type, allow_nil: false
  has_many :valf_plans, dependent: :destroy
  accepts_nested_attributes_for :valf_plans, :allow_destroy => true
  
  validates :title, presence:true, length: { minimum: 3, maximum: 50 }
  validates :start_date, presence:true
  validate :validate_end_date_before_start_date
  validate :validate_schedule
  
  before_validation :update_schedule
    
  serialize :schedule, Hash
  
  def schedule=(new_schedule)
    if( new_schedule != nil)
      write_attribute(:schedule, new_schedule.to_hash)
    end
  end

  def schedule
    if read_attribute(:schedule).empty?
      nil
    else
      Schedule.from_hash(read_attribute(:schedule))
    end
  end
  
  def repeat
    return @_repeat if @_repeat
      
    schedule_yml = YAML::load(schedule.to_yaml)
    if(schedule_yml == nil || schedule_yml.empty? || schedule_yml[:rrules].empty? )
      return "Once"
    end
    
    case schedule_yml[:rrules][0][:rule_type].to_s
    when "IceCube::DailyRule"
      return "Daily"
    when "IceCube::WeeklyRule"
      return "Weekly"
    when "IceCube::MonthlyRule"
      return "Monthly"
    else
      return "Once"
    end
  end
  
  def repeat=(new_repeat)
    @_repeat = new_repeat
  end
  
  def weekly
    return @_weekly if @_weekly
    schedule_yml = YAML::load(schedule.to_yaml)
    begin
      return schedule_yml[:rrules][0][:validations][:day]
    rescue
      return [0]
    end
  end
  
  def weekly=(new_weekly)
    @_weekly = new_weekly.collect{|i| i.to_i unless i==""}.compact
  end
  
  def day_of_month
    return @_day_of_month if @_day_of_month
    schedule_yml = YAML::load(schedule.to_yaml)
    begin
      return schedule_yml[:rrules][0][:validations][:day_of_month][0].to_i
    rescue
      return 1
    end
  end
  
  def day_of_month=(new_day_of_month)
    @_day_of_month = new_day_of_month
  end
  
  def valf_plans_valves_ids
    valf_plans.collect{|vp| vp.valf.id}
  end
  
  protected
  def update_schedule # create a schedule
    begin
      s = Schedule.new(start_date)
      case repeat
        when "Once"
          s.add_recurrence_date(start_date)
        when "Daily"
          s.rrule Rule.daily
        when "Weekly"
          raise "No weekday selected." if weekly.empty?
          s.rrule Rule.weekly.day(*weekly)
        when "Monthly"
          day = day_of_month.to_i
          if(day)
            s.rrule Rule.monthly.day_of_month(day)
          else
            raise "Unknown repeat type."
          end
        else
          raise "Unknown repeat type."
      end
      self.schedule= s
    rescue Exception => e
      errors.add(:schedule, I18n.t("errors.messages.invalid_type") )
    end
  end

  def validate_schedule
      errors.add(:schedule, I18n.t("errors.messages.blank") ) if schedule == nil
  end
  def validate_end_date_before_start_date
    if end_date && start_date
      errors.add(:end_date, "End date should be later than start date.") if end_date < start_date
    end
  end
  
end
