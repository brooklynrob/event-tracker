require 'csv'
namespace :import_us_geos_csv do
    task :create_us_geos => :environment do
        #filename = 'US-test.txt'
        #csv = CSV.new(filename,:col_sep => '\t')
        
        CSV.foreach('US.txt', {:col_sep => "\t"}) do |row|
            if row[11] == nil
                accuracy = 0
            else
                accuracy = row[11]
            end
        UsGeo.create!(country_code:row[0],postal_code:row[1],place_name:row[2],admin_name1:row[3],admin_code1:row[4],admin_name2:row[5],admin_code2:row[6],admin_name3:row[7],admin_code3:row[8],latitude:row[9],longitude:row[10],accuracy:accuracy)
    
    end
end

end

# rake import_us_geos_csv:create_us_geos