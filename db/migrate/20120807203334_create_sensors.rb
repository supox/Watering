class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.string :identifier
      t.integer :port_index
      t.integer :sprinkler_id

      t.timestamps
    end
    add_index :sensors, :sprinkler_id
  end
end
