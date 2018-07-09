
# 映射

## Map对象

```js

    var sayings = new Map();
    sayings.set('dog', 'woof');
    sayings.set('cat', 'meow');
    sayings.set('elephant', 'toot');
    sayings.size; // 3
    sayings.get('fox'); // undefined
    sayings.has('bird'); // false
    sayings.delete('dog');
    sayings.has('dog'); // false

    for(var [key, value] of sayings) {
        console.log(key + 'goest' + value);

    }
    sayings.clear();
    sayings.size;

```

## Weak map 对象
他的键必须是对象类型，当期键所指对昂没有引用的时候，会被GC回收掉。



# 集合

```js

var mySet = new Set();
myset.add(1);

mySet.has(1); // trye

var mySet = new Set();
mySet.add(1);
mySet.add("some text");
mySet.add("foo");

mySet.has(1); // true
mySet.delete("foo");
mySet.size; // 2

for (let item of mySet) console.log(item);



```


## 数组和集合的转换

```js

Array.from(mySet);

mySet2 = new Set([1, 2, 3, 4]);
```

## 对比

* indexOf效率低下
* Set 允许根据值删除元素，array必须使用给予下标的splice方法
* indexOf方法无法找到NaN值
* Set对象不重复的值，不需要手动处理重复的值

## WeakSet

* WeakSets中的值必须是对象类型，不可以是别的类型
* WeakSet的“weak”指的是，对集合中的对象，如果不存在其他引用，那么该对象将可被垃圾回收。于是不存在一个当前可用对象组成的列表，所以WeakSets不可枚举

## 键值判断

* 判断使用与===相似的规则。
* -0和+0相等。
* NaN与自身相等（与===有所不同）。
