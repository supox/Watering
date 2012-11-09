class CreateValfPlan < ActiveRecord::Migration
  def change
    # drop_table :sprinkler_plan_valves
    create_table :valf_plan do |t|
      t.integer :sprinkler_plan_id
      t.integer :valf_id
      t.decimal :amount
      t.timestamps
    end
    add_index :valf_plan, :sprinkler_plan_id
    add_index :valf_plan, [:sprinkler_plan_id, :valf_id], unique: true
  end
end
