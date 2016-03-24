class RenameSubscriptorToRegistrant < ActiveRecord::Migration
  def change
    rename_table :subscriptors, :registrants
  end
end
