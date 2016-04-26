var eventTrackerApp = angular.module('eventTrackerApp', []);

eventTrackerApp.controller('EventListCtrl', function($scope, $http) {
  $http.get("/api/v1/events").success(function(response) {
    $scope.events = response;
    });
    
    $scope.removeEvent = function(row){
      $scope.events.splice($scope.events.indexOf(row),1);
    }


   // $scope.addEvent = function(row){
    //  return $http.post('/api/v1/events', row).success(function(row) {
    //    $scope.events.push({event_title: $scope.event_title, event_city:$scope.event_city});
  //    }

//    };
    

    
});