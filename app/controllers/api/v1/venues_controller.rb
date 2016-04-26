class Api::V1::VenuesController < ApplicationController
    # respond_to :json
    
    def index
        @venues = Venue.all
        render :json => @events

    end
    
    def search
        @venues = Array.new
        #@venues = Venue.where city:(      params[:geo]    )
        #@venues = Venue.where city:("content LIKE ? %#{params[:geo]}%")
        
        @venues = Venue.where("venues.city LIKE ?", "%#{params[:geo]}%")
        @venues = @venues << Venue.where("venues.postal_code LIKE ?", "%#{params[:geo]}%")
        
        #Question.where("content LIKE ?" , "%#{farming}%")
        
        #@places = UsGeo.where place_name:(params[:geo])
    
        render :json => @venues.as_json
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
