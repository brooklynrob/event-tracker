class RenameVenueNameColumns < ActiveRecord::Migration
  def change
    rename_column :venue_types, :type, :venue_type
    rename_column :venue_types, :status, :venue_status
  end
end
