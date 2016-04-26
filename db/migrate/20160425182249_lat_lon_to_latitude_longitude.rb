class LatLonToLatitudeLongitude < ActiveRecord::Migration
  def change
    rename_column :us_geos, :lat, :latitude
    rename_column :us_geos, :lon, :longitude   
  end
end
