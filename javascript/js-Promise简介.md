
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

## 4. Promise.prototype.cach()
是.then(null, rejection) 的别名，用于制定发生错误时候的回调函数


```js
getJSON('/posts.json').then(function(posts) {
  ...
}).catch(function(error) => {
  // catch error
})

another:
const promise = new Promise(function(resolve, reject) {
  throw new Error('test');
});
promise.catch(function(error) {
  console.log(error);
});
// Error: test
```

promise对象的错误具有冒泡的性质，会一只向后传递，直到捕获位置。
错误总会被下一个catch语句捕获。

> 一般来说，不要在then方法里面定义reject状态的回调函数，总是使用catch方法。

```js
// bad
promise
  .then((data) => {
  ///
  }, (err) => {
  });

// good
promise
  .then((data) => {
    // success
  })
  .catch((err) => {
    // error
  })
```

第二种写法，可以捕获前面then方法执行中的错误。也更加接近同步的写法(try/catch)


跟传统的try／catch不同，如果没有使用catch方法，指定错误处理的回调函数，promise对象抛出的错误不会传递到外层的代码，不会有任何反应


额什么鬼：

```js
const someAsyncThing = function() {
  return new Promise(function(resolve, reject) {
    // 下面一行会报错，因为x没有声明
    resolve(x + 2);
  });
};

someAsyncThing().then(function() {
  console.log('everything is great');
});

setTimeout(() => { console.log(123) }, 2000);
// Uncaught (in promise) ReferenceError: x is not defined
// 123

```

通俗的说法是：promise会吃掉错误。

一般建议： promise对象后面跟catch方法，这样可以处理promise内部发生的错误。catch方法返回的还是promise对象，因此后面还可以接着调用then方法。

```js
const someAsyncThing = function() {
  return new Promise(function(resolve, reject) {
    // 下面一行会报错，因为x没有声明
    resolve(x + 2);
  });
};

someAsyncThing()
.catch(function(error) {
  console.log('oh no', error);
})
.then(function() {
  console.log('carry on');
});
// oh no [ReferenceError: x is not defined]
// carry on
```

error不会被捕获，因为没有catch语句处理它：

```js
const someAsyncThing = function() {
  return new Promise(function(resolve, reject) {
    // 下面一行会报错，因为x没有声明
    resolve(x + 2);
  });
};

someAsyncThing().then(function() {
  return someOtherAsyncThing();
}).catch(function(error) {
  console.log('oh no', error);
  // 下面一行会报错，因为 y 没有声明
  y + 2;
}).then(function() {
  console.log('carry on');
});
// oh no [ReferenceError: x is not defined]


someAsyncThing().then(function() {
  return someOtherAsyncThing();
}).catch(function(error) {
  console.log('oh no', error);
  // 下面一行会报错，因为y没有声明
  y + 2;
}).catch(function(error) {
  console.log('carry on', error);
});
// oh no [ReferenceError: x is not defined]
// carry on [ReferenceError: y is not defined]


```

## 5. Promise.prototyp.finally()

finally不管promise对象最后的状态如何，都会执行操作。

```js
promise
  .then(result => {...})
  .catch(error => {...})
  .finally(() => {...})
```
finally是一定会执行的回调函数


```js
server.listen(port)
.then(() => {...})
.finally(server.stop);
```

finally 函数不接受任何的珊瑚色，表示finally的方法，与状态无关的。
finally，本质上是then方法的特里，在then，catch回调函数中，使用相同的处理方法。

```js
//实现

Promise.prototype.finally = function (callback) {
  let P = this.constructor;
  return this.then(
    value  => P.resolve(callback()).then(() => value),
    reason => P.resolve(callback()).then(() => { throw reason })
  );
};
```

## 6. Promise.all()

用于包装多个promise的实例，

```js
const p = Promise.all([p1, p2, p3]);

```
all() 方法的参数可以不是数组，但必须有iterator借口，返回的每个成员都是promise的实例

p的状态又两部分状态组成：
1. p1, p2, p3的状态都变成fullfilled， p的状态才变成fullfilled，此时，p1, p2, p3的返回值，组成一个数组，传递给p的回调函数

```js
const promises = [1, 2, 3, 6, 4, 5].map((id) => {
  return getJSON('/post' + id + '.json');
})

Promises.all(promises).then((posts) {

})
.catch((err) => {
  ///
})

another例子

const databasePromise = connectDatabase();

const booksPromise = databasePromise
  .then(findAllBooks);

const userPromise = databasePromise
  .then(getCurrentUser);

Promise.all([
  booksPromise,
  userPromise
])
.then(([books, user]) => pickTopRecommentations(books, user));

```
注意：
如果定义了自己的catch方法，那么一旦它被rejected，并不会出发Promise.all()的catch方法

例子：
```js
const p1 = new promise((resolve, reject) => {
  resolve('hello');
})
.then(result => result)
.catch(e => e);

const p2 = new Promise((result, reject)=> {
  throw new Error("wrong!");
})
.then(result => result)
.catch(e => e);

Promise.all([p1, p2])
.then(result => console.log(result))
.catch(e => console.log(e));
// ["hello", Error: 报错了]

```

p2 因为有自己的catch方法，所以在调用catch以后，也会变成resovled。导致，all（）方法参数里边的两个实例都会变成resolved，所以会调用then方法指定的回调函数。而不会调用catch方法，指定的回调函数

如果p2没有自己的catch方法，那么会调用all（）的catch方法

```js
const p1 = new promise((resolve, reject) => {
  resolve('hello');
})
.then(result => result)
.catch(e => e);

const p2 = new Promise((resolve, reject) => {
  throw new Error('wrong!');
}).then(result => result);

Promise.all([p1, p2])
.then(result => console.log(result));
.catch(e => console.log(e));
// Error: 报错了

```

## 7. Promise.race()

const p = Promise.race([p1, p2, p3]);

上面代码中，只要p1、p2、p3之中有一个实例率先改变状态，p的状态就跟着改变。那个率先改变的 Promise 实例的返回值，就传递给p的回调函数。

Promise.race方法的参数与Promise.all方法一样，如果不是 Promise 实例，就会先调用下面讲到的Promise.resolve方法，将参数转为 Promise 实例，再进一步处理。

下面是一个例子，如果指定时间内没有获得结果，就将 Promise 的状态变为reject，否则变为resolve。

```js
const p = Promise.race([
  fetch('/resource-that-may-take-a-while'),
  new Promise(function (resolve, reject) {
    setTimeout(() => reject(new Error('request timeout')), 5000)
  })
]);

p
.then(console.log)
.catch(console.error);

```
如果5秒之内没有fetch到结果，变量p的状态就会变成rejected， 触发catch方法指定的回调函数

## 8.Promise.resolve()
将现有的对象转化为Promise对象

```js
Promise.resolve('foo')
// 等价于
new Promise(resolve => resolve('foo'))
```

参数分成4种情况：
1. promise实例
不会做任何修改，直接返回这个实例

2.thenable 对象 ？？
具有then方法的对象，

```js
??? 

let thenable = {
  then: function(resolve, reject) {
    resolve(42);
  }
};

let p1 = Promise.resolve(thenable);
p1.then(function(value) {
  console.log(value);  // 42
});

```

3. 不具有then方法的对象，或者不是对象

```js
const p = Promsie.resolve("hello");
p.then((s) => {
  console.log(s);
})
```
resolve方法，返回一个新的Promise对象，状态为resolved

4. 不带有任何参数

直接返回一个resolved状态的promise对象。

```js
const p = Promise.resolve();

p.then(function () {
  // ...
});
```

.....

## 9. Promise.reject()

返回一个promise 实例，状态为rejected
 
```js
cosnt p = Promise.reject('wrong!');
// equals:
const p = new Promise((resolve, reject) => reject('wrong!'));
p.then(null, (e) => { console.log(e)});
// wrong!
```


```js
不懂：
const thenable = {
  then(resolve, reject) {
    reject('出错了');
  }
};

Promise.reject(thenable)
.catch(e => {
  console.log(e === thenable)
})
// true
返回的是thenable对象？？

```

## 10.应用

## 11. try

...





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

