
angular.module('myApp', [])
.controller("MyController", ['$scope', 'notify', function($scope, notify) {
    $scope.callNotify = function(mesg) {
        notify(mesg);
    }
}])
.factory('notify', ['$window', function(wins) { // 这里应该是按照顺序传入函数的
    var msgs = [];
    return function(msg) {
        msgs.push(msg);
        if(msgs.length === 3) {
            wins.alert(msgs.join('\n'));
            msgs = [];
        }
    };
}]);