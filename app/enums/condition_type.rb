class ConditionType < ClassyEnum::Base
end

class ConditionType::GreaterThan < ConditionType
  def condition_meet?(val1,val2)
    val1 > val2
  end
end

class ConditionType::LessThan < ConditionType
  def condition_meet?(val1,val2)
    val1 < val2
  end
end

class ConditionType::Equal < ConditionType
  def condition_meet?(val1,val2)
    val1 == val2
  end
end

class ConditionType::NotEqual < ConditionType
  def condition_meet?(val1,val2)
    val1 != val2
  end  
end
