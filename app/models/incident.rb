class Incident < ActiveRecord::Base
    acts_as_mappable
    reverse_geocoded_by :latitude, :longitude
end
