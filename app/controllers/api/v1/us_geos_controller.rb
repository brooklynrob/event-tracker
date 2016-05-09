class Api::V1::UsGeosController < ApplicationController
  def search
    # Create an array to hold place results
    @usgeos = Array.new
   
    # Example query --> /places/search/?geo=11217 -->  UsGeo.find_by postal_code: '11217'
    
    @usgeos = UsGeo.where place_name:(params[:geo])
    
    #@places = UsGeo.where("place_name LIKE ?", "%#{params[:geo]}%")
    #@places = @places << UsGeo.where("postal_code LIKE ?", "%#{params[:geo]}%")
  
    
    render :json => @usgeos.as_json(root: false, :except => ['created_at', 'updated_at']) 
    
  end
end
