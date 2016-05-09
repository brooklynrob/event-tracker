class RemoveEventCityColumn < ActiveRecord::Migration
  def change
    remove_column :events, :event_city
  end
end