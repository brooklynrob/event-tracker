class CombineVenueIdFields < ActiveRecord::Migration
  def change
    rename_column :venues, :seatgeek_venueid, :venue_sourceid
    remove_column :venues, :eventful_venueid, :string
  end
end
