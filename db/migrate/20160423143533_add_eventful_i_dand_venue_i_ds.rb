class AddEventfulIDandVenueIDs < ActiveRecord::Migration
  def change
    rename_column :events, :seatgeekeventid, :seatgeek_eventid
    add_column :events, :seatgeek_venueid, :string
    add_column :events, :eventful_eventid, :string
    add_column :events, :eventful_venueid, :string
  end
end
