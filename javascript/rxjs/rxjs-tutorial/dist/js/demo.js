"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var rxjs_1 = require("rxjs");
// const ob = Observable.create((observer) => {
//     observer.next(1);
//     observer.next(2);
//     observer.next(3);
//     setTimeout(()=> {
//         observer.next(4);
//         observer.complete();
//     }, 1000);
// })
// console.log("before subscribe")
// ob.subscribe({
//     next: x => console.log(`got value ${x}`),
//     error: err => console.error(`something went wrong ${err}`),
//     complete: () => console.log("done!")
// })
// const foo = Observable.create((observer) => {
//    try {
//     console.log("hello")
//     observer.next(42);
//     observer.next(422);
//     observer.next(424);
//    } catch(err) {
//        observer.error(err)
//    }
// })
// foo.subscribe((x) => {
//     console.log(x)
// })
// foo.subscribe((xy) => {
//     console.log(xy)
// })
// var observable = Observable.create((observer) => {
//     var intervalId = setInterval(() => {
//         observer.next(10);
//     }, 1000);
//     return function unsubscribe() {
//         clearInterval(intervalId);
//     }
// })
// var unsubscribe = observable.subscribe({
//     next: x => console.log(x)
// })
// unsubscribe();
// console.log(unsubscribe);
// core Observable concers:
/**
 *  1. creating observable
 *  2. subscribing to observables
 *  3. executing the observable
 *  4. disposing observables
 */
// subscription
var observable = rxjs_1.interval(1000);
var observable2 = rxjs_1.interval(1500);
var subscription = observable.subscribe(function (x) { return console.log(x); });
var childSub = observable.subscribe(function (x) { return console.log("child" + x); });
subscription.add(childSub);
setTimeout(function () {
    subscription.unsubscribe();
}, 3000);
// subject
// it is a special type of observable that allows to be multicasted to many observabes
// while plain observables are unicast, subjects are multicast
// a Subject is like an observable, bu tcan multicast to many observers, subjects are like EventEmitters
// thye maintain a registry of many listeners.
//  const subject = new Subject<number>();
//  subject.subscribe({
//      next: (c) => console.log(`A: ${c}`)
//  })
//  subject.subscribe({
//     next: (c) => console.log(`B: ${c}`)
// })
// subject.next(1);
// subject.next(2)
// subject is a Observer as well
// const observabe = from([1, 2, 3]);
// observabe.subscribe(subject);
// multi cast
var operators_1 = require("rxjs/operators");
var source = rxjs_1.from([1, 2, 3]);
var subject = new rxjs_1.Subject();
var multicasted = source.pipe(operators_1.multicast(subject));
subject.subscribe({
    next: function (v) { return console.log("observable 1: " + v); }
});
subject.subscribe({
    next: function (v) { return console.log("observable 2: " + v); }
});
multicasted.connect();
//# sourceMappingURL=demo.js.map