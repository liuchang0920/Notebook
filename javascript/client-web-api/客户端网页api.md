
## Web API 简介

## 操作文档
常见的方法是使用对象模型DOM
它是一些列大量使用Document object的API来控制HTML的样式信息

## 从服务器获取数据

HMLHttpRequest, Fetch API

## 第三方 API

## 绘制图形

## 视频和音频 API

## 客户端内存

------


## Web API 简介
通常分为两类

* 浏览器 API 内置于浏览器中
* 第三方 API


## API 可以做什么

## API 如何工作


* 基于对象的
API使用一个或者多个javascript objects在代码中进行交互

* 他们又可识别的入口点
DOM API 有一个更简单的入口点,他的功能旺旺被发现挂在Document 对象
    
```js
var em = document.createElement("em");
var para = document.querySelector('p');

em.textContent = 'hello';
para.appendChild(em); embed em inside para

```

* 他们使用事件来处理状态的变化

eg: onload事件
```js
var requestURL="...";
var request = new XMLHttpRequest();

request.open('GET', requestURL);
request.responseType = 'json';
request.send();

request.onload = function() {
    var superHeroes = request.response;
    populateHeader(superHeroes);
    showHeroes(superHeroes);
}
```

* 他们在合适的地方又额外的安全机制
例如，一些更现代的WebAPI将只能在通过HTTPS提供的页面上工作，因为它们正在传输潜在的敏感数据