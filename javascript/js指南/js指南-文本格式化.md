# 字符串
....

## 字符串对象

```js
var s = new String("foo");
console.log(s);
typeof s； // return 'object'
```


**尽量使用string的字面值， 因为某些行为可能不一致**
```js

var s1 = "2 + 2"; // Creates a string literal value
var s2 = new String("2 + 2"); // Creates a String object
eval(s1); // Returns the number 4
eval(s2); // Returns the string "2 + 2"
```


总结string的用法

|方法| 描述|
|-----|-----|
| charAt, charCodeAt, codePointAt||
| indexOf, lastIndexOf||
| starsWith, endsWithd, includes||
|concat ||
|fromCharCode, fromCodePoint|从制定的Unicode值序列构造一个字符串|
|split||
|slice|从一个字符串能提取片段并作为新的字符串返回|
|substring, substr|从指定的起始和中介的位置，返回指定子集|
|match， replace， search| 正则表达式来工作|
| toLowerCase, toUpperCase||
|normalize| 指定的一种Unicode正规形式将当前字符串正规化|
|repeat|将字符串内容重复次数后返回|
|trim|取表开头和结尾的空白字符|

## 多行

```js
console.log("string i\n\
string text line2");

// "string text line 1
// string text line 2"

console.log(`strin text line1
strin text line2`);
//一样的
```

##嵌入表达式

```js
var a = 5;
var b = 10;
console.log(`Fifteen is ${a + b} and\nnot ${2 * a + b}.`);
// "Fifteen is 15 and
// not 20."
```
