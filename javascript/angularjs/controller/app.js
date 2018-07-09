// let angular = require('../angular-1.7.0/angular');

// var myApp = angular.module('spiceApp2', []);
// myApp.controller('SpicyController', ['$scope', function($scope) {
//     $scope.customSpice = 'wasabi';
//     $scope.spice = 'very';

//     $scope.spicy = function(spice) {
//         $scope.spice = spice;
//     }
// }])

var myApp = angular.module('scopeInheritance', []);
myApp.controller('MainController', ['$scope', function($scope) {
  $scope.timeOfDay = 'morning';
  $scope.name = 'Nikki';
}]);
myApp.controller('ChildController', ['$scope', function($scope) {
  $scope.name = 'Mattie';
}]);
myApp.controller('GrandChildController', ['$scope', function($scope) {
  $scope.timeOfDay = 'evening';
  $scope.name = 'Gingerbread Baby';
}]);
