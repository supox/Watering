class IrrigationMode < ClassyEnum::Base
  def units
    :minutes
  end
end

class IrrigationMode::Time < IrrigationMode
  def units
    :minutes
  end
end

class IrrigationMode::Volume < IrrigationMode
  def units
    :liters
  end
end
