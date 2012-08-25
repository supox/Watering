class AddSensorTypeToSensor < ActiveRecord::Migration
  def change
    add_column :sensors, :sensor_type, :sensor
  end
end
