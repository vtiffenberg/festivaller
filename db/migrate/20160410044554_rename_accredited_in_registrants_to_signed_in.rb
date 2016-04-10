class RenameAccreditedInRegistrantsToSignedIn < ActiveRecord::Migration
  def change
    rename_column :registrants, :accredited, :signed_in
  end
end
