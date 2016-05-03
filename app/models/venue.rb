include Geokit::Geocoders
class Venue < ActiveRecord::Base
    acts_as_mappable
    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode  # auto-fetch address
    has_many :events
end