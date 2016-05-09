/* global google */
/* global _ */
/**
 * mapscripts.js
 *
 * Derired from Computer Science 50 Problem Set 8 scripts.js
 */

// Google Map
var map;

// Make this dynamic
// Create a JSON query of active types

// TO DO post May 9 -- Change this to venue_types
var types= ["venue","pollsite","citibike","liquor_license_applicant"];

var event_types = ["sports","theater","festival","music","general"]

var incident_types = ["crash"];

// markers for map
var markers = [];

var incident_markers = [];

// info window
var info = new google.maps.InfoWindow();

// execute when the DOM is fully loaded
$(function() {

    // styles for map
    // https://developers.google.com/maps/documentation/javascript/styling
    var styles = [

        // hide Google's labels
        {
            featureType: "all",
            elementType: "labels",
            stylers: [
                {visibility: "off"}
            ]
        },

        // hide roads
        {
            featureType: "road",
            elementType: "geometry",
            stylers: [
                {visibility: "on"}
            ]
        }

    ];

   
    var options = {
        // center: {lat: 40.7159, lng: -73.9861}
        center: {lat: 40.7159, lng: -73.9861}, 
        disableDefaultUI: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        maxZoom: 20,
        panControl: true,
        styles: styles,
        zoom: 16,
        zoomControl: true
    };

    // get DOM node in which map will be instantiated
    var canvas = $("#map-canvas").get(0);

    // instantiate map
    map = new google.maps.Map(canvas, options);
    
    // configure UI once Google Map is idle (i.e., loaded)
    google.maps.event.addListenerOnce(map, "idle", configure);

});

/**
 * Adds marker for place to map.
 */

// TO DO AFTER MAY 9 --> Reman f
function addMarker(place)
{

    // Code built in part off of code at http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerwithlabel/1.1.9/examples/events.html
    var lat = Number(place.venue.latitude);
    var lng = Number(place.venue.longitude);
  
    var myLatLng = {lat:lat, lng:lng};
    
    var image = '../../assets/' + place.venue.venue_type + '-40x40.png';
    
    //var image = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';
    //var image = 'http://www.taperssection.com/avatars/phish_transparent.gif';
    //var image = 'img/phish_transparent.gif';
    
    var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        title: place.venue.name,
        icon: image
        
    });
    
    // Push Marker Into Array
    markers.push(marker);
    
    
    var content = "";
    
    $.getJSON("../../api/v1/events/search?venue_id="+place.venue.id)
        .done(function(data, textStatus, jqXHR) {
            if (data[0] !=null) {
                content += "<b>";
                content += place.venue.name;
                content += "</b><br><ul>";
                // Make this more dynamic around which fields are available
                // get iteration to work
                
                // sort events by date
                for (var i = 0; i < data.length; i++)
                {
  
                    // only show events after now and events with a datatime
                    //if ((data[i].event.datetime) && (data[i].event.datetime > Date())) {
                        // include event URL if it exists
                        // make this a modal that pops out
                        content += "<li><a href=/events/" + data[i].event.id + ">" + data[i].event.event_title+"</a></li>";
                        content += "<ul>";
                        // Get JQuery to format data right
                        //content += "<li>Date & Time:" + event.datetime;
                        
                        if (data[i].event.event_url) {
                            content += "<li><a href=" + data[i].event.event_url + " TARGET=_BLANK> More info/Tix </a></li>";
                            
                        }
                        content += "</ul></li>"
                       
                    //}
                    
            
                    
                        
                }
                content += "</ul>";
            }
            
            // No events were returned assocaited with the venue, so we will just show a picture 
            else {
                content += place.venue.name; 
                content += "<br><img src=../../assets/" + place.venue.venue_type + ".png>";
            }
            
            
            
            
        })
        
        .fail(function(jqXHR, textStatus, errorThrown) {
        content +=  place.venue.name; 
        content += "<br><img src=../../assets/" + place.venue.venue_type + ".png>";

        // log error to browser's console
        console.log(errorThrown.toString());
        });
        
    

    // derived from view-source:http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerwithlabel/1.1.9/examples/events.html
    // show infowindow on click   
    google.maps.event.addListener(marker, "click", function (e) { showInfo(marker, content); });

    
    // Double Click (Note Implemented)
    //var content_double_click = place.venue.name;
    //google.maps.event.addListener(marker, "dblclick", function (e) { showInfo(marker, content_double_click); });

}







// This is the incident marker 
function addIncidentMarker(place)
{

    // Code built in part off of code at http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerwithlabel/1.1.9/examples/events.html
    var lat = Number(place.incident.latitude);
    var lng = Number(place.incident.longitude);
  
    var myLatLng = {lat:lat, lng:lng};
    
    //var image = '../../assets/' + place.incident.incident_type + '-40x40.png';
    var image = '../../assets/crash-80x80.png';
    
    
    //var image = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';
    //var image = 'http://www.taperssection.com/avatars/phish_transparent.gif';
    //var image = 'img/phish_transparent.gif';
    
    var incident_marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        title: "Crash",
        icon: image
        
    });
    
    // Push Marker Into Array
    incident_markers.push(incident_marker);
    
    
    var content = "Fatal Crash";
    content += "Date (Month / Year)::&nbsp;" + place.incident.month + "/" + place.incident.year;
    content += "<br>Pedestrians Killed:&nbsp;" + place.incident.pedfatalities;
    content += "<br>Bikers Killed:&nbsp;" + place.incident.bikefatalities;
    content += "<br>Motorists Killed:&nbsp;" + place.incident.mvofatalities;
    


    google.maps.event.addListener(incident_marker, "click", function (e) { showInfo(incident_marker, content); });



}











/**
 * Configures application.
 */
function configure()
{
    // update UI after map has been dragged
    google.maps.event.addListener(map, "dragend", function() {
        update(types);
    });

    // update UI after zoom level changes
    google.maps.event.addListener(map, "zoom_changed", function() {
        update(types);
    });

    // remove markers whilst dragging
    google.maps.event.addListener(map, "dragstart", function() {
        removeMarkers();
        removeIncidentMarkers();
    });

    // configure typeahead
    // https://github.com/twitter/typeahead.js/blob/master/doc/jquery_typeahead.md
    $("#q").typeahead({
        autoselect: true,
        highlight: true,
        minLength: 1
    },
    {
        source: search,
        templates: {
            empty: "no places found yet",
            suggestion: _.template("<p><%- place_name %>, <%- admin_name1 %> <%- postal_code %></p>")
        }
    });

    // re-center map after place is selected from drop-down
    $("#q").on("typeahead:selected", function(eventObject, suggestion, name) {

        // ensure coordinates are numbers
        var latitude = (_.isNumber(suggestion.latitude)) ? suggestion.latitude : parseFloat(suggestion.latitude);
        var longitude = (_.isNumber(suggestion.longitude)) ? suggestion.longitude : parseFloat(suggestion.longitude);

        // set map's center
        map.setCenter({lat: latitude, lng: longitude});

        // update UI
        update(types);
    });

    // hide info window when text box has focus
    $("#q").focus(function(eventData) {
        hideInfo();
    });
    
    
    $("#form-type-selector").change(function(){
            types=[];
            $.each($("input[name='venue_type']:checked"), function(){            
                types.push($(this).val());
            });

            //console.log("Selected Types: " + types.join("|"));
            
            update(types);
        });
    
    

    // re-enable ctrl- and right-clicking (and thus Inspect Element) on Google Map
    // https://chrome.google.com/webstore/detail/allow-right-click/hompjdfbfmmmgflfjdlnkohcplmboaeo?hl=en
    document.addEventListener("contextmenu", function(event) {
        event.returnValue = true; 
        event.stopPropagation && event.stopPropagation(); 
        event.cancelBubble && event.cancelBubble();
    }, true);

    // update UI
    update(types);

    // give focus to text box
    $("#q").focus();
}

/**
 * Hides info window.
 */
function hideInfo()
{
    info.close();
}

/**
 * Removes markers from map.
 */



function removeMarkers()
{
    // derived from https://developers.google.com/maps/documentation/javascript/examples/marker-remove
    for (var i = 0; i < markers.length; i++)
    {
        markers[i].setMap(null);
        markers[i] = null;
    }
    
    markers = [];

}


function removeIncidentMarkers()
{
    // derived from https://developers.google.com/maps/documentation/javascript/examples/marker-remove
    for (var i = 0; i < incident_markers.length; i++)
    {
        incident_markers[i].setMap(null);
        incident_markers[i] = null;
    }
    
    incident_markers = [];

}


/**
 * Searches database for typeahead's suggestions.
 */
function search(query, cb)
{
    // get places matching query (asynchronously)
    var parameters = {
        geo: query
    };
    //$.getJSON("https://ide50-runderwood5.cs50.io/search.php", parameters)
    $.getJSON("../api/v1/us_geos/search", parameters)
    
    .done(function(data, textStatus, jqXHR) {

        // call typeahead's callback with search results (i.e., places)
        cb(data);
    })
    .fail(function(jqXHR, textStatus, errorThrown) {
        
        // log error to browser's console
        console.log(errorThrown.toString());
    });
}

/**
 * Shows info window at marker with content.
 */
function showInfo(marker, content)
{
    // start div
    var div = "<div id='info'>";
    if (typeof(content) === "undefined")
    {
        // http://www.ajaxload.info/
        div += "<img alt='loading' src='img/ajax-loader.gif'/>";
    }
    else
    {
        div += content;
    }

    // end div
    div += "</div>";

    // set info window's content
    info.setContent(div);

    // open info window (if not already open)
    info.open(map, marker);
}

/**
 * Updates UI's markers.
 */
function update(types) 
{
    // get map's bounds
    var locationCenter = map.getCenter();
    
    var latitude = locationCenter.lat();
    var longitude = locationCenter.lng();
    
    var searchLocation = latitude+","+longitude;

    

    types = types || ["all"];
    var typesString = types.join("|");


    // get places within bounds (asynchronously)
    var parameters = {
        types:typesString,
        location:searchLocation,
        radius:'1000.0'

    };
    
    
    var incident_parameters = {
        types:incident_types,
        location:searchLocation,
        radius:'1000.0'

    };
    
    
    // Add Venues
    $.getJSON("../../api/v1/venues/search", parameters)
    .done(function(data, textStatus, jqXHR) {

        // remove old markers from map
        removeMarkers();
        

        // add new markers to map
        for (var i = 0; i < data.length; i++)
        {
            addMarker(data[i]);
            // Add handling such that only markers are added for venues and events
        }
     })
     .fail(function(jqXHR, textStatus, errorThrown) {

         // log error to browser's console
         console.log(errorThrown.toString());
     });
     
     
     // Add Incidents
     
    $.getJSON("../../api/v1/incidents/search", incident_parameters)
    .done(function(data, textStatus, jqXHR) {

        // remove old markers from map
        removeIncidentMarkers();
        

        // add new markers to map
        for (var i = 0; i < data.length; i++)
        {
            addIncidentMarker(data[i]);
            // Add handling such that only markers are added for venues and events
        }
     })
     .fail(function(jqXHR, textStatus, errorThrown) {

         // log error to browser's console
         console.log(errorThrown.toString());
     });
     
     
     
     
     
     
}