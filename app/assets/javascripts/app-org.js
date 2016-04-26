var eventTrackerApp = angular.module('eventTrackerApp', [])

eventTrackerApp.factory("EventService", function($http) {
    return {
        "getEvents": function() {
            return $http.get("/api/v1/events");
        }
    };
});


eventTrackerApp.controller('EventListCtrl', function ($scope) {
  $scope.events = [
    {event_title:'Jordan Brand Classic',event_city:'Brooklyn'},
    {event_title:'Business Meeting',event_city:'Manhattan'},
    {event_title:'Someplace cool',event_city:'Queens'},
    {event_title:'New York Yankees',event_city:'Bronx'}
  ];
  
  $scope.addPost = function() {
    $scope.events.push({event_title: $scope.event[event_title], event_city:$scope.event[event_city]});
    $scope.event_title = '';
    $scope.event_city = '';
    
  };
  
  

});