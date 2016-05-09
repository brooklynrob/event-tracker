class Api::V1::UsGeosController < ApplicationController
    # This class fills a similar role to the the PHP controller in PSET8 that returned a list of places to the JavaScript maps
    
    def search

    # Create an array to hold place results
    @places = Array.new
   
    # Example query --> /places/search/?geo=11217 -->  UsGeo.find_by postal_code: '11217'
    
    @places = UsGeo.where place_name:(params[:geo])
    
    #@places = UsGeo.where("place_name LIKE ?", "%#{params[:geo]}%")
    #@places = @places << UsGeo.where("postal_code LIKE ?", "%#{params[:geo]}%")
  
    
    render :json => @places.as_json(root: false, :except => ['created_at', 'updated_at']) 

    end 


end