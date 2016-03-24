class CreateSubscriptors < ActiveRecord::Migration
  def change
    create_table :subscriptors do |t|
      t.string :name
      t.string :email
      t.integer :pass_id
      t.boolean :accredited

      t.timestamps null: false
    end
  end
end
