class CreateValfPlans < ActiveRecord::Migration
  def change
    drop_table :valf_plan
    create_table :valf_plans do |t|
      t.integer :sprinkler_plan_id
      t.integer :valf_id
      t.decimal :amount

      t.timestamps
    end
    add_index :valf_plans, :sprinkler_plan_id
    add_index :valf_plans, [:sprinkler_plan_id, :valf_id], unique: true    
  end
end
