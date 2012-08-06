class CreateSprinklersUsers < ActiveRecord::Migration
  def change
    create_table :sprinklers_users do |t|
      t.integer :sprinkler_id
      t.integer :user_id

      t.timestamps
    end

    add_index :sprinklers_users, :sprinkler_id
    add_index :sprinklers_users, :user_id
    add_index :sprinklers_users, [:sprinkler_id, :user_id], unique: true
    
  end
end
