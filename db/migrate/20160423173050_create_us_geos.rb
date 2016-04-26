class CreateUsGeos < ActiveRecord::Migration
  def change
    create_table :us_geos do |t|
      t.string :country_code, :limit => 2
      t.string :postal_code, :limit => 20
      t.string :place_name
      t.string :admin_name1
      t.string :admin_code1 
      t.string :admin_name2 
      t.string :admin_code2
      t.string :admin_name3
      t.string :admin_code3
      # http://stackoverflow.com/questions/1196174/correct-datatype-for-latitude-and-longitude-in-activerecord
      t.decimal :lat, {:precision=>10, :scale=>6}  
      t.decimal :lon, {:precision=>10, :scale=>6}  
      # see https://gist.github.com/icyleaf/9089250
      t.integer :accuracy, :limit => 1 


      t.timestamps null: false
    end
  end
end
