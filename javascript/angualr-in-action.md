

## JIT

just in time compilation:

everything is loaded and redender on the demand in the browser.

https://en.wikipedia.org/wiki/Just-in-time_compilation

 no idea..
 
## Directive

think of them s attrivutes on the HTML eleemnts that cause th eelement to change its behavior, such as the 'disabled' attribute that disables an HTML input element.


## Interface (接口)

a means to enforce a class contains a required methods (eg: ngOnInit)
 

## Constructor

we don't load data from the service in the constructor for a number of reasons.


The constructor fires early in the rendering of a component, which means that often, values are not yet ready to be consumed. 
Components expose a number of lifecycble hooks that allow you to execute commands at various stages of rendering, giving you greater control over when things occur.

recommend: use ngOnINit() hook to call the service.

异步操作的话，推荐放到ngOnInit函数里去，同步的可以放到constructor 里



## Entity in Angular

* Modules
* Components
* Directives
* Pipes
* Services


### Declarations array

contains a list of all components and directives that the application's main module want to make available to th entire aplication

### Providers array
contains a list of the services that you want to make available to the whole application

### imports array
constains a list of the other modules that this module depends upon. if no modules loading, this is the first place to check to see if it's being registered with Angular


## Components

> Principles in angular
* encapsulation, logic isolated
* isolation, internal hidden
* reusability
* event-based, emit events during the lifecycle of the component
* customizable,
* declarative, component used with simple declarive markup


## Directives


* NgClass
* NgStyle
* NgIf
* NgFor
* NgSwitch

## Pipes
`

{{user.registered_date | date:'shortDate'}}

`

using a pipe changes the way the data is rendered. but it doesn't change the value of the property.


## Services



## Compilers

* JIT: just in time
* AOT: ahead of time  推荐的

## Dependency injection
There is a need for angular to be able to keep track of what parts of the application need a particular service.

Four importantat key pieces:

* Injector: often at work behind the scenes, but occasionally used directly
* Providers: creating thge instance of the object requested. The injector know the list of available providers, and based on the name, it calls a factory function from the provider and returns the requested object.


## Change detectin




 
