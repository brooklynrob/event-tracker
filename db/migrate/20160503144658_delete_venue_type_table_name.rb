class DeleteVenueTypeTableName < ActiveRecord::Migration
  def change
    drop_table :venue_types
  end
end
