class CreateIncidentTypes < ActiveRecord::Migration
  def change
    create_table :incident_types do |t|
      t.string :incident_type, null: false
      # other columns
      t.timestamps
      #execute "ALTER TABLE incident_types ADD PRIMARY KEY (incident_type);"    
    end
  end
end