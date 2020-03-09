

理解rxjs

https://blog.crimx.com/2018/02/16/understanding-rxjs/


视频资源：
https://www.youtube.com/watch?v=T9wOu11uU6U&list=PL55RiY5tL51pHpagYcrN9ubNLVXF8rGVi



## 2. 基本概念
...

Observer 是subscribe的参数，所以可以理解成RXJS为连接Producer跟observer的纽带

于是这个纽带的成分较Observable（可被观察的）就不难理解了。Observable就是由时间组成的四维数组，RXJS将producer转换为Observable，
然后对Observable进行各种变换，最后交给Observer.


对Observable进行变换的操作符叫做Operator。他们输入observable再输入新的observable.RXJSyou巨量的operators，这也是学习RXJS的第二个难点。


## 2. 创建observable

RXJS封装了很多有用的方法来将producer转换为observable， eg: `fromEvernt, fromPromise` 但是根本是一个叫create的方法

```
var observable = Rx.observable.create(observer => {
  observer.next(0);
  observer.next(1);
  observer.next(2);
  setTimeout(() => {
    observer.next(3);
    observer.complete();
  }, 1000);
})
```

这个其实跟promise的思路很像，promise只能resolve一遍，但是这里可以observer。next很多歌值，最后还能complete，

## 3. subscribe不是订阅者模式

订阅者模式，会维护一个订阅者的列表，时间来了就调用列表上的每一个订阅者，传递通知。但是rxjs并没有这个列表，它就是一个函数，可以跟promise类比，promise的executor在new Promise(executor)的时候马上执行的，而RXJS的rxjs.Observable.create(observer)的observer则是在每次执行subscribe后调用一遍，即每次subscribe的observables都是独立的，都会重新走一遍整个流程。

这个时候，你会想，这样每次都完整调用一遍，岂不是很浪费性能？没错，如果需要多次subscribe同一个producer这么做会比较浪费，但是如果只是subscribe一遍，维护一个订阅者列表页没有必要，所以rxjs引入了hot，cold，observable的概念

## 4. hot & cold

observable的冷热概念其实就是看producer创建受不受rxjs控制。


