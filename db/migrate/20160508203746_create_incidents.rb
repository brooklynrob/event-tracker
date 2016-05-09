class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.integer :mvofatalities
      t.integer :pedfatalities
      t.integer :bikefatalities
      t.integer :month
      t.integer :year   
      t.decimal :latitude, {:precision=>10, :scale=>6}
      t.decimal :longitude, {:precision=>10, :scale=>6}
      #t.has_one incident_types
      t.timestamps null: false
    end
  end
end
