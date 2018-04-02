class CreateUploadFields < ActiveRecord::Migration
  def change
    create_table :upload_fields do |t|
      t.string :code
      t.string :text
      t.string :options
      t.integer :season_id

      t.timestamps
    end
  end
end
