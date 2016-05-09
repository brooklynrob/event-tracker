class RenameEventUrlField < ActiveRecord::Migration
  def change
       rename_column :events, :seatgeek_eventurl, :event_url
  end
end