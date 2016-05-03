class CombineEventIdFields < ActiveRecord::Migration
  def change
    rename_column :events, :seatgeek_eventid, :event_sourceid
    rename_column :events, :seatgeek_venueid, :venue_sourceid
    remove_column :events, :eventful_eventid, :string    
    remove_column :events, :eventful_venueid, :string
  end
end
