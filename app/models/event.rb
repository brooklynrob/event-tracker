class Event < ActiveRecord::Base
      belongs_to :venue
      validates :event_title, presence: true, length: { minimum: 0 }

      
      def venue_name
            @venue = Venue.find_by_id(venue_id)
            return @venue.name
      end
      
      def venue_city
            @venue = Venue.find_by_id(venue_id)
            return @venue.city
      end
      
      def venue_latitude
            @venue = Venue.find_by_id(venue_id)
            return venue.latitude
      end
      
      def venue_longitude
            @venue = Venue.find_by_id(venue_id)
            return venue.longitude
      end
      
end
