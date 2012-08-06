class RemoveUpdatedAtFromSprinklersUsers < ActiveRecord::Migration
  def up
    remove_column :sprinklers_users, :updated_at
  end

  def down
  end
end
