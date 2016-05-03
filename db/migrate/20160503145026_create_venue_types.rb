class CreateVenueTypes < ActiveRecord::Migration
  def change
    create_table :venue_types do |t|
      t.string :type
      t.string :status

      t.timestamps null: false
      t.index :type, unique: true
    end
  end
end
