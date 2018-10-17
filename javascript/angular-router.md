
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

具体路由应该放在通用路由的前面

## 路由出口

``` html
<router-outlet></router-outlet>
```

## 路由器链接

``` ts
template: `
  <h1>Angular Router</h1>
  <nav>
    <a routerLink="/crisis-center" routerLinkActive="active">Crisis Center</a>
    <a routerLink="/heroes" routerLinkActive="active">Heroes</a>
  </nav>
  <router-outlet></router-outlet>
`

```
a 上面的routerlink指令让路由器得以控制这个a 元素。 这里的导航路径是固定的，因此可以把一个字符串赋值给routerLink.

如果需要更加动态的导航路径，那就把它绑定到一个返回 __链接参数数组__ 的模板表达式。 路由器会把这个数组，解析成完整的URL

每个a标签上的RouterLinkActive可以帮助用户区别当选前选中的“”active” 的路由。

## 路由器的状态
Router State??

在导航时的每个生命周期成功完成时，路由器会构建出一个 ActivatedRoute 组成的树，它表示路由器的当前状态。 你可以在应用中的任何地方用 Router 服务及其 routerState 属性来访问当前的 RouterState 值。

RouterState 中的每个 ActivatedRoute 都提供了从任意激活路由开始向上或向下遍历路由树的一种方式，以获得关于父、子、兄弟路由的信息。

## 激活的路由
该路由的路径和参数可以通过注入进来的一个名叫ActivatedRoute的路由服务来获取。 它有一大堆有用的信息，包括：

ActivatedRoute 是一个服务

## 路由事件
在每次导航中，Router 都会通过 Router.events 属性发布一些导航事件。这些事件的范围涵盖了从开始导航到结束导航之间的很多时间点

具体的看文档...



## 总结


路由器部件

含义

* Router（路由器）

为激活的 URL 显示应用组件。管理从一个组件到另一个组件的导航

* RouterModule

一个独立的 Angular 模块，用于提供所需的服务提供商，以及用来在应用视图之间进行导航的指令。

* Routes（路由数组）

定义了一个路由数组，每一个都会把一个 URL 路径映射到一个组件。

* Route（路由）

定义路由器该如何根据 URL 模式（pattern）来导航到组件。大多数路由都由路径和组件类构成。

* RouterOutlet（路由出口）

该指令（<router-outlet>）用来标记出路由器该在哪里显示视图。

* RouterLink（路由链接）

这个指令把可点击的 HTML 元素绑定到某个路由。点击带有 routerLink 指令（绑定到字符串或链接参数数组）的元素时就会触发一次导航。

* RouterLinkActive（活动路由链接）

当 HTML 元素上或元素内的routerLink变为激活或非激活状态时，该指令为这个 HTML 元素添加或移除 CSS 类。

* ActivatedRoute（激活的路由）

为每个路由组件提供提供的一个服务，它包含特定于路由的信息，比如路由参数、静态数据、解析数据、全局查询参数和全局碎片（fragment）。

* RouterState（路由器状态）

路由器的当前状态包含了一棵由程序中激活的路由构成的树。它包含一些用于遍历路由树的快捷方法。

* 链接参数数组

这个数组会被路由器解释成一个路由操作指南。你可以把一个RouterLink绑定到该数组，或者把它作为参数传给Router.navigate方法。

* 路由组件

一个带有RouterOutlet的 Angular 组件，它根据路由器的导航来显示相应的视图。


## 范例 应用

关键特性：
* 把应用的各个特性组织成模块。

* 导航到组件（Heroes 链接到“英雄列表”组件）。

* 包含一个路由参数（当路由到“英雄详情”时，把该英雄的 id 传进去）。

* 子路由（危机中心特性有一组自己的路由）。

* CanActivate 守卫（检查路由的访问权限）。

* CanActivateChild 守卫（检查子路由的访问权限）。

* CanDeactivate 守卫（询问是否丢弃未保存的更改）。

* Resolve 守卫（预先获取路由数据）。

* 惰性加载特性模块。

> 在angular中，应用导航也会和标准的web导航一样，更新浏览器的历史


CanDeactivate守卫： 让你有机会在清理工作或者离开当前视图之前，请求用户的许可。




CanLoad 守卫（在加载特性模块之前进行检查）。



## routerLinkActive 绑定

每个A标签还有routerLinkActive指令的属性绑定，就像routerLInkActive=""

等号右侧的魔板表达式包含用空格分隔的一些css类。，还可以将RouterLinkActive指令绑定到一个css类组成的数组

[routerLinkActive]="[...]"

routerLinkAcitve指令会基于当前的ROuterState，对象来激活RouterLInk切换css类。并且会一直沿着路由树， 由上往下级联处理。


## 路由器指令集


### 通配符路由

``` ts
{ path: '**', component: PageNotFoundComponent }

```


localhost:4200 默认没有对应的路由， 那么需要一个重定向路由

### 重定向路由

``` ts
const appRoutes: Routes = [
  { path: 'crisis-center', component: CrisisListComponent },
  { path: 'heroes',        component: HeroListComponent },
  { path: '',   redirectTo: '/heroes', pathMatch: 'full' },
  { path: '**', component: PageNotFoundComponent }
];

```

technically, pathMath = full, 导致 剩下，未匹配的部分必须等于 "", 这个例子中，跳转的路由在顶级路由，因此，剩下的URL跟完整的URL是一样的

pathMatch另一个值： prefix. 他会告诉路由器： 剩下的URL以这个为prefix的时候，机会匹配上这个跳转路由



## 里程碑2 路由模块 

## 里程碑3

angular应用推荐的模式:
* 把每个特性放在自己的目录中
* 每个特性都有自己的angular特性模块
* 每个特性都有自己IDEanular根组件
* 每个特性去的跟组件中都有自己的路由出口,以及子路由
* 特性区的路由很少(或者完全不)与其他的特性区的路由交叉




