class CreateVenueTypeTable < ActiveRecord::Migration
  def change
    create_table :venue_type_tables do |t|
      t.string :venue_type
      t.string :state, :initial => :active
      t.index :venue_type, unique: true
    end
  end
end
