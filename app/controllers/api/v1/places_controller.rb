class Api::V1::PlacesController < ApplicationController
    def search

    # Create an array to hold place results
    @places = Array.new
   
    # Example query --> /places/search/?geo=11217 -->  UsGeo.find_by postal_code: '11217'
    
    @places = UsGeo.where place_name:(params[:geo])
    
    #@places = UsGeo.where("place_name LIKE ?", "%#{params[:geo]}%")
    #@places = @places << UsGeo.where("postal_code LIKE ?", "%#{params[:geo]}%")
  
    
    render :json => @places.as_json(root: false, :except => ['created_at', 'updated_at']) 

    end 
    
    def update
        # ne=40.722983851932284%2C-73.90315319519044&q=&sw=40.6401904385614%2C-74.05644680480958
        sw = params[:sw].split(',')
        sw_latitude = sw[0]
        sw_longitude = sw[1]
        ne = params[:ne].split(',')
        ne_latitude = ne[0]
        ne_latitude = ne[1]

        #if (sw_longitude <= ne_latitude)
        #    SELECT * FROM places WHERE ? <= latitude AND latitude <= ? AND (? <= longitude AND longitude <= ?) GROUP BY country_code, place_name, admin_code1 ORDER BY RAND() LIMIT 10", $sw_lat, $ne_lat, $sw_lng, $ne_lng)

        #else
        #    SELECT * FROM places WHERE ? <= latitude AND latitude <= ? AND (? <= longitude OR longitude <= ?) GROUP_BY country_code, place_name, admin_code1 ORDER BY RAND() LIMIT 10", $sw_lat, $ne_lat, $sw_lng, $ne_lng)

        
        
        
    end

end