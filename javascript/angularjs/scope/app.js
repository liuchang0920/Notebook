angular.module('scopeExample', [])
.controller('MyController', ['$scope', function($scope) {
    $scope.username = 'word';
    $scope.sayHello = function() {
        $scope.greeting = 'hello ' + $scope.username + '!';
    };
}])
.controller('GreetController', ['$scope', '$rootScope', function($scope, $rootScope) {
    $scope.name = 'world';
    $rootScope.department = 'angularjs';
}])
.controller('ListController', ['$scope', function($scope) {
    $scope.names = ['Igor', 'Misko', 'Vojta'];
}]);
