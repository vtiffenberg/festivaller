class DropDiscounts < ActiveRecord::Migration
  def up
    drop_table :discounts
  end

  def down
    create_table :discounts do |t|
      t.datetime :start
      t.datetime :end
      t.string :name
      t.float :percentage
    end
  end
end
