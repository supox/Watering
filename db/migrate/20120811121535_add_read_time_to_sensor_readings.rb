class AddReadTimeToSensorReadings < ActiveRecord::Migration
  def change
    add_column :sensor_readings, :read_time, :integer
  end
end
