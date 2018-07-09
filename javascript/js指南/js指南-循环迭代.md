
## for 语句

``` html
<form name="selectForm">
  <p>
    <label for="musicTypes">Choose some music types, then click the button below:</label>
    <select id="musicTypes" name="musicTypes" multiple="multiple">
      <option selected="selected">R&B</option>
      <option>爵士</option>
      <option>布鲁斯</option>
      <option>新纪元</option>
      <option>古典</option>
      <option>歌剧</option>
    </select>
  </p>
  <p><input id="btn" type="button" value="选择了多少个选项?" /></p>
</form>

<script>
function howMany(selectObject) {
  var numberSelected = 0;
  for (var i = 0; i < selectObject.options.length; i++) {
    if (selectObject.options[i].selected) {
      numberSelected++;
    }
  }
  return numberSelected;
}

var btn = document.getElementById("btn");
btn.addEventListener("click", function(){
  alert('选择选项的数量是: ' + howMany(document.selectForm.musicTypes))
});
</script>

```

## do..while 语句

``` js
do {
    i += 1;
    console.log(i);
} while (i<5)
```

## while 语句

```js
while(true) {
    console.log("hello");
}
```

## labeled 语句 (?)
提供一个可以引用到程序别的位置的标识符。

> 
label:\
statement

``` js
markLoop:
while(themark == true) {
    doSomething();
}
```
## break 语句

``` js
for (i = 0; i < a.length; i++) {
  if (a[i] == theValue) {
    break;
  }
}
```

## continue 语句

```js
for (i = 0; i < a.length; i++) {
  if (a[i] == theValue) {
    break;
  }
}
```

eg2:

``` js
checkiandj:
  while (i < 4) {
    console.log(i);
    i += 1;
    checkj:
      while (j > 4) {
        console.log(j);
        j -= 1;
        if ((j % 2) == 0) {
          continue checkj;
        }
        console.log(j + " is odd.");
      }
      console.log("i = " + i);
      console.log("j = " + j);
  }

```

## for... in 语句

```js
function dump_props(obj, obj_name) {
    var result = "";
    for (var i in obj) {
        result += obj_name + '.'
 + i + " = " + obj[i] + '<br>'  
 }
 result += '<hr>';
 return result;
}
```

>
**数组**
虽然用for...in 来迭代Array很诱人，但是它返回了除了数字索引外还有可能是你定义的属性名字，（ 额）因此还是用带有数字索引的传统for循环比较好，因为如果改变数组对象，比如添加属性或者方法，for...in 语句迭代的是自定义属性而不是数组的元素

## for...of 语句
可以在可迭代的对象上创建一个循环，对值的每一个独特的属性调用一个将要被执行的自定义和语句挂钩的迭代。

```js

let arr = [3, 5, 7];
arr.foo = "hello";

for(let i in arr) {
    console.log(i); // 0, 1, 2, foo
}

for(let i of arr) {
    console.log(i); // 3, 5, 7， 注意这里没有hello
}
```


