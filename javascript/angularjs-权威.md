# 第四章 作用域

angularjs将作用域$scope设计成和DOM类似的结构，因此可以在$scope进行嵌套，我们可以引用父级的$scope属性

作用域提供了监视数据库模型变化的能力。允许开发者使用其中的apply机制

$rootScope 是所有$scope的最上层

```js
angular.module('myapp', [])
.controller('controller'. function($scope) {
  $scope.name = 'dd'
})
```
ng-controller指令为这个DOM元素创建了一个新的$scope对象，并将它嵌套在$rootScope中。


### $scope 生命周期

每当事件被处理时，$scope就会对定义的表达式求值。此时事件循环会启动，并且Angular 应用会监控应用程序内的所有对象，脏值检测循环也会运行

1. 创建
在创建控制器或指令时，AngularJS会用$injector创建一个新的作用域，并在这个新建的控 制器或指令运行时将作用域传递进去。 

2. 链接
当Angular开始运行时，所有的$scope对象都会附加或者链接到视图中。所有创建$scope对 象的函数也会将自身附加到视图中。这些作用域将会注册当Angular应用上下文中发生变化时需 要运行的函数。 这些函数被称为$watch函数，Angular通过这些函数获知何时启动事件循环。 

3. 更新
当事件循环运行时，它通常执行在顶层$scope对象上（被称作$rootScope） ，每个子作用域 都执行自己的脏值检测。每个监控函数都会检查变化。如果检测到任意变化，$scope对象就会触 发指定的回调函数。 

4. 销毁
当一个$scope在视图中不再需要时，这个作用域将会清理和销毁自己。 尽管永远不会需要清理作用域（因为Angular会为你处理） ，但是知道是谁创建了这个作用域 还是有用的，因为你可以使用这个$scope上叫做$destory()的方法来清理这个作用域。 

# 第五章  控制器

Anuglarjs中控制器是一个函数，用来向视图的作用域中添加额外的功能。我们用他来给作用域对象设置初始状态，并添加自定义行为。

> 将控制器命名为[Name]Controller而不是[Name]Ctrl是一个最佳实践。 


```js
app.controller('FirstController', function($scope) {  
  $scope.counter = 0; 
  $scope.add = function(amount) { $scope.counter += amount; };  
  $scope.subtract = function(amount) { $scope.counter -= amount;  }; 
  
}); 

```
用这种设置方式我们可以在视图中调用add()或subtract()方法，这两个方法可以定义在 FirstController的作用域中，或其父级的$scope中。 

controller可以将与一个独立视图相关的业务逻辑封装在一个独立的容器中，尽可能的精简控制是一个很好的做法。

AngularJS允许在$scope上设置包括对象在内的任何类型的数据，并且在视图中还可以展示 对象的属性。 

eg： 
```js
app.controller('MyController', function($scope) { $scope.person = { name: 'Ari Lerner' }; }); 
```
在拥有ng-controller='MyController'这个属性的元素内部的任何子元素中，都可以访问 person对象，因为它是定义在$scope上的

```html
<div ng-app="myApp"> <div ng-controller="MyController"> <h1>{{ person }}</h1> and their name: <h2>{{ person.name }}</h2> </div> </div> 

```

### 控制器 嵌套

AngularJS应用的任何一个部分，无论它渲染在哪个上下文中，都有父级作用域存在。对于 ng-app所处的层级来讲，它的父级作用域就是$rootScope。 

除了孤立作用域外，所有的作用域都通过原型继承而来，也就是说它们都可以访问父级作用 域。如果熟悉面向对象编程，对这个机制应该不会陌生。

默认情况下，angularjs会在当前的scope无法找到某个属性时，便会在父级作用域中进行调查。如果找不到，会一直顺着父级作用域，一直往上寻找。知道抵达$rootScope为止

通过例子来看一下这个行为。创建一个ParentController，其中包含一个user对象，再创 建一个ChildController来引用这个对象： 
app.controller('ParentController', function($scope)
{  $scope.person = {greeted: false}; }); 

app.controller('ChildController', function($scope) 
{ $scope.sayHello = function() { $scope.person.name = 'Ari Lerner'; 
}; 

}); 

如果我们将ChildController置于ParentController内部，
那ChildController的$scope 对象的父级作用域就是ParentController的$scope对象。

根据原型继承的机制，我们可以在子 作用域中访问ParentController的$scope对象。 


``` html

<div ng-controller="ParentController"> 
<div ng-controller="ChildController"> 
<a ng-click="sayHello()">Say hello</a> </div> {{ person }} </div> 
```

设计良好的应用会将复杂的逻辑放到指令，服务中。通过使用指令和服务，我们可以将控制器冲构成轻量而且容易维护的形式。

职责分工以后：

```js
angular.module('app'. [])
.controller('controller', function($scope, UserService){
  
  $scope.onLogin = function(user) {
    UserService.runLogin(user);
  }
}) 
```



## 第六章 表达式
对表达式进行的任何操作，都会在其所属的作用域内部执行，因此可以在表达式的内部调用那些限制在此作用域内部的变量，并进行循环，函数调用，将变量应用到数学表达式中等操作。

额 这一章的$interpolateProvder, $watch用法 看不明白

## 第七章 过滤器

在html中的模板绑定符号{{}} 通过  | 使用过滤器


内置过滤器：
1. currency: 默认使用客户端所处区域的货币符号
2. date： 太多了 具体看文档吧
3. filter:
  * string
  * object: 对象中的同名全部属性进行对比
  * function: 执行这个函数，返回true的结果
  * ...

4. json

5. limitTo: {{ San Francisco is very cloudy | limitTo:3 }}  或最后的六个字符： {{ San Francisco is very cloudy | limitTo:-6 }} 

6. lowercase

7. number {{ 1.234567 | number:2 }} 

8. orderBy: {{... | orderBy: 'name'}}

自定义filter

```js

angular.module('myApp.filters', []) 
.filter('capitalize', function() {
    return function(input) { 
      // input是我们传入的字符串 
      if (input) { 
        return input[0].toUpperCase() + input.slice(1); 
      } 
 }); 
```

{{ 'ginger loves dog treats' | lowercase | capitalize }} 

### 表单验证

<input type="text" required /> 
<input type="text" ng-minlength="5" /> 
<input type="text" ng-maxlength="20" /> 
<input type="text" ng-pattern="[a-zA-Z]" /> 
<input type="email" name="email" ng-model="user.email" /> 
<input type="number" name="age" ng-model="user.age" /> 
<input type="url" name="homepage" ng-model="user.facebook_url" /> 

自定义验证 (等学习到指令)


表单部分。。。 跳过吧 感觉过时了


## 第八章 指令简介


## 自定义HTML元素和属性



1. HTML引导
<html ng-app="myApp"> <!-- 应用的$rootScope --> </html> 

2. 第一个指令
假设我们已经创建了一个完整的html文档，包含了angularjs,并且DOM中已经使用了ng-app指令表示出应用的根元素，当angularjs编译html时就会调用指令

```js
<my-dir></my-dir>

angular.module('myDir', [])
.directive('myDirective'. function() {
  
  return {
    restrict: 'E',
    template:  '<a href="http://google.com"> Click me to go to Google</a>' 
  }
})
```


```js
angular.module('myApp', []) .directive('myDirective', function() { return { restrict: 'E', replace: true, template: '<a href="http://google.com">Click me to go to Google</a>' }; }); 

```
replace 改为true
DOM中原始的指令声明已经不见了，只有我们在末班中写的HTML代码。replace方法会使用自定义元素取代指令的声明，而不是镶嵌在内部
。


从现在起，我们把创建这些自定义元素称作指令：“ directive” 

下面都是合法的形式：

<my-directive></my-directive> 
<div my-directive></div>
<div class="my-directive"></div> 
<!--directive:my-directive--> 


为了能够让angularjs调用我们的指令，需要修改指令定义中的restrict设置。

E： 元素
A: 属性
C: 类
M: 注释？？

```js
angular.module('myApp', []) 
.directive('myDirective', function() { 
  return { 
    restrict: 'EAC', replace: true, template: '<a href="http://google.com">Click me to go to Google</a>' 
  }; 
});
```

eg:

template: '<a href="{{ myUrl }}">{{ myLinkText }}</a>' 

在html文档中，可以给指令添加myUrl, myLinkText属性 <div my-directive my-url="http://google.com" my-link-text="Click me to go to Google"> </div> 



> 共享状态能够导致很多问题，如果控制器被移除，或者当前的控制器的作用域中也有一个myUrlshuxing ,我们就需要被迫修改代码，成本很高，而且让人沮丧。

Angularjs 允许通过创建新的子作用域或者隔离作用域来解决这个常见的问题。


eg:
这个绑定策略告诉angularjs将DOM中 some-property属性值，绑定到新作用域对象中的somePropery属性上

scope: {
  someProperty: '@'
}



scope: { someProperty: '@someAttr' } 

--->

<div my-directive some-attr="someProperty with @ binding"> </div> 

```js

<div my-directive my-url="http://google.com" my-link-text="Click me to go to Google"></div> angular.module('myApp', []) .directive('myDirective', function() { return { restrict: 'A', replace: true, scope: { myUrl: '@', //绑定策略 myLinkText: '@' //绑定策略 }, template: '<a href="{{myUrl}}">' + '{{myLinkText}}</a>' }; });
```

默认情况下约定DOM属性和JavaScript中对象属性的名字是一样的（除非对象的属性名采用 的是驼峰式写法） 。 由于作用域中属性经常是私有的，因此可以（虽然不常见）指定我们希望将这个内部属性同 哪个DOM属性进行绑定： 

scope: {

  myUrl: '@someAttr',
  myLinkText: '@'
}


额 

# 第九章 内置指令

暂时略过

# 第十章 指令详解






