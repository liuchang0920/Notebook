
# Angular 路由

https://angular.cn/guide/router

## 基础知识

浏览器具有的导航模式：
* 在地址栏输入 URL，浏览器就会导航到相应的页面。
* 在页面中点击链接，浏览器就会导航到一个新页面。
* 点击浏览器的前进和后退按钮，浏览器就会在你的浏览历史中向前或向后导航。

### <base href> 元素

如果app文件夹是应用的根目录：
>
<base href="/">


导入路由
```ts
import { RouterModule, Routes } from '@angular/router';
```


## 配置
每个angular应用，都有一个Router路由器的单例对象。

eg: app.module.ts

``` ts
const appRoutes: Routes = [
  { path: 'crisis-center', component: CrisisListComponent },
  { path: 'hero/:id',      component: HeroDetailComponent },
  {
    path: 'heroes',
    component: HeroListComponent,
    data: { title: 'Heroes List' }
  },
  { path: '',
    redirectTo: '/heroes',
    pathMatch: 'full'
  },
  { path: '**', component: PageNotFoundComponent }
];

@NgModule({
  imports: [
    RouterModule.forRoot(
      appRoutes,
      { enableTracing: true } // <-- debugging purposes only
    )
    // other imports here
  ],
  ...
})
export class AppModule { }
```
吧appRoutes 传递给RouterModule.forRoot方法，并传给本模块的imports数组就能够配置路由器。

1. 每个Route都会把一个URL path映射到一个路由
> path不能够以/ 为路径开头，路由器会解析和构建最终的URL。

2. 路由中的 :id 是一个路由参数的令牌(token)，

3. 路由中的data属性，用来存放每个具体路由有关的任意信息。

4. 路由中的空路径('') 表示应用的默认路径，当URL为空时就会访问那里。 因此它通常会作为起点

5. 通配符** 是一个通配符。这个特性可以显示404，或者自动重定向到其他的路由。




