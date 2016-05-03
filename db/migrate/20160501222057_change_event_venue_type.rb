class ChangeEventVenueType < ActiveRecord::Migration
  def change
    rename_column :events, :type, :event_type
    rename_column :venues, :type, :venue_type
  end
end
