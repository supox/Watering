class CreateSprinklerLogs < ActiveRecord::Migration
  def change
    create_table :sprinkler_logs do |t|
      t.integer :sprinkler_id
      t.datetime :event_time
      t.string :event_type
      t.integer :port_index

      t.timestamps
    end
    add_index :sprinkler_logs, :sprinkler_id
  end
end
