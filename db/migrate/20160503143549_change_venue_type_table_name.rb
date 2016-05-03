class ChangeVenueTypeTableName < ActiveRecord::Migration
  def change
    rename_table :venue_type_tables, :venue_types
  end 
end