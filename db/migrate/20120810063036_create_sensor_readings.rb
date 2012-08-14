class CreateSensorReadings < ActiveRecord::Migration
  def change
    create_table :sensor_readings do |t|
      t.integer :sensor_id
      t.integer :sensor_value

      t.timestamps
    end
    add_index :sensor_readings, :sensor_id
  end
end
