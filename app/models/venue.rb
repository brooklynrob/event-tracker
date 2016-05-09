include Geokit::Geocoders
class Venue < ActiveRecord::Base
    acts_as_mappable
    reverse_geocoded_by :latitude, :longitude
    #See http://stackoverflow.com/questions/7865281/rails-geocoder-undefined-method-error
    #after_validation :reverse_geocode  # auto-fetch address
    has_many :events
    
    
    def venue_events
        @events = Event.find_by_venue_id(id)
        return @events
    end
end