# Indexed Collections

# Array Object

## creating array
```js
var arr  = new Array(....);
var arr = Array(....);
var arr = [...];

// 译者注: var arr=[4] 和 var arr=new Array(4)是不等效的，
后者长度是4
```

```js
var arr = new Array(arrayLength);
var arr = Array(arrayLength);

// 这样有同样的效果
var arr = [];
arr.length = arrayLength;
```

## 填充数组
```js

var emp = [];
emp[0] = "Casey Jones";
emp[1] = "Phil Lesh";
emp[2] = "August West";

```

> 如果以上的代码，给的数组操作符是一个非整形的数值，那么将作为一个代表数组的对象属性创建，而非作为数组的元素

```js

var arr= [];
arr[3.4] = "orange";
console.log(arr.hasOwnProperty(3.4)); // true
```

```js
// 
var myArray = new Array("Hello", myVar, 3.14159);
var myArray = ["Mango", "Apple", "Orange"]
```


## 理解 lenth
```js
var cats = [];
cats[30] = ['ddd'];
console.log(cats.length); //31
```

## 遍历数组

```js
var colors = ['red', 'green', 'blue'];
for (var i = 0; i < colors.length; i++) {
  console.log(colors[i]);
}

var colors = ['red', 'green', 'blue'];
colors.forEach(function(color) {
  console.log(color);
});


```


> 在数组定义时，省略的元素不会在foreach便利时被支出，但是手动赋值为undefined的元素是会被列出的

```js
var array = ['first', 'second', , 'fourth'];

// returns ['first', 'second', 'fourth'];
array.forEach(function(element) {
  console.log(element);
})

if(array[2] === undefined) { console.log('array[2] is undefined'); } // true

var array = ['first', 'second', undefined, 'fourth'];

// returns ['first', 'second', undefined, 'fourth'];
array.forEach(function(element) {
  console.log(element);
})

```

## 数组方法

* concat 
* join(deliminator = ',')
* push(): 数组尾部添加元素， 返回数组长度
* pop(): 从数组移除最后一个元素，返回该元素
* shift(): 移除第一个元素
* unshift(): 数组开头添加一个或者多个元素，返回新的长度
* slice(start+index, upto+index) // [ , )
* splice ??
* reverse(): reverse
* sort(): 排序, 也可以指定怎么比较元素
    ```js
    var sortFn = function(a, b){
    if (a[a.length - 1] < b[b.length - 1]) return -1;
    if (a[a.length - 1] > b[b.length - 1]) return 1;
    if (a[a.length - 1] == b[b.length - 1]) return 0;
    }
    myArray.sort(sortFn); 
    // sorts the array so that myArray = ["Wind","Fire","Rain"]

    ```
* indexOf(searchElement, [, fromIndex])

    ``` js

        console.log(a.indexOf('b', 2)); // logs 3
    ```
* lastIndexOf(searchelement， [fromIndex]); 尾部开始找
* forEach(callback, [, thisobject]);

    ```js

        var a = [1, 2, 3]
        a.forEach(function(element) {
            console.log(element);
        })
    ```
* map(callback, [, thisobject])

    ```js
        var a1 = [1, 2 ,3]
        var a2 = a1.map(function(item) {
            return item.toUpperCase();
        })
        console.log(a2);
    ```
* filter(callback, [, thisobject]) 
    ```js
        var a1 = ['a', 10, 'b', 20, 'c', 30];
        var a2 = a1.filter(function(item) { return typeof item == 'number'; });
        console.log(a2); // logs 10,20,30
    ```

* every(callback, [, thisobject]) 判断是不是数组中的所有元素都符合条件

    ```JS

        function isNumber(value){
        return typeof value == 'number';
        }
        var a1 = [1, 2, 3];
        console.log(a1.every(isNumber)); // logs true
        var a2 = [1, '2', 3];
        console.log(a2.every(isNumber)); // logs false
    ```

* some(CALLBACK, [, thisobject])
    ```js
        function isNumber(value){
        return typeof value == 'number';
        }
        var a1 = [1, 2, 3];
        console.log(a1.some(isNumber)); // logs true
        var a2 = [1, '2', 3];
        console.log(a2.some(isNumber)); // logs true
        var a3 = ['1', '2', '3'];
        console.log(a3.some(isNumber)); // logs false

    ```
## 多维数组

```js

var a = new Array(4);
for (i = 0; i < 4; i++) {
  a[i] = new Array(4);
  for (j = 0; j < 4; j++) {
    a[i][j] = "[" + i + "," + j + "]";
  }
}
```

Array的常规方法对字符串可以运行的很好，因为它提供了序列访问字符转为数组的简单方法：

```js

Array.foreach('a string', function (chr) {
    conosle.log(chr);
})
```


