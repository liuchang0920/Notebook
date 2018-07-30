

## Intro
构造对象的传统方法是通过构造函数

```js

function Point(x, y) {
  this.x = x;
  this.y = y;
}

Point.prototype.toString = function () {
  return '(' + this.x + ', ' + this.y + ')';
};

var p = new Point(1, 2);

```

ES6 提供了 Class类 这个概念

```js
//定义类
class Point {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

  toString() {
    return '(' + this.x + ', ' + this.y + ')';
  }
}

```
constructor 构造方法

```js
可以当作是构造函数的另一个写法

class Point {
  // ...
}

typeof Point // "function"
Point === Point.prototype.constructor // true


创建对象使用New 命令

class Bar {
  doStuff() {
    console.log('stuff');
  }
}

var b = new Bar();
b.doStuff() // "stuff"

```

实际上，所有的方法都定义在类的prototype属性上

```js
class Point {
  constructor() {
    // ...
  }

  toString() {
    // ...
  }

  toValue() {
    // ...
  }
}

// 等同于

Point.prototype = {
  constructor() {},
  toString() {},
  toValue() {},
};

class B {}
let b = new B();

b.constructor === B.prototype.constructor // true
```

，类的内部所有定义的方法，都是不可枚举的（non-enumerable） 不可枚举？

```js
class Point {
  constructor(x, y) {
    // ...
  }

  toString() {
    // ...
  }
}

Object.keys(Point.prototype)
// []
Object.getOwnPropertyNames(Point.prototype)
// ["constructor","toString"]

```

类的属性名，可以采用表达式

```js
let methodName = 'getArea';

class Square {
  constructor(length) {
    // ...
  }

  [methodName]() {
    // ...
  }
}
```

## 2. 严格模式

类和模块的内部，默认都是严格模式。

## 3. constructor 

```js
class Point {
}

// 等同于
class Point {
  constructor() {}
}
```


上面代码中，定义了一个空的类Point，JavaScript 引擎会自动为它添加一个空的constructor方法。

constructor方法默认返回实例对象（即this），完全可以指定返回另外一个对象。


```js
class Foo {
  constructor() {
    return Object.create(null);
  }
}

new Foo() instanceof Foo
// false
```

类需要使用new调用，否则会报错。这个是跟普通构造函数的区别，后者不一定需要new 操作


```js
class Foo {
  constructor() {
    return Object.create(null);
  }
}

Foo()
// TypeError: Class constructor Foo cannot be invoked without 'new'
会报错
```


## 4. 类的实例对象

```js
class Point {
  // ...
}

// 报错
var point = Point(2, 3);

// 正确
var point = new Point(2, 3);

```

与ES5一样，实例的属性除非显示定义在其本身(定义在this上)，否则都定义在原型上。


```js
//定义类
class Point {

  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

  toString() {
    return '(' + this.x + ', ' + this.y + ')';
  }

}

var point = new Point(2, 3);

point.toString() // (2, 3)

point.hasOwnProperty('x') // true
point.hasOwnProperty('y') // true
point.hasOwnProperty('toString') // false
point.__proto__.hasOwnProperty('toString') // true
```

与ES5一样，类的所有实例共享一个原型对象

```js

var p1 = new Point(2,3);
var p2 = new Point(3,2);

p1.__proto__ === p2.__proto__
//true

```

    __proto__ 并不是语言本身的特性，这是各大厂商具体实现时添加的私有属性，虽然目前很多现代浏览器的 JS 引擎中都提供了这个私有属性，但依旧不建议在生产中使用该属性，避免对环境产生依赖。生产环境中，我们可以使用 Object.getPrototypeOf 方法来获取实例对象的原型，然后再来为原型添加方法/属性。

原型的方法，所有的对象共有

```js
var p1 = new Point(2,3);
var p2 = new Point(3,2);

p1.__proto__.printName = function () { return 'Oops' };

p1.printName() // "Oops"
p2.printName() // "Oops"

var p3 = new Point(4,2);
p3.printName() // "Oops"

```

## 5. Class 表达式

```js

const MyClass = class Me {
  getClassName() {
    return Me.name;
  }
};

// Me 只在类内部可以调用到

```

Me 也可以省略

```js
let person = new class {
  constructor(name) {
    this.name = name;
  }

  sayName() {
    console.log(this.name);
  }
}('张三');

person.sayName(); // "张三"
```

## 6. 不存在变量的提升

new Foo(); // ReferenceError
class Foo {}

原因

上面代码中，Foo类使用在前，定义在后，这样会报错，因为 ES6 不会把类的声明提升到代码头部。这种规定的原因与下文要提到的继承有关，必须保证子类在父类之后定义。

```js
{
  let Foo = class {};
  class Bar extends Foo {
  }
}
```

上面的代码不会报错，因为Bar继承Foo的时候，Foo已经有定义了。但是，如果存在class的提升，上面代码就会报错，因为class会被提升到代码头部，而let命令是不提升的，所以导致Bar继承Foo的时候，Foo还没有定义。

## 7. 私有方法，私有属性

```js
ES6不提供 私有方法

class Widget {

  // 公有方法
  foo (baz) {
    this._bar(baz);
  }

  // 私有方法
  _bar(baz) {
    return this.snaf = baz;
  }

  // ...
}


```

另一个方法是将私有方法移除模块，模块的内部所有方法都是对外可见的。

```js
class Widget {
  foo (baz) {
    bar.call(this, baz);
  }

  // ...
}

function bar(baz) {
  return this.snaf = baz;
}

```

使用Symbol值

```js
const bar = Symbol('bar');
const snaf = Symbol('snaf');

export default class myClass{

  // 公有方法
  foo(baz) {
    this[bar](baz);
  }

  // 私有方法
  [bar](baz) {
    return this[snaf] = baz;
  }

  // ...
};
```

## 私有属性的提案

另外，私有属性也可以设置 getter 和 setter 方法。

class Counter {
  #xValue = 0;

  get #x() { return #xValue; }
  set #x(value) {
    this.#xValue = value;
  }

  constructor() {
    super();
    // ...
  }
}
上面代码中，#x是一个私有属性，它的读写都通过get #x()和set #x()来完成。


## 8. this指向




thanks. I did the step one. and there are two things I might touch base before changing. 
1. since the current FAC is called 'user-pool', the 'add-application-full-page' feature name seems not in the same hierarch as the 'user-pool'. Maybe I should use 'applications'?

2. since the changes are locally, will the assets see the newly added FAC ?


建议使用箭头函数

```js

class Logger {
  constructor() {
    this.printName = (name = 'there') => {
      this.print(`Hello ${name}`);
    };
  }

  // ...
}

一种解决方法是使用proxy ？？ 
function selfish (target) {
  const cache = new WeakMap();
  const handler = {
    get (target, key) {
      const value = Reflect.get(target, key);
      if (typeof value !== 'function') {
        return value;
      }
      if (!cache.has(value)) {
        cache.set(value, value.bind(target));
      }
      return cache.get(value);
    }
  };
  const proxy = new Proxy(target, handler);
  return proxy;
}

const logger = selfish(new Logger());


```


## 9. name 属性

```js
class Point {}
Point.name // "Point"

```

## 10. class getter and setter

可以在类内部使用 get， set关键字

```js
class MyClass {
  constructor() {
    // ...
  }
  get prop() {
    return 'getter';
  }
  set prop(value) {
    console.log('setter: '+value);
  }
}

let inst = new MyClass();

inst.prop = 123;
// setter: 123

inst.prop
// 'getter'

```

没懂

```js
class CustomHTMLElement {
  constructor(element) {
    this.element = element;
  }

  get html() {
    return this.element.innerHTML;
  }

  set html(value) {
    this.element.innerHTML = value;
  }
}

var descriptor = Object.getOwnPropertyDescriptor(
  CustomHTMLElement.prototype, "html"
);

"get" in descriptor  // true
"set" in descriptor  // true

```
## 11. class 的generator 方法
？？

```js
class Foo {
  constructor(...args) {
    this.args = args;
  }
  * [Symbol.iterator]() {
    for (let arg of this.args) {
      yield arg;
    }
  }
}

for (let x of new Foo('hello', 'world')) {
  console.log(x);
}
// hello
// world
```

why do that

## 12. class 静态方法

类相当于市实例的原型，所有在类中定义的方法，都会被实例继承。

如果加上static
 关键字，改方法不会被实例继承，而是直接通过类调用。

```js
class Foo {
  static classMethod() {
    return 'hello';
  }
}

Foo.classMethod() // 'hello'

var foo = new Foo();
foo.classMethod()
// TypeError: foo.classMethod is not a function

```

上面代码中，Foo类的classMethod方法前有static关键字，表明该方法是一个静态方法，可以直接在Foo类上调用（Foo.classMethod()），而不是在Foo类的实例上调用。如果在实例上调用静态方法，会抛出一个错误，表示不存在该方法。

> 静态方法中的this指向的是这个类，而不是实例


```js
class Foo {
  static bar () {
    this.baz();
  }
  static baz () {
    console.log('hello');
  }
  baz () {
    console.log('world');
  }
}

Foo.bar() // hello
```

父类的静态方法，可以被子类继承

```js

class Foo {
  static classMethod() {
    return 'hello';
  }
}

class Bar extends Foo {
}

Bar.classMethod() // 'hello'


也可以从super上调用

class Foo {
  static classMethod() {
    return 'hello';
  }
}

class Bar extends Foo {
  static classMethod() {
    return super.classMethod() + ', too';
  }
}

Bar.classMethod() // "hello, too"


```


## 13. class的静态属性和实例属性

```js
class Foo {
}

Foo.prop = 1;
Foo.prop // 1

```
目前只有这一种写法，ES6规定，class内部只有静态方法，没有静态属性

```js
// 以下两种写法都无效
class Foo {
  // 写法一
  prop: 2

  // 写法二
  static prop: 2
}

Foo.prop // undefined

```

目前有静态属性的提案：

1. 类的实例属性

```js
class MyClass {
  myProp = 42;

  constructor() {
    console.log(this.myProp); // 42
  }
}

```
MyClass的实例上能够获得这个属性

2. 类的静态属性

加上关键字static

```js

class class MyClassMyClass  {{
  static myStaticProp    stati = 42;

  constructor() {
    console.log(MyClass.myStaticProp); // 42
  }
}

// 老写法
class Foo {
  // ...
}
Foo.prop = 1;

// 新写法
class Foo {
  static prop = 1;
}

```

## 14.new.target 属性

？？？