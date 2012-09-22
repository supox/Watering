class SprinklerLogType < ClassyEnum::Base
end

class SprinklerLogType::StartIrrigation < SprinklerLogType
end

class SprinklerLogType::EndIrrigation < SprinklerLogType
end

class SprinklerLogType::NoCommunication < SprinklerLogType
end
