# 迭代器
迭代器是一个对象，提供一个next()方法
这个方法返回两个属性，done 和value


```js

function makeIterator(array) {
    var nextindex = 0;
    return {
        next: function() {
            return nextIndex < array.length ? {
                value: array[nextIndex]++, done: false
            }: {
                done: true
            }
        }
    }
}


var it = makeIterator(['yo', 'ya']);
console.log(it.next().value); // 'yo'
console.log(it.next().value); // 'ya'
console.log(it.next().done);  // true

```


# 生成器
它可以允许你定义一个包含自由迭代算法的函数，同事可以自动维护自己的状态

```js

function* idMaker() {
    var index = 0;
    while(true) {
        yield index++;
    }
}
var gen = idMaker();

console.log(gen.next().value); // 0
console.log(gen.next().value); // 1
console.log(gen.next().value); // 2
// ...

```

# 可迭代对象
一个定义了迭代行为的对象，比如在for...of中循环了哪些值。一些内置类型，如Array或Map具有默认的迭代行为，而其他类型（如Object）没有。


为了实现可迭代，一个对象必须实现 @@iterator 方法，这意味着这个对象（或其原型链中的一个对象）必须具有带 Symbol.iterator 键的属性：


```js

var myIterable = {};
myIterable[Symbol.iterator] = function* () {
    yield 1;
    yield 2;
    yield 3;
};

for (let value of myIterable) { 
    console.log(value); 
}
// 1
// 2
// 3

or

[...myIterable]; // [1, 2, 3]
```

## 内置迭代对象

String，Array，TypedArray，Map 和 Set 都内置可迭代对象，因为它们的原型对象都有一个 Symbol.iterator 方法。

## 用于可迭代对象的语法

```js

for (let value of ['a', 'b', 'c']) {
    console.log(value);
}
// "a"
// "b"
// "c"

[...'abc']; // ["a", "b", "c"]

function* gen() {
  yield* ['a', 'b', 'c'];
}

gen().next(); // { value: "a", done: false }

[a, b, c] = new Set(['a', 'b', 'c']);
a; // "a"

```
## 高级生成器

。。。


>The next() 方法也接受可用于修改生成器内部状态的值。传递给next()的值将被视为暂停生成器的最后一个yield表达式的结果。

以下是使用 next(x) 重新启动 fibonacci 序列生成器：


```js
function* fibonacci() {
  var fn1 = 0;
  var fn2 = 1;
  while (true) {  
    var current = fn1;
    fn1 = fn2;
    fn2 = current + fn1;
    var reset = yield current;
    if (reset) {
        fn1 = 0;
        fn2 = 1;
    }
  }
}

var sequence = fibonacci();
console.log(sequence.next().value);     // 0
console.log(sequence.next().value);     // 1
console.log(sequence.next().value);     // 1
console.log(sequence.next().value);     // 2
console.log(sequence.next().value);     // 3
console.log(sequence.next().value);     // 5
console.log(sequence.next().value);     // 8
console.log(sequence.next(true).value); // 0
console.log(sequence.next().value);     // 1
console.log(sequence.next().value);     // 1
console.log(sequence.next().value);     // 2

```

