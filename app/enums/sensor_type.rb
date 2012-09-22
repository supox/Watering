class SensorType < ClassyEnum::Base
  def has_valf?
    false
  end
end

class SensorType::Temperature < SensorType
end

class SensorType::Pressure < SensorType
end

class SensorType::DifferentialPressure < SensorType
end

class SensorType::Humidity < SensorType
end

class SensorType::WaterMeter < SensorType
  def has_valf?
    true
  end
end

class SensorType::FertMeter < SensorType
  def has_valf?
    true
  end
end