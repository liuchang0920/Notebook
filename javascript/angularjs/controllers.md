
A controller is defined by a js constructor function that is used to augment the angular scope

controllers can be attached to the DOM in different ways. for each of them, angular js will instantiate a new controller object, using specified controller's constructor function.

if the controller has been attached using **controller as** syntax, then the controller instance will be assigned to a property on the scope.

Use controllers to:
    
    * set up the initial state of $scope object
    * add behavior to the $scope object

Do not use controllers to:

    * manipulate DOM -- controller shoudl only contain business logic
    * format input -- use form controls instead
    * filter output -- use filters instead
    * shared code or state across controllers -- use service instead
    * manage the life-cycle of other components

In general, a controller should't try to do too much.
the most common way to keep controllers slim is by encapsulating work that doesn;t belong to controllers into services and then using these services in controllers via dependency injection.

All the $scope properties will be available to the template at the point in the DOM where the controller is registered.

```js
var myApp = angualr.module('myApp', []);

myApp.controller('GreetingController', ['$scope', function($scope) {
  $scope.greeting = 'hello';
}]);

```


```html
<div ng-controller="GreetingController">
{{ greeting }}
</div>
```


## Simple spicy controller example

``` html


<div ng-controller="SpicyController">
 <button ng-click="chiliSpicy()">Chili</button>
 <button ng-click="jalapenoSpicy()">Jalapeño</button>
 <p>The food is {{spice}} spicy!</p>
</div>

```
``` js
 
var myApp = angualr.module('spicyApp1', []);

myApp.controller('SpicyController', ['$scope', function($scope) {
    $scope.spice = 'very';
    $scope.chiliSpicy = function() {
        $scope.spice = 'chili';
    };

    $scope.jalapenoSpicy = function() {
        $scope.spice = 'jalapeño';
    };
}]);

```
``` HTML


<div ng-controller="SpicyController">
 <button ng-click="chiliSpicy()">Chili</button>
 <button ng-click="jalapenoSpicy()">Jalapeño</button>
 <p>The food is {{spice}} spicy!</p>
</div>


```