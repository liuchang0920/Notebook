

Observable

## 基本用法，词汇
* 订阅者(subscriber)
* 观察者(observer)

## 定义观察者

1. next:  必要，用来处理每个送达值，在执行后可能执行0，1+次
2. error： optional， 处理错误通知
3. complete：optional，用来处理执行完毕通知。

## 订阅

```js
cosnt ob = Observable.of(1, 2, 3);

const observer = {
  next: x => console.log("got value " + x),
  error: err => console.log("error: " + err),
  complete: () => console.log("complete notification"),
};

ob.subscribe(observer);
// print ...

等价于

myObservable.subscribe(
  x => console.log('Observer got a next value: ' + x),
  err => console.error('Observer got an error: ' + err),
  () => console.log('Observer got a complete notification')
);

```

> next处理器都是必要的，error， complete是可选的



## subscribing

Observable instance only begins publishing values when someone subscribes it.

* Observable.of(...items) -- returns an observable instance that synchronously delivers the value
* Observale.from(iterable) -- converts its argument to an Observable instance. This method is commonly used to convert an array to an observable.

create observable with constructor, 

```ts
function sequenceSubscriber(obserer) {
  observer.next(1);
  observer.next(2);
  observer.complete();
  
  return { unsubscribe() {} };
}
const sequence = new Observable(sequenceSubscriber); // 放到observerble的构造参数里

sequence.subscribe({
  next(num) {
    console.log(num);
  }, 
  complete() {
    console.log("finish");
  }
})

```

create an observable that publish events.

```ts
function fromEvent(target, eventName) {
  return new Observable((observer) => {
    const handler = (e) => observer.next(e);
    
    // add event handler to the target
    target.addEventListener(eventName, handler);
    
    return () => {
      // detach the event handler from the target
      target.removeEventListener(eventName, handler);
    }
  }
}

use observervable

const ESC_KEY = 27;
const nameInput = document.getElementById('name') as HTMLInputElement;

const subscription = fromEvent(nameInut, 'keywdown').subscribe(
  (e: KeyboardEvent) => {
    if(e.keyCode === ESC_KEY) {
      nameInput.value = '';
    }
  }
)
```


## Multi casting

Multicasting is the practice of broadcasting to a list of multiple subscribers n a single execution.
With a multicasting observable, you don't reister mlutiple listeners on the document, but instead re-use the first listener and send values out to each subscriber.

when creating an observable you should determine how you wan that observable to be used and whether or not you want to multicast its value.

eg:

```ts
function sequenceSubscriber(observer) {
  const seq = [1, 2, 3]
  let timeoutId;
  
  function doSequence(arr, idx) {
    timeoutId = setTimeout(() => {
      observer.next(arr[idx]);
      
      if(idx == arr.length - 1) {
        observer.complete();
      } else {
        doSequence(arr, ++idx);
      }
    }, 1000);
  }
  
doSequence(seq, 0);

return {
  unsubscribe() {
    clearTimeout(timeoutId);
  }
}

// Create a new Observable that will deliver the above sequence
const sequence = new Observable(sequenceSubscriber);
 
sequence.subscribe({
  next(num) { console.log(num); },
  complete() { console.log('Finished sequence'); }
});
 
// Logs:
// (at 1 second): 1
// (at 2 seconds): 2
// (at 3 seconds): 3
// (at 3 seconds): Finished sequence


```


Notice that if you subscribe twice, there will be two separate streams, each emitting values every second. It looks something like this:


额.. 继续看看multi cast


## Error handling
Since observables produces values asynchronously, try/catch will not effectively cat errors.
instead, handler errors by specifing an error callback on the observer.



```ts
observable.subscribe({
  next(num) { console.log(num);},
  error(err) { console.log('received an error: ', err); }
  
})
```

