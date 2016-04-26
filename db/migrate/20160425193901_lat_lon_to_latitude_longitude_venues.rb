class LatLonToLatitudeLongitudeVenues < ActiveRecord::Migration
  def change
    add_column :venues, :postal_code, :string, :limit => 20
    rename_column :venues, :lat, :latitude
    rename_column :venues, :lon, :longitude
    change_column :venues, :latitude, :decimal, {:precision=>10, :scale=>6}
    change_column :venues, :longitude, :decimal, {:precision=>10, :scale=>6}
    ## undo change to 4 in previous migration
    change_column :us_geos, :country_code, :string, :limit => 2
  end
end
