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
        "api_url"=> "http://api.eventful.com/json/events/search?app_key=LF6rm2crQzTbMZ2X&location=New+York",
        "api_key"=> "LF6rm2crQzTbMZ2X"
        
    },
    {
        "source"=> "seatgeek",
        "api_url"=> "https://api.seatgeek.com/2/events?venue.state=NY",
        "api_key"=> "NDUzMzM5MHwxNDYwNzQzNTQ1"
    },
    {
        "source"=> "seatgeek",
        "api_url"=> "https://api.seatgeek.com/2/events",
        "api_key"=> "NDUzMzM5MHwxNDYwNzQzNTQ1"
    },
    {
        "source"=> "seatgeek",
        "api_url"=> "https://api.seatgeek.com/2/events?venue.state=NJ&client_id=NDUzMzM5MHwxNDYwNzQzNTQ1&per_page=30",
        "api_key"=> "NDUzMzM5MHwxNDYwNzQzNTQ1"
    },
    {
        "source"=> "seatgeek",
        "api_url"=> "https://api.seatgeek.com/2/events?venue.city=Brooklyn&venue.state=NY&client_id=NDUzMzM5MHwxNDYwNzQzNTQ1&per_page=30",
        "api_key"=> "NDUzMzM5MHwxNDYwNzQzNTQ1"
    }
    
]


   
seed_sources.each do |seed|
  
  puts  "Sources is #{seed['source']}"
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
    when "eventful"
      puts 'Eventful!\n'
        
      json_response['events']['event'].each do |event|
      event_title = event['title']
      print "Event title is " + event_title
      print "\n"
      print event['city_name']
      print "\n"
      #Event.create!(datetime:event['start_time'],eventful_eventid:event['id'], event_title: event['title'], event_city: event['city_name'])
          event = Event.find_or_initialize_by(eventful_eventid:event['id'])
          event.datetime = event['start_time']
          event.event_title = event_title
          event.eventful_venueid = event['venue_id']
          event.save!
          
      
      
      
    end
    
    when "seatgeek"
      puts 'Seatgeek!!\n'
      
        # This should be a dynamic function
        
        json_response['events'].each do |event|
        
        # Create and Update Venues
        
        venue = Venue.find_or_initialize_by(seatgeek_venueid:event['venue']['id'])
        venue.name = event['venue']['name']
        venue.city = event['venue']['city']
        venue.state = event['venue']['state']
        venue.state = event['venue']['country']
        venue.latitude = event['venue']['location']['lat']
        venue.longitude = event['venue']['location']['lon']
        venue.postal_code = event['venue']['postal_code']
        venue.save!

          
          
          
          
        
        event_title = event['title']
        print "Event title is " + event_title
        print "\n"
        
        seatgeek_venueid = event['venue']['id']
        print seatgeek_venueid 
        print "\n"
        
        eventurl = event['url']
        print "Event URL is "+ eventurl
        print "\n"
        
        #Event.create!(datetime:event['datetime_local'],seatgeek_eventid:event['id'], event_title: event['title'], seatgeek_venueid:event['venue']['id'])
        #Venue.create!(seatgeek_venueid:event['venue']['id'],city:event['venue']['city'],state:event['venue']['state'])
        unless event_title.nil? && seatgeek_venueid.nil?
          event = Event.find_or_initialize_by(seatgeek_eventid:event['id'])
          venue = Venue.find_by(seatgeek_venueid:seatgeek_venueid)
          event.datetime = event['datetime_local']
          event.event_title = event_title
          event.seatgeek_venueid = seatgeek_venueid
          event.seatgeek_eventurl = eventurl
          event.venue_id = venue.id
          event.save!
        end
        
        
        
 
        

        
    end
       
    else
      puts 'Nothing'
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

