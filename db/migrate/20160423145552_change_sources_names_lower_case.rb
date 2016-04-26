class ChangeSourcesNamesLowerCase < ActiveRecord::Migration
  def change
    rename_column :api_data_sources, :API_URL, :api_url
    rename_column :api_data_sources, :API_KEY, :api_key    
  end
end
