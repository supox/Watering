class CreateValves < ActiveRecord::Migration
  def change
    create_table :valves do |t|
      t.string :identifier
      t.integer :port_index
      t.integer :sprinkler_id

      t.timestamps
    end
    add_index :valves, :sprinkler_id
  end
end
