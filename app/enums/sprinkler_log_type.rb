class SprinklerLogType < ClassyEnum::Base
  def has_port?
    return true
  end
end

class SprinklerLogType::StartIrrigation < SprinklerLogType
end

class SprinklerLogType::EndIrrigation < SprinklerLogType
end

class SprinklerLogType::NoCommunication < SprinklerLogType
  def has_port?
    return false
  end
end
