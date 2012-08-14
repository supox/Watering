class ChangeReadTimeOfSensorReadings < ActiveRecord::Migration
  def up
    remove_column :sensor_readings, :read_time
    add_column :sensor_readings, :read_time, :datetime
  end

  def down
  end
end
