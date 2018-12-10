

## some general guide

1. best practice for architecture with Core, shared, and lazy-loaded Feature modules
2. useing aliases for app and environment folders to support cleaner imports
4. why and how to ues Sass and angular material
5. how to use Headless Chrome instead (testing)
6. how to release our project with automatically generated changelog and correct version bump

### Architecture

* CoreModule
```ts
/* 3rd party libraries */
import { NgModule, Optional, SkipSelf } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';

/* our own custom services  */
import { SomeSingletonService } from './some-singleton/some-singleton.service';

@NgModule({
  imports: [
    /* 3rd party libraries */
    CommonModule,
    HttpClientModule,
  ],
  declarations: [],
  providers: [
    /* our own custom services  */
    SomeSingletonService
  ]
})
export class CoreModule {
  /* make sure CoreModule is imported only by one NgModule the AppModule */
  constructor (
    @Optional() @SkipSelf() parentModule: CoreModule
  ) {
    if (parentModule) {
      throw new Error('CoreModule is already loaded. Import only in AppModule');
    }
  }
}
```

coremodule 只能在AppModule引入一次

* Shared Module

These componenets don't import and inject services from core or other features in their constructor

they should receive all data through attributes in the template of the component using them.

(eg: Angular material componenets)

import then export in the module 

```ts
/* 3rd party libraries */
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule  } from '@angular/forms';
import { MdButtonModule } from '@angular/material';

/* our own custom components */
import { SomeCustomComponent } from './some-custom/some-custom.component';

@NgModule({
  imports: [
    /* angular stuff */
    CommonModule,
    FormsModule,

    /* 3rd party components */
    MdButtonModule,
  ],
  declarations: [
    SomeCustomComponent
  ],
  exports: [
    /* angular stuff */
    CommonModule,
    FormsModule,

    /* 3rd party components */
    MdButtonModule,

    /* our own custom components */
    SomeCustomComponent
  ]
})
export class SharedModule { }
```

* Feature module

> rule of thumb is to try to create fueatures which don't depend on any other features just on services provided by CoreModule and componenets provided by SharedModule

### lazy loading

lazy load our feature moduls whenever possible. Theoretically only one feature modules should be loaded synchronously during the app startup to show initial content. Every other feature should be loaded lazily after user triggered navigation

## Aliases for app and environments

import custome module like this:

```ts
import { SomeService } from "@app/core";

```

```json
{
  "compilerOptions": {
    "...": "reduced for brevity",
    
    "baseUrl": "src",
    "paths": {
      "@app/*": ["app/*"],
      "@env/*": ["environments/*"]
    }
  }
}
```

这个配置就很灵性吧

然后在代码里

```ts
/* 3rd party libraries */
import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs/Observable';

/* globally accessible app code (in every feature module) */
import { SomeSingletonService } from '@app/core';
import { environment } from '@env/environment';

/* localy accessible feature module code, always use relative path */
import { ExampleService } from './example.service';

@Component({
  /* ... */
})
export class ExampleComponent implements OnInit {
  constructor(
    private someSingletonService: SomeSingletonService,
    private exampleService: ExampleService
  ) {}
}
```

引入外部的featuremoduel的时候,使用@app 路径..

通过使用 index.ts 文件

```ts
export * from './core.module';
export * from './auth/auth.service';
export * from './user/user.service';
export * from './some-singleton-service/some-singleton.service';

```

可以从@app/core/some-package/some-service.service

简化到: 

@app/core  


(index.ts 文件在core 文件夹下)

## Using Sass

ng new .... --style scss 就可以了

额 还有别的配置么..

## Prod build
...

### Chrome headles

We add --browser ChromeHeadless flag to our test command so we end up with "test": "ng test --browser ChromeHeadless --single-run" and "watch": "ng test --browser ChromeHeadless" in our package.json scripts. Pretty simple, ha!

写了个卵子..


## Reference

https://medium.com/@tomastrajan/6-best-practices-pro-tips-for-angular-cli-better-developer-experience-7b328bc9db81

什么时候可以自己总结呀

