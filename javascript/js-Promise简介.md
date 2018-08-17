
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

