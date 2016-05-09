class Api::V1::IncidentsController < ApplicationController
  def index
    @incidents = Incident.all
    render :json => @incidents
  
  end  
  
  
  def search
    @incidents = Array.new
      if (params[:types] != nil)
        types = params[:types].split('|')
      else
        # To do --> Put this is a configuration file
        types = ['crash']
      end
            
      locations = params[:location].split(',')
      if (locations[0] != nil)
        latitude = locations[0]
      end
        
      if (locations[1] != nil)
        longitude = locations[1]
      end
        
      if ((params[:radius]) != nil)
        radius = (params[:radius]).to_f
        radius = radius/1000
      else
        #set default radius to 1 kilometer
        radius = 1
      end
      
      #Geocoder not yet working with Incidents -- need to fix this post May 9 
      Incident.near([latitude, longitude], radius, :units => :km).each do |incident|
      #Incident.all.each do |incident|
        #if (types.include?incident.incident_type) 
          if (incident.latitude != nil) && (incident.longitude != nil) 

            @incidents.push(incident)
          end
        #end
      end

      render :json => @incidents

  end

end

