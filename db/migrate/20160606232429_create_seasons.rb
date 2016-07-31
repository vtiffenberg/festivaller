class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.text :extras
      t.boolean :current, default: false

      t.timestamps null: false
    end

    add_column :events, :season, :integer
    add_column :passes, :season, :integer
    add_column :registrants, :season, :integer
    add_column :discounts, :season, :integer

    add_index :events, :season
    add_index :passes, :season
    add_index :registrants, :season
    add_index :discounts, :season
  end
end
