require 'json'

class IrrigationPlan < ClassyEnum::Base
end

class IrrigationPlan::NormalIrrigation < IrrigationPlan
  attr_accessor :valves, :amount
  def valid_plan_for_sprinkler?(sprinkler)
     sprinkler.valves.select{|v| v.valf_type=="normal"}.any?    
  end
end

class IrrigationPlan::Fertilization < IrrigationPlan
  attr_accessor :valves, :amount
  
  def initialize(valves, amount)
    @valves = valves
    @amount = amount  
  end
  
  def valid_plan_for_sprinkler?(sprinkler)
    sprinkler.valves.select{|v| v.valf_type=="fertilization"}.any?
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

class IrrigationPlan::Flushing < IrrigationPlan
  # TODO - not sure how to plan this...
  def valid_plan_for_sprinkler?(sprinkler)
    false
  end
end
