class EventVenueForeignKey < ActiveRecord::Migration
  def change
    add_column :events, :venue_id, :integer
    add_foreign_key :events, :venues
  end
end
