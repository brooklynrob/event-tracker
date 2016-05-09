class ChangeIncidentTypeName < ActiveRecord::Migration
  def change
      rename_column :incident_types, :type, :incident_type
  end
end
