class MakeCountyCodeLonger < ActiveRecord::Migration
  def change
    change_column :us_geos, :country_code, :string, :limit => 4
  end
end
