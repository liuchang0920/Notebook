
# 对象概述


```js

var myCar = new Object();
myCar.make = "Ford";
myCar.model = "Mustang";
myCar.year = 1969;

myCar.onProperty;// undefined

// 可以通过方括号设值
myCar["make"] = "Ford";
myCar["model"] = "Mustang";
myCar["year"] = 1969;

```

```js

// 同时创建四个变量，用逗号分隔
var myObj = new Object(),
    str = "myString",
    rand = Math.random(),
    obj = new Object();

myObj.type              = "Dot syntax";
myObj["date created"]   = "String with space";
myObj[str]              = "String value";
myObj[rand]             = "Random Number";
myObj[obj]              = "Object";
myObj[""]               = "Even an empty string";

console.log(myObj);

```
>请注意，方括号中的所有键都将转换为字符串类型，因为JavaScript中的对象只能使用String类型作为键类型。 例如，在上面的代码中，当将键obj添加到myObj时，JavaScript将调用obj.toString()方法，并将此结果字符串用作新键。

## 枚举一个对象的全部属性

* for... in: 该方法依次访问一个对象及其原型链中所有可枚举的属性。
* Object.keys(o): 该方法返回一个对象 o 自身包含（不包括原型中）的所有属性的名称的数组。
* Object.getOwnPropertyNames(x): 该方法返回一个数组，它包含了对象 o 所有拥有的属性（无论是否可枚举）的名称。


```js
// ????
function listAllProperties(o){     
	var objectToInspect;     
	var result = [];
	
	for(objectToInspect = o; objectToInspect !== null; objectToInspect = Object.getPrototypeOf(objectToInspect)){  
		result = result.concat(Object.getOwnPropertyNames(objectToInspect));  
	}
	
	return result; 
}
```


## 使用构造函数

1. 铜鼓欧床架哪一个构造函数来定义而对象的类型。
2. 通过new 创建对象的实例

```js

function Car(make, model, year) {
  this.make = make;
  this.model = model;
  this.year = year;
}

var mycar = new Car("Eagle", "Talon TSi", 1993);

```

## 使用 object.create 方法

create() 方法创建，允许为床架你的对象选择原型对象，而不用定义一个构造函数

```js
// Animal properties and method encapsulation
var Animal = {
  type: "Invertebrates", // Default value of properties
  displayType : function() {  // Method which will display type of Animal
    console.log(this.type);
  }
}

// Create new animal type called animal1 
var animal1 = Object.create(Animal);
animal1.displayType(); // Output:Invertebrates

// Create new animal type called Fishes
var fish = Object.create(Animal);
fish.type = "Fishes";
fish.displayType(); // Output:Fishes

```



## 继承
所有的js对象继承与至少一个对象，被集成的对象乘坐原型，集成的属性可通过构造函数的prototype对象找到。

## 对象属性索引

为对象类型定义属性

你可以通过 prototype 属性为之前定义的对象类型增加属性。这为该类型的所有对象，而不是仅仅一个对象增加了一个属性。下面的代码为所有类型为 car 的对象增加了 color 属性，然后为对象 car1 的 color 属性赋值：


```js
Car.prototype.color = null;
car1.color = "black";

```


## this指针？？？


## getter setter`

```js

var o = {
  a: 7,
  get b() { 
    return this.a + 1;
  },
  set c(x) {
    this.a = x / 2
  }
};

console.log(o.a); // 7
console.log(o.b); // 8
o.c = 50;
console.log(o.a); // 25
```
... 省略

## 删除属性
``` js
// k可以使用 delete操作符删除一个不是继承而来的属性

var myobject= new Object;
myobj.a = 13;
myobj.b = 1;

delete myobj.a;


```
## 对象的比较
``` js

var fruit = {
    name: 'apple'
}
var fruitbear = {
    name: 'apple'
}

fruit == fruitbear // false
fruit === fruitbear // true

// 两个独立声明的对象永远不会相等
// 只有在比较一个对象和这个对象的引用时，待会返回true

```

> === 用于比较数值是否相等。: 1 === "1" false, 1 == "1" return true ??