class PlacesController < ApplicationController
  
  def search
      #find active venues types
      #return active venues types
       
      @venue_types = Array.new
      VenueType.all.each do |venue_type|
        if (venue_type.venue_status = "active")
          @venue_types.push(venue_type)
        end
      end 
       
      render 'mapsearch'
  end
  
end
