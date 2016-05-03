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

        #@urlstring_to_post = 'https://www.tran.sla.ny.gov/servlet/ApplicationServlet?pageName=com.ibm.nysla.data.publicquery.PublicQueryAdvanceTextResultsDownloadPage&validated=true'
        @urlstring_to_post = 'https://www.tran.sla.ny.gov/servlet/ApplicationServlet'
        
        #<input type="hidden" name="pageName" value="com.ibm.nysla.data.publicquery.PublicQueryAdvanceSearchPage">
        #<input type="hidden" name="validated" value="false">

        
        

        
        
        
        @venues = Array.new

        
        if (params[:types] != nil)
            types = params[:types].split('|')
        else
            types = ['pollsite','venue']
        end
        
        # This is a workaround for now -- want to fix this later
        #if types[0]='all'
        #    types = ['pollsite','venue']
        #end
     
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
            radius = 10
        end
        
        Venue.near([latitude, longitude], radius, :units => :km).each do |venue|
            if (types.include?venue.venue_type) 
                if (venue.latitude != nil) && (venue.longitude != nil) && (venue.address1 != nil)
                    @venues.push(venue)
                end
            end
     
            #Rails.logger.warn "venue #{venue}"
        end
        
        #@venues = Venue.where("venues.city LIKE ?", "%#{params[:geo]}%")
        #@venues = @venues << Venue.where("venues.postal_code LIKE ?", "%#{params[:geo]}%")
        

        
        
        
        #@venues = Venue.where city:(      params[:geo]    )
        #@venues = Venue.where city:("content LIKE ? %#{params[:geo]}%")
        

        
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
