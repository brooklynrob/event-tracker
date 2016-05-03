class Api::V1::EventsController < ApplicationController
    # respond_to :json
    
    def index
        #@events = Event.all
       
       
        #Create new array
        @events = Array.new
        
        #Iterate over each event
        Event.all.each do |event|
            
            #Add a property that contains the venue as an array
            class << event
                attr_accessor :venue
            end
        event.venue = "hello"    
        #event.venue = Venue.where("id = event.venue_id")
        @events.push(event)
            
        end            

        

        #@events += [venue_name:"rob"]
        render :json => @events
        #respond_with Event.all
    end
    
    def search
        @events = Array.new
        #@venues = Venue.where city:(      params[:geo]    )
        #@venues = Venue.where city:("content LIKE ? %#{params[:geo]}%")
        
        # find all venues in that geo
        @venues = Venue.where("venues.city LIKE ?", "%#{params[:geo]}%")
        
        # iterate by venues and find events that are at the venue
        
        
        
        #Question.where("content LIKE ?" , "%#{farming}%")
        
        #@places = UsGeo.where place_name:(params[:geo])
    
        render :json => @venues.as_json(root: false, :except => ['created_at', 'updated_at']) 
    end
    
    
    
    def show
        @events = Event.find(params[:id])
        render :json => @events
        #respond_with Event.all
    end
    
    def create
        @event = Event.new(event_params)
    
        @event.save
        # from http://stackoverflow.com/questions/3792685/simply-returning-success-or-failure-from-ajax-call-in-rails
        respond_to do |format|
            msg = { :status => "ok", :message => "Event Created", :html => "<b>Event Created</b>" }
            format.json  { render :json => msg }

        end
        
        
        
    end
    
private
  def event_params
    params.require(:event).permit(:event_title, :event_city)
  end
end


# See http://stackoverflow.com/questions/26493848/how-to-set-a-rails-database-to-provide-both-api-rails-services-and-regular-views
