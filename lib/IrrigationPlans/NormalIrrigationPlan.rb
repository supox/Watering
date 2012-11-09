# require 'IrrigationPlans/NormalIrrigationPlan.rb'

class NormalIrrigationPlan
  attr_accessor :valves, :amount
  
  def initialize(valves, amount)
    @valves = valves
    @amount = amount
  end
  
  def valid_plan_for_sprinkler?(sprinkler)
    sprinkler.valves.select{|v| v.valf_type=="fertilization"}.any?
  end

  def get_valf_times
    @valves.collect{|v| [v, @amount] }
  end
    
  def to_json(*a)
    {
      "json_class"   => self.class.name,
      "data"         => {"valves" => @valves, "amount" => @amount }
    }.to_json(*a)
  end
 
  def self.json_create(o)
    new(o["data"]["valves"], o["data"]["amount"])
  end
end
