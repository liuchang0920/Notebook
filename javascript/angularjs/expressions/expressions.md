

....


## Context
angular js expression do not have direct access to global variables like window, document or location. 

this restriction is intentional.
it prevents accidental access to the global state

Instead use services like $window and $location in functions on controllers, which are then called from expressions. Such services provide mockable access to globals.

```html

<div class="example2" ng-controller="ExampleController">
  Name: <input ng-model="name" type="text"/>
  <button ng-click="greet()">Greet</button>
  <button ng-click="window.alert('Should not see me')">Won't greet</button>
</div>
```

## Forgiving

Expression evaluation is forgiving to undefined and null. In JavaScript, evaluating a.b.c throws an exception if a is not an object. While this makes sense for a general purpose language, the expression evaluations are primarily used for data binding, which often look like this:
{{ a.b.c }}

It makes more sense to show nothing than to throw an exception if a is undefined (perhaps we are waiting for the server response, and it will become defined soon). If expression evaluation wasn't forgiving we'd have to write bindings that clutter the code, for example: {{((a||{}).b||{}).c}}

>Similarly, invoking a function a.b.c() on undefined or null simply returns **undefined**.


## $Event??
...

## Onetime binding??
...