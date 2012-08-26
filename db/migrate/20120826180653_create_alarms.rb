class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.integer :sensor_id
      t.string :alarm_title
      t.integer :alarm_value
      t.string :condition_type

      t.timestamps
    end
    
    add_index :alarms, :sensor_id
  end
end
