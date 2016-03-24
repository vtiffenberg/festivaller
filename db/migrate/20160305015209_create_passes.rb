class CreatePasses < ActiveRecord::Migration
  def change
    create_table :passes do |t|
      t.string :name
      t.float :price
      t.text :description
      t.string :colour

      t.timestamps null: false
    end
  end
end
