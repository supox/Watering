class ChangeSensorValueOfSensorReadings < ActiveRecord::Migration
  def up
    change_table :sensor_readings do |t|
      t.remove :sensor_value
      t.decimal :sensor_value
    end
  end

  def down
  end
end
