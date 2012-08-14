class CreateSprinklerPlans < ActiveRecord::Migration
  def change
    create_table :sprinkler_plans do |t|
      t.integer :sprinkler_id
      t.text :schedule
      t.datetime :start_date

      t.timestamps
    end
  end
end
