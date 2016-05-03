class AddEventVenueType < ActiveRecord::Migration
  def change
    add_column :events, :type, :string
    add_column :venues, :type, :string
  end
end
