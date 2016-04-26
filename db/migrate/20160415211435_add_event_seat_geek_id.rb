class AddEventSeatGeekId < ActiveRecord::Migration
  def change
    add_column :events, :seatgeekeventid, :string
  end
end
