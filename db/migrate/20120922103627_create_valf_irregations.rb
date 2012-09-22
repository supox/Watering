class CreateValfIrregations < ActiveRecord::Migration
  def change
    create_table :valf_irregations do |t|
      t.integer :valf_id
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :amount

      t.timestamps
    end
  end
end
