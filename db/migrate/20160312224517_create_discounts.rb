class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.datetime :start
      t.datetime :end
      t.float :percentage
    end
  end
end
