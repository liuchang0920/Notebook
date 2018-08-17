
http://es6.ruanyifeng.com/#docs/promise


Promise 三种状态：
1. pending (进行中)
2. fulfilled (成功)
3. rejected (失败)

> 一旦状态改变，就不会再改变，任何时候都可以得到这个结果。
只有两种状态变化：
pending --> fulfilled
pending --> rejected

只要这两种情况发生，状态就凝固了，不会再变了，会一直保持这个结果，这时就称为 resolved（已定型）

基本语法：
```js
const promise = new Promise(function(resolve, reject) => {
  if(//异步成功) {
    resolve(value);
  } else {
    reject(error);
  }
}
```

实例生成以后，通过then方法，制定resolve， reject状态的回调函数

```js
promise.then(function(value) {
  // success
}, function(error) {
});

```

eg:
```js
function timeout(ms) {
  return new Promise((resolve, reject) => {
    setTimeout(resolve, ms, 'done');
  })
}

timeout(1000).then((value) ==> {
  console.log(value);
})
```


promise 执行顺序
```js
let promise = new Promise(function(resolve, reject) {
  console.log('Promise');
  resolve();
});

promise.then(function() {
  console.log('resolved.');
});

console.log('Hi!');

// Promise
// Hi!
// resolved

```

```js
const p1 = new Promise(function (resolve, reject) {
  setTimeout(() => reject(new Error('fail')), 3000)
})

const p2 = new Promise(function (resolve, reject) {
  setTimeout(() => resolve(p1), 1000)
})

p2
  .then(result => console.log(result))
  .catch(error => console.log(error))
// Error: fail

奇怪的东西
```

## 3. Promise.prototype.then()

具有 then方法，then方法是定义在原型对象Promise.prototype上的。
它的租用是为promise实例添加状态改变时候的回调函数， 
then方法的第一个参数是resolved状态的回调函数，第二个参数是reject状态的回调函数

then返回的是一个promise的新的实例， 所以可以采用链式写法，then方法后面可以再调用另外一个then方法。




----

https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Using_promises

推荐的方式：
```js
doSomething()
.then(result => doSomethingElse(result))
.then(newresult => doThirdThing(newResult) 
.then(finalResult => {
  console.log("finish...");
})
.catch(filtureCallBack);
```

catch之后也可以使用链式操作，及时一个动作的失败只有还能有助于新的动作继续完成， 我的理解是只要return正常的内容，就可以执行后面的then函数

## 错误传播

在回调地狱中，有三次用到failureCallback的地方，而在promise链中，只需要一次调用
```js
doSomething()
.then(result => doSomethingElse(value))
.then(newResult => doThirdThing(newResult))
.then(finalResult => console.log(`Got the final result: ${finalResult}`))
.catch(failureCallback);

```

基本上，一个promise链式遇到异常就会停止，查看链式的底端，寻找catch处理程序代替当前执行。
```js

try {
  let result = syncDoSomething();
  let newResult = syncDoSomethingElse(result);
  let finalResult = syncDoThirdThing(newResult);
  console.log(`Got the final result: ${finalResult}`);
} catch(error) {
  failureCallback(error);
}

可以使用async/await语法糖

同步形式的代码的整齐性得到了体现；

async function foo() {
  try {
    let result = await doSOmething();
    let newResult = await doSOmethingElse(result);
    
} catch(error) {
  failureCallback(error);
}
```

