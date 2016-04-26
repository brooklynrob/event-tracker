class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_title
      t.string :event_city

      t.timestamps null: false
    end
  end
end
