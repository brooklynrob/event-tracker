class CreateApiDataSources < ActiveRecord::Migration
  def change
    create_table :api_data_sources do |t|
      t.string :name
      t.string :shortname
      t.string :API_URL
      t.string :API_KEY

      t.timestamps null: false
    end
  end
end
