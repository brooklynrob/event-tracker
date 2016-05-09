class AddEventSourceField < ActiveRecord::Migration
  def change
    add_column :events, :event_source, :string
  end
end
