# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# json = ActiveSupport::JSON.decode(File.read('db/seat-geek-json-test1.json'))
# json = ActiveSupport::JSON.decode(URI.read('https://api.seatgeek.com/2/events?venue.state=NY'))


#print json

# from https://www.twilio.com/blog/2015/10/4-ways-to-parse-a-json-api-with-ruby.html


# Read from model the sources

#json_url = ['http://api.eventful.com/json/events/search?app_key=LF6rm2crQzTbMZ2X&location=New+York', 'https://api.seatgeek.com/2/events?venue.state=NY']

seed_sources =
[  
    {
        "source"=> "eventful",
        "api_url"=> "http://api.eventful.com/json/events/search?app_key=LF6rm2crQzTbMZ2X&location=New+York,NY",
        "api_key"=> "LF6rm2crQzTbMZ2X"
        
    },
    {
        "source"=> "eventful",
        "api_url"=> "http://api.eventful.com/json/events/search?app_key=LF6rm2crQzTbMZ2X&location=Brooklyn,NY",
        "api_key"=> "LF6rm2crQzTbMZ2X"
        
    },
    
    {
        "source"=> "seatgeek",
        "api_url"=> "https://api.seatgeek.com/2/events?venue.city=Brooklyn&venue.state=NY&client_id=NDUzMzM5MHwxNDYwNzQzNTQ1&per_page=500",
        "api_key"=> "NDUzMzM5MHwxNDYwNzQzNTQ1"
    },
    {
        "source"=> "seatgeek",
        "api_url"=> "https://api.seatgeek.com/2/events?venue.city=New+York&venue.state=NY&client_id=NDUzMzM5MHwxNDYwNzQzNTQ1&per_page=500",
        "api_key"=> "NDUzMzM5MHwxNDYwNzQzNTQ1"
    },

    {
        "source"=> "seatgeek",
        "api_url"=> "https://api.seatgeek.com/2/events?venue.city=New+York+City&venue.state=NY&client_id=NDUzMzM5MHwxNDYwNzQzNTQ1&per_page=500",
        "api_key"=> "NDUzMzM5MHwxNDYwNzQzNTQ1"
    },
    
    
    {
        "source"=> "seatgeek",
        "api_url"=> "https://api.seatgeek.com/2/events?venue.state=NY&client_id=NDUzMzM5MHwxNDYwNzQzNTQ1&per_page=300",
        "api_key"=> "NDUzMzM5MHwxNDYwNzQzNTQ1"
    },
    
    {
        "source"=> "seatgeek",
        "api_url"=> "https://api.seatgeek.com/2/events?venue.state=NJ&client_id=NDUzMzM5MHwxNDYwNzQzNTQ1&per_page=200",
        "api_key"=> "NDUzMzM5MHwxNDYwNzQzNTQ1"
    },
    


    {
        "source"=> "nyc_pollsites",
        "api_url"=> "https://data.cityofnewyork.us/resource/mifw-tguq.json?$$app_token=eyT06TKDbCr7PdVYa9PT51eRO",
        "api_key"=> "eyT06TKDbCr7PdVYa9PT51eRO"
    },
    {
        "source"=> "citibike",
        "api_url"=> "https://feeds.citibikenyc.com/stations/stations.json",
        "api_key"=> ""
    },
    {
        "source"=> "NYS-Liquor-Authority",
        "api_url"=> "https://data.ny.gov/resource/2kid-jvyk.json",
        "api_key"=> ""
    },
    
    {
        "source"=> "DOT-Crash-Data",
        "api_url"=> "http://www.nyc.gov/html/dot/downloads/misc/fatality_all_monthly.json",
        "api_key"=> ""
    }
    #{
    #    "source"=> "CEC13-Calendar",
    #    "api_url"=> "https://www.googleapis.com/calendar/v3/calendars/r143km8mg3fnd385nga52llkr8@group.calendar.google.com/events?key=AIzaSyBMv1FIy9Dvr_Na8DluqgXL3JRpGhtJVSU&timeMin=2016-05-03T10:00:00Z",
    #    "api_key"=> "AIzaSyBMv1FIy9Dvr_Na8DluqgXL3JRpGhtJVSU"
    #}
    
]

seed_sources.each do |seed|
  
  puts  "The source is #{seed['source']}"
  source = seed['source']
  puts  "The API URL is #{seed['api_url']}"
  api_url = seed['api_url']
  api_key = seed['api_key']
  #ApiDataSource.create!(name:source,shortname:source,api_url:api_url,api_key:api_key)
    datasource = ApiDataSource.find_or_initialize_by(shortname:source)
      datasource.name = source
      datasource.api_url = api_url
      datasource.api_key = api_key
    datasource.save!

  
  uri = URI(api_url)
  response = Net::HTTP.get(uri)
  json_response = JSON.parse(response)
  

  case source
    when "CEC13-Calendar"
    if (liquor_license_applicant['license_type_code'] == "OP") && (liquor_license_applicant['license_received_date'] > (Time.now - (60 * 60 * 24 * 90)))     
      venue = Venue.find_or_initialize_by(venue_sourceid:liquor_license_applicant['license_certificate_number'])
        venue.name = liquor_license_applicant['premises_name']
        venue.address1 = liquor_license_applicant['actual_address_of_premises_address1']
        venue.city = liquor_license_applicant['city']
        venue.state = "NY"
        fulladdress = liquor_license_applicant['actual_address_of_premises_address1'] + "," + liquor_license_applicant['city'] + "," + venue.state
        latlng = Geocoder.coordinates(fulladdress)
        json_response['items'].each do |event|
        unless (event['location'].nil? != 'nil')
          #either initialize or find venue based name
          venue = Venue.find_or_initialize_by(name:event['location'])
          # To do -- make this get parsed into an actual address -- can geocoder do this?
          venue.address1 = liquor_license_applicant['actual_address_of_premises_address1']

          #Need to..
          ##Update the model to have venue_types and it be one to many between venue and venue_types
          ##Also do a configuation to map events 
      
          event = Event.find_or_initialize_by(event_sourceid:event['id'])
          # set foreign key in event table to venue
          event.venue_id = venue.id
          event.venue_sourceid = venue.venue_sourceid
      
          event.event_url = event['url']
          event.datetime = event['start_time']
          event.event_title = event_title
          event.event_source = source
        end #end unless
      end #end do
    end #end if


    when "DOT-Crash-Data"
      json_response['features'].each do |crash|
        incident = Incident.find_or_initialize_by(latitude:crash['geometry']['coordinates'][1],longitude:crash['geometry']['coordinates'][0], month:crash['properties']['MN'], year:crash['properties']['YR'])
        incident.mvofatalities = crash['properties']['MVOFatalit']
        incident.bikefatalities = crash['properties']['BikeFatali']
        incident.pedfatalities = crash['properties']['PedFatalit']
        incident.incident_type = "crash"
        incident.save!
      end #end each do


    when "nyc_pollsites"
      json_response.each do |pollsite|
      venue = Venue.find_or_initialize_by(venue_sourceid:pollsite['site_number'])
      # Some polling places to do not have a location array which includes lat and long. In future releases may call out to get this
      if (pollsite['location'] != nil)
        venue.name = pollsite['site_name']
        venue.address1 = pollsite['street_name']
        venue.latitude = pollsite['location']['latitude']
        venue.longitude = pollsite['location']['longitude']
        venue.city = pollsite['city']
        venue.venue_source = source 
        venue.venue_type = "pollsite"
      end
      # Only save complete records
      if (venue.name != nil) && (venue.address1 != nil) && (venue.latitude != nil) && (venue.longitude != nil) && (venue.city != nil)
        venue.save!
      end
    end
    
    
     when "NYS-Liquor-Authority"
      json_response.each do |liquor_license_applicant|
      #if application received in last 30 days && applications is on premises
      if (liquor_license_applicant['license_type_code'] == "OP") && (liquor_license_applicant['license_received_date'] > (Time.now - (60 * 60 * 24 * 90)))     
        venue = Venue.find_or_initialize_by(venue_sourceid:liquor_license_applicant['license_certificate_number'])
        venue.name = liquor_license_applicant['premises_name']
        venue.address1 = liquor_license_applicant['actual_address_of_premises_address1']
        venue.city = liquor_license_applicant['city']
        venue.state = "NY"
        fulladdress = liquor_license_applicant['actual_address_of_premises_address1'] + "," + liquor_license_applicant['city'] + "," + venue.state
        latlng = Geocoder.coordinates(fulladdress)

        
        #print venue.name  + "\n"
        #print latlng  + "\n"
        #print (latlng[0])
        
        latitude = BigDecimal.new((latlng[0]),6)
        #print latitude + "\n"
        venue.latitude = latitude
        #print venue.latitude + "\n"
        
        longitude = BigDecimal.new((latlng[1]),6) 
        #print longitude + "\n"
        venue.longitude = longitude 
        #print venue.longitude  + "\n"
        
        venue.venue_source = source 
        venue.venue_type = "liquor_license_applicant"

        # Only save complete records
        if (venue.name != nil) && (venue.address1 != nil) && (venue.latitude != nil) && (venue.longitude != nil)
          # print "About to save " + liquor_license_applicant['premises_name'] + "\n"
          venue.save!
        end
      end  
    end
      
      
    
    
    
    
    
    
    
    
    when "citibike"
      json_response['stationBeanList'].each do |citibike|
      id = citibike['id']
      venue = Venue.find_or_initialize_by(venue_sourceid:id)

        venue.name = "Citibike @ " + citibike['stAddress1']
        venue.address1 = citibike['stAddress1']
        venue.latitude = citibike['latitude']
        venue.longitude = citibike['longitude']
        venue.city = citibike['city']
        venue.venue_source = source 
        venue.venue_type = "citibike"

      # Only save complete records
      if (venue.name != nil) && (venue.address1 != nil) && (venue.latitude != nil) && (venue.longitude != nil)
        venue.save!
      end
    end
    
    
    
  
    when "eventful"
      json_response['events']['event'].each do |event|
        
      event_title = event['title']
      venue_sourceid = event['venue_id']
        
      # Create and Update Venues from Eventful
        
      venue = Venue.find_or_initialize_by(venue_sourceid:event['venue_id'])
      venue.name = event['venue_name']
      venue.address1 = event['venue_address']
      venue.city = event['city_name']
      venue.state = event['region_name']
      venue.latitude = event['latitude']
      venue.longitude = event['longitude']
      
      venue.venue_source = source 
      venue.venue_type = "venue"
      
      venue.save!  
        
    
      #Event.create!(datetime:event['start_time'],eventful_eventid:event['id'], event_title: event['title'], event_city: event['city_name'])
      unless event_title.nil? && venue_sourceid.nil?
        event = Event.find_or_initialize_by(event_sourceid:event['id'])
        # set foreign key in event table to venue
        event.venue_id = venue.id
        event.venue_sourceid = venue.venue_sourceid
        
        event.event_url = event['url']
        event.datetime = event['start_time']
        event.event_title = event_title
        event.event_source = source

        event.save!
      end    
    end
    
    
    when "seatgeek"
  
        # This should be a dynamic function
        json_response['events'].each do |event|
          
        venue_sourceid = event['venue']['id']
        event_title = event['title']
        event_url = event['url']


        
        # Create and Update Venues
        
        venue = Venue.find_or_initialize_by(venue_sourceid:event['venue']['id'])
        venue.name = event['venue']['name']
        venue.city = event['venue']['city']
        venue.state = event['venue']['state']
        venue.country = event['venue']['country']
        venue.latitude = event['venue']['location']['lat']
        venue.longitude = event['venue']['location']['lon']
        venue.postal_code = event['venue']['postal_code']
        venue.venue_source = source 
        venue.venue_type = "venue"
        venue.save!

          

        
        #Event.create!(datetime:event['datetime_local'],seatgeek_eventid:event['id'], event_title: event['title'], seatgeek_venueid:event['venue']['id'])
        #Venue.create!(seatgeek_venueid:event['venue']['id'],city:event['venue']['city'],state:event['venue']['state'])
        unless event_title.nil? && venue_sourceid.nil?
          event = Event.find_or_initialize_by(event_sourceid:event['id'])
          event.venue_id = venue.id
          event.venue_sourceid = venue.venue_sourceid
          
          event.datetime = event['datetime_local']
          event.event_title = event_title
          event.event_url = event_url
          event.event_source = source
          event.save!
        end
        
    end

      
  end

  
print "END OF SEED! \n"

# https://hackhands.com/ruby-read-json-file-hash/

#json.each do |a|
  #Event.create!(a['title'], without_protection: true)
#end

#  Event.create!(a.slice(:title))
# end

# http://stackoverflow.com/questions/28374671/unable-to-seed-database-in-rails-tutorial
end



