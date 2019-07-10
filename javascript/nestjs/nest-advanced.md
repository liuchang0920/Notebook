
# Middleware

默认情况下,Nest中间件就是Express 中间件

中间件的功能:

* 执行任何代码
* 对请求和响应对象进行修改
* 结束请求-响应的周期
* 调用堆栈中的下一个中间件函数
* 如果当前中间件没有结束请求-响应周期,那么必须调用next()将控制权传递给下一个中间件,否则,请求会被何止

## Nest 中间件 预览

Nest中间件可以是一个函数,也可以是一个带有@Injectable()装饰器的类, 并且该类应该实现NestMiddleware接口,对函数本身没有什么特别的要求


```ts

import { Injectable, NestMiddleware, MiddlewareFunction } from '@nestjs/common';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
    resolve(...args: any[]): MiddlewareFunction {
        return (req, res, next) => {
            console.log('request')
            next();
        }
    }
}

```

resolve必须范湖一个常规的,特定于库(比如express)的中间件函数,


### 中间件的依赖注入

```ts


...

constrctor(@Inject(SomeService) private readonly someService: SomeService) {

}


```

然后就可以使用了


只需要在Nest中,实现NestModule的接口

```ts

@Module({
    imports: [CatsModule],
})
export class ApplicationModule implmenents NestModule {
    configure(consumer: MiddlewareConsumer) {
        consumer
        .apply(LoggerMiddleware)
        .forRoutes('cats');
    }
}

```
给路由: '/cats'设置了中间件

## 可配置的中间件

当我们希望向中间件传入不同的参数来让他体现不同的行为的时候,可以配置的中间件就能够满足我们的需求

,使用with() 方法,就可以在中间件的resolve()方法中接收这个参数

## 异步中间件

也称为延迟中间件,当我们需要在中间件中执行一些异步的方法的时候,并且需要等待他们执行完成以后,才会调用下一个中间件.


``` ts
import { Injectable, NestMiddlware, MiddlewareFunction } from '@nestjs/common';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
    async resolve(name: string): Promise<MiddlewareFunction> {
        await someAsyncJob();

        return async (req, res, next) => {
            await someAsyncJob2();
            next();
        }
    }
}

```


## 函数中间件

也可以是一个函数,


```ts
export function logger(req, res, next) {
    console.log('some request..');
    next();
}

// 然后在模块中,使用 .apply() 调用
```

## 全局中间件




# Exception filter

Todo

# Pipe 

Todo

# Guard

Todo

# Interceptor

Todo