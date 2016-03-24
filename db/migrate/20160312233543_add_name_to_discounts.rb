class AddNameToDiscounts < ActiveRecord::Migration
  def change
    add_column :discounts, :name, :string
  end
end
