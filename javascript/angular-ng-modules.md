# providers

## Limiting provider scope by lazy loading modules

In the basic CLI generated app, modules are eagerly loaded which means that they are all loaded when the app launches. Angular uses an injector system to make things available between modules. In an eagerly loaded app, the root application injector makes all of the providers in all of the modules available throughout the app.

This behavior necessarily changes when you use lazy loading. Lazy loading is when you load modules only when you need them; for example, when routing. They aren’t loaded right away like with eagerly loaded modules. This means that any services listed in their provider arrays aren’t available because the root injector doesn’t know about these modules.

When the Angular router lazy-loads a module, it creates a new injector. This injector is a child of the root application injector. Imagine a tree of injectors; there is a single root injector and then a child injector for each lazy loaded module. The router adds all of the providers from the root injector to the child injector. When the router creates a component within the lazy-loaded context, Angular prefers service instances created from these providers to the service instances of the application root injector.

Any component created within a lazy loaded module’s context, such as by router navigation, gets the local instance of the service, not the instance in the root application injector. Components in external modules continue to receive the instance created for the application root.

Though you can provide services by lazy loading modules, not all services can be lazy loaded. For instance, some modules only work in the root module, such as the Router. The Router works with the global location object in the browser.

## Limiting provider scope with components

Another way to limit provider scope is by adding the service you want to limit to the component’s providers array. Component providers and NgModule providers are independent of each other. This method is helpful for when you want to eagerly load a module that needs a service all to itself. Providing a service in the component limits the service only to that component (other components in the same module can’t access it.)

???
有必要这样写么

## Providing services in modules vs. components

Generally, provide services the whole app needs in the root module and scope services by providing them in lazy loaded modules(using lazy-load router..).

The router works at the root level so if you put providers in a component, even AppComponent, lazy loaded modules, which rely on the router, can’t see them.

Register a provider with a component when you must limit a service instance to a component and its component tree, that is, its child components. For example, a user editing component, UserEditorComponent, that needs a private copy of a caching UserService should register the UserService with the UserEditorComponent. Then each new instance of the UserEditorComponent gets its own cached service instance


# singleton Services

## Providing a singleton service

* Declare that the service should be provided in the application root.
* Include the service in the AppModule or in a module that is only imported by the AppModule. (一般这么做吧)


V6以后:

```ts
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class UserService {
}

```

## forRoot() ??


## lazy loading featured modules??


