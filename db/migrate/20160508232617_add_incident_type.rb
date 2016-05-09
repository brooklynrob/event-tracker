class AddIncidentType < ActiveRecord::Migration
  def change
    add_column :incidents, :incident_type, :string
  end
end
