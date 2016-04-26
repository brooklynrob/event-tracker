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

json_url = ['http://api.eventful.com/json/events/search?app_key=LF6rm2crQzTbMZ2X&location=New+York', 'https://api.seatgeek.com/2/events?venue.state=NY']
json_url.each do |url_read|
  puts  "About to URL at #{url_read}"
end

url = 'https://api.seatgeek.com/2/events?venue.state=NY'
uri = URI(url)
response = Net::HTTP.get(uri)
json_response = JSON.parse(response)
#print json_response

print "\n"

# print json_response['events'].first['title']
# print json_response['events'].first['venue']['city']

# To do -- add update function

# Create
json_response['events'].each do |event|
    print event['title']
    print "\n"
    print event['venue']['city']
    print "\n"
    Event.create!(datetime:event['datetime_local'],seatgeekeventid:event['id'], event_title: event['title'], event_city: event['venue']['city'])
    
end


#http://api.eventful.com/json/events/search?app_key=LF6rm2crQzTbMZ2X&location=New+York


#print json_response['events'].title
#print json_response['response']['total_rows']

#event_title = json_response['events'].first['title']
#event_city = json_response['events'].first['venue']['city']
#Event.create!(event_title: event_title,
#           event_city: event_city)



print "\n"
#print json_response['id']

#json_response['json_response']['children'].each do |child|
#    puts child['data']['events']
#end


# https://hackhands.com/ruby-read-json-file-hash/



#json.each do |a|
  #Event.create!(a['title'], without_protection: true)
#end

#  Event.create!(a.slice(:title))
# end

# http://stackoverflow.com/questions/28374671/unable-to-seed-database-in-rails-tutorial

