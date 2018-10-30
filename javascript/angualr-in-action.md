

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
略..

## Template expression and bindings

there are several ways angular uses template:

* interpolation: 
* attribute and property bindings: link data from componenet controller into attribute or properties of other elements
* event binding: bind event listener to elements
* directives: modify thebehavior or adding additional structure to elements
* pipes: formatting data before displayed

### Interpolation
花括号表达方式: {{ ... }}

### Property bindings

<img [src]="..." />

property bindings don't use the curly braces and evaluate everything inside the quotes as the expression..

... 的部分对应 controller的属性 或者 函数



restate: interpolation is a shortcut for a property binding to th etextContent property of an element.

> Using the [] syntax bind to an element's property, not the attributes.. properties are DOM's elemnt' property.

大小写也不同..

rowspan="{{rows}}"

等于

[rowSpan]="rows"

所以推荐用[] 的语法,避免用html那一套的东西,可能在debug的时候 花费多余的经历

### Special property bindings

个别的class name如果需要conditional的话:

```html
<h1 class="h1"> [class.active]="isAcive()"> title</h1>

renders to: 
<h1 class="h1 active"> title</h1>


<h1 class="h1"> [class]="isAcive()"> title</h1>
则会全部替换掉:

<h1 class="isActive">title</h1>

```


style property: 

```
<h1 [style.color]="getColor()">Title</h1>
<h1 [style.line-height.em]="'2'"> Title </h1>

renders to:

<h1 style="color: blue;">Title</h1>
<h1 style="line-height: 2rem;"> Title </h1>

```

### Attribute bindings


# Component Basics

## primary things compose a component

* Metadata decorator: eg: @Component
* Controller: contains all the properties and methods for the component
* template: 


## Lifecycle hooks

ngOnInit: runs in the cycle but after all bindings have been resolved, so it's safer to know that all data is available for the component.


## nesting components

any component that's nested inside another, is called "View child"

### Types of components

* app 
* display
* data
* route



### app component

* keep simple
* use for app layout scaffolding
* avoid loading data


### display component

most third-party components will be in this role, since it's the most decoupled type of component

guidance:

* decouple
* make it flexible if necessary
* don't load data
* have a clean api
* optionally use a service for configuration

### data components:

primarily about handling, retrieving, accepting data.


### route component

these components aren't very reusable and are typically created specifically for a sepecific route in an application


guidance:

* template scffolding for the route
* load data o rrely on data components
* handles route parameters


## creating a data component




```html
<app-navbar></app-navbar>
<app-dashboard></app-dashboard>

```


## using inputs with components
```html
<summary [stock]="stock"> </summary>
```

### input basics


@Input('used')

consider it as alias

```html
<div [ngClass]="{'bg-danger': isDanger(), 'bg-success': !isDanger() }"> ... </div>
```

### intercepting inputs

getter/ setter methods..



selector:

```ts
@Component({
    selector: '[app-nodes-row]'// update the selector to use the attribute app-notes-row
    templateUrl: './notes-row.component.html',
    styleUrl: ['./node-row.component.css']
})
```


题外话, using default scss : https://stackoverflow.com/questions/36220256/angular-cli-sass-options



select 关键字:

```html

<ng-content select="metric-title">
</ng-content>

等价于

<metric-title></metric-title>

```

...



# 5. Advanced Components

## change detection
略

## communication between componnet

### output events and template variables

