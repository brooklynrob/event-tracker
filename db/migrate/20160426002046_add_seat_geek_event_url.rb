class AddSeatGeekEventUrl < ActiveRecord::Migration
  def change
    add_column :events, :seatgeek_eventurl, :string
  end
end
