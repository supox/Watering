class CreateSprinklers < ActiveRecord::Migration
  def change
    create_table :sprinklers do |t|
      t.string :identifier
      t.string :machine_version
      t.string :mac_address
      t.integer :refresh_rate_seconds
      t.string :ios
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :sprinklers, [ :mac_address ]
  end
end
