class Api::V1::VenuesController < ApplicationController
    # respond_to :json
    
    def index
        @venues = Array.new
        
        #Iterate over each event
        Venue.all.each do |venue|
            
            if (venue.latitude != nil) && (venue.longitude != nil) && (venue.address1 != nil) 
                @venues.push(venue)
            end
            
        end    
        
        render :json => @venues

    end
    
    def search
        @venues = Array.new
        #for now I am not returning the events array but in the future will
        @events = Array.new
        
        if (params[:types] != nil)
            types = params[:types].split('|')
        else
            # To do --> Put this is a configuration file
            types = ['pollsite','venue','citibike','liquor_license_applicant']
        end
        
     
        locations = params[:location].split(',')
        if (locations[0] != nil)
            latitude = locations[0]
            #Rails.logger.warn "Latitude #{latitude}"
            
        end
        
        if (locations[1] != nil)
            longitude = locations[1]
            #Rails.logger.warn "Longitude #{longitude}"
        end
        
        if ((params[:radius]) != nil)
            radius = (params[:radius]).to_f
            radius = radius/1000
        else
            #set default radius to 1 kilometer
            radius = 1
        end
        
        Venue.near([latitude, longitude], radius, :units => :km).each do |venue|
            if (types.include?venue.venue_type) 
                #only return venues we can put to a map
                
                #if (venue.latitude != nil) && (venue.longitude != nil) && (venue.address1 != nil)
                if (venue.latitude != nil) && (venue.longitude != nil) 
                    
                    #add events from this event to events list
                    venue.events.each do |event|
                        #to do -- join venue lat and lon to event such that events 
                        @events.push(event)
                    end
                    @venues.push(venue)
                end
            end

        end
        
        render :json => @venues.as_json
        
        # Alternate versions I have used to get JSON working
        #render :json => [{:venues => @venues}]
        #render :json => {:venues => @venues, :events => @events}
        #render :json => [{:venues => @venues, :events => @events}]

    end
    
    
    
    def show
        @venues = Venue.find(params[:id])
        render :json => @venues
        #respond_with Event.all
    end
    
    def create
        @venue = Venue.new(venue_params)
    
        @venue.save
        # from http://stackoverflow.com/questions/3792685/simply-returning-success-or-failure-from-ajax-call-in-rails
        respond_to do |format|
            msg = { :status => "ok", :message => "Venue Created", :html => "<b>Venue Created</b>" }
            format.json  { render :json => msg }

        end
        
        
        
    end
    
private
  def venue_params
    params.require(:venue).permit(:city)
  end
end


# See http://stackoverflow.com/questions/26493848/how-to-set-a-rails-database-to-provide-both-api-rails-services-and-regular-views
