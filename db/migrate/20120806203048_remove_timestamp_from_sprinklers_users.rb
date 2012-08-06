class RemoveTimestampFromSprinklersUsers < ActiveRecord::Migration
  def up
    remove_column :sprinklers_users, :created_at
  end

  def down
  end
end
