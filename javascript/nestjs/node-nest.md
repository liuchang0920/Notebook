

## Documentation
https://docs.nestjs.cn/5.0/firststeps?id=%E7%AC%AC%E4%B8%80%E6%AD%A5


### 中间件
实际上等价于express中间件

* 执行任何代码
* 队请求或者响应进行更改
* 结束请求-响应周期
* 调用堆栈中的下一个中间件函数
* 如果当前的中间件函数没有结束请求-响应周期,必须调用next() 将控制传递给下一个中间件函数,否则 请求将被挂起

#### 中间件放在哪里
必须通过configure() 模块类的方法来设值.

通过注入的MidlewareConsumer来使用中间件

#### 异步中间件


#### 多个中间件
```ts
export class ApplicationModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(cors(), helmet(), logger)
      .forRoutes(CatsController);
  }
}
```

### 异常 过滤器

HttpException

为了减少样板代码,nest提供了一系列的扩展核心的可用的异常http exception


## Resource

https://segmentfault.com/a/1190000009560532
