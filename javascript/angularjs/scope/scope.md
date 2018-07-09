# What are scopes?

scope is an object that refers to the application model. It is an execution contex tfor expressions. scopes are arranged in hierarchical structure which mimic the DOM structure of the application.

Scope can watch expressions and propagate events;

## Scope characteristics
Scopes provide APIs ($watch) to observe model mutations.

Scopes provide APIs ($apply) to propagate any model changes through the system into the view from outside of the "AngularJS realm" (controllers, services, AngularJS event handlers).

Scopes can be nested to limit access to the properties of application components while providing access to shared model properties. Nested scopes are either "child scopes" or "isolate scopes". A "child scope" (prototypically) inherits properties from its parent scope. An "isolate scope" does not. See isolated scopes for more information.

Scopes provide context against which expressions are evaluated. For example {{username}} expression is meaningless, unless it is evaluated against a specific scope which defines the username property.

## Scope as data-model

see example

## Scope hierarchies

Each angularjs has exactly one root scope, but may have any number of child scopes.

The application can have multiple scopes, because directives can create new child scopes. When new scopes are created, they are added as children of their parent scope. This creates a tree structure which parallels the DOM where they're attached.


## Retrieveing scopes from DOM
??

## Scope events propagation
Scopes can propagate events in similar fashion to DOM events.

The event can be broadcasted to the scope children or emitted to scope parents

```js
angular.module('eventExample', [])
.controller('EventController', ['$scope', function($scope) {
  $scope.count = 0;
  $scope.$on('MyEvent', function() {
    $scope.count++;
  });
}]);
```

```html

<div ng-controller="EventController">
  Root scope <tt>MyEvent</tt> count: {{count}}
  <ul>
    <li ng-repeat="i in [1]" ng-controller="EventController">
      <button ng-click="$emit('MyEvent')">$emit('MyEvent')</button>
      <button ng-click="$broadcast('MyEvent')">$broadcast('MyEvent')</button>
      <br>
      Middle scope <tt>MyEvent</tt> count: {{count}}
      <ul>
        <li ng-repeat="item in [1, 2]" ng-controller="EventController">
          Leaf scope <tt>MyEvent</tt> count: {{count}}
        </li>
      </ul>
    </li>
  </ul>
</div>
```



## Scope life cycle
The normal flow of a browser receiving an event is that it executes a corresponding js callback.

To properly process model modifications the execution has to enter the angualrjs execution context using the $apply methd. only model modifications which executes inside the $apply method will be properly accounted for by angularjs

啥？？

1. creation
the root scope is created during the application bootstrap by the $injector.
During template linking, some directives create new child scopes. ??

2. watcher registration
during template linking, directives register watches on the scope.
these watches will be used to progageate models values to the DOM

3. Model mutation
For mutations to be properly observed, you should make them only within the scope.$apply(). AngularJS APIs do this implicitly, so no extra $apply call is needed when doing synchronous work in controllers, or asynchronous work with $http, $timeout or $interval services.

4. Mutation observation ??
At the end of $apply, AngularJS performs a $digest cycle on the root scope, which then propagates throughout all child scopes. During the $digest cycle, all $watched expressions or functions are checked for model mutation and if a mutation is detected, the $watch listener is called.


5. Scope destruction
When child scopes are no longer needed, it is the responsibility of the child scope creator to destroy them via scope.$destroy() API. This will stop propagation of $digest calls into the child scope and allow for memory used by the child scope models to be reclaimed by the garbage collector.


## Scopes and directive

* Observing directives, such as double-curly expressions {{expression}}, register listeners using the $watch() method. This type of directive needs to be notified whenever the expression changes so that it can update the view.

* Listener directives, such as ng-click, register a listener with the DOM. When the DOM listener fires, the directive executes the associated expression and updates the view using the $apply() method.

## Directives that Create Scopes
....

## controllers and scopes

* Controllers use scopes to expose controller methods to templates (see ng-controller).
* Controllers define methods (behavior) that can mutate the model (properties on the scope).
* Controllers may register watches on the model. These watches execute immediately after the controller behavior executes.


## Scope $watch Performance Considerations

...


## Integration with the browser event loop

...
