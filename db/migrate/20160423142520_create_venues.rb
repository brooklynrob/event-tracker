class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.float :lat
      t.float :lon
      t.string :seatgeek_venueid
      t.string :eventful_venueid 
      t.string :venue_source

      t.timestamps null: false
    end
  end
end
