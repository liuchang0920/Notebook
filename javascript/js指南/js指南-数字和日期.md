
# 数字

## 十进制

0888 
0777 // 非严格模式 会当做8进制

## 二进制

0b or 0B

如果后面的数字不是0或1，就会是语法错误


## 八进制

0开头，后面如果不是0-7范围内，会转成10进制

## 十六进制

0x，如果不是0-9A-F 
那么会提示语法错误

## 指数形式

1E3 // 1000
3e6 // 2000000

0.1e2 // 10


# 数字对象

```js
var biggestNum = Number.MAX_VALUE;
var smallestNum = Number.MIN_VALUE;
var infiniteNum = Number.POSITIVE_INFINITY;
var negInfiniteNum = Number.NEGATIVE_INFINITY;
var notANum = Number.NaN;
```

永远只能从number对象引用上边显示的属性，而不是自己创建的number对象属性


|属性|	描述|
|-----|-----|
|Number.MAX_VALUE	|可表示的最大值|
|Number.MIN_VALUE	|可表示的最小值|
|Number.NaN	|特指”非数字“|
|Number.NEGATIVE_INFINITY	|特指“负无穷”;在溢出时返回|
|Number.POSITIVE_INFINITY	|特指“正无穷”;在溢出时返回|
|Number.EPSILON	|表示1和比最接近1且大于1的最小Number之间的差别|
|Number.MIN_SAFE_INTEGER	|JavaScript最小安全整数.|
|Number.MAX_SAFE_INTEGER	|JavaScript最大安全整数.|

# 数字的方法

| 方法| 描述|
| --- | -----|
|parseFloat()|把字符串参数解析成浮点数，和全局方法 parseFloat() 作用一致.|
|parseInt()|把字符串解析成特定基数对应的整型数字，和全局方法 parseInt() 作用一致.|
|isFinite()|判断传递的值是否为有限数字。|判断传递的值是否为整数。|
|isInteger()|判断传递的值是否为整数。|
|isNaN()|判断传递的值是否为 NaN. More robust version of the original global isNaN().|
isSafeInteger()|判断传递的值是否为安全整数。|

# 数字对象(Math)


eg:

Math.PI

Math.sin(1.56) 弧度制

方法：

| 方法 | 描述|
|-----|-----|
|abs()| |
|sin(), cos, tan()||
|asin(), acos(), atan(), atan2()||
|sinh(), cosh(), tanh()||
|....||
|pow(), exp(), expm1, log10(), log1p(), log2()||
|floor(), ceil()||
|min(), max()||
|random()||
|round, fround, trunc()||
|sqrt, cbrt, hypot()|平方根，立方根，平方参数的和的平方根|
|sign()|数字的符号，> = < 0|
|clz32(), imul()||

-----

# 日期对象
Date对象包含大量的设值，获取，和操作日期的方法，并不包含任何属性

Date 对象的范围是相对距离 UTC 1970年1月1日 的前后 100,000,000 天。

```js
var date = new Date([params])


```

传入参数：

月份 0-11月，别搞错了

1. 无参数
2. 一个符合以下格式的日期和字符串 eg: Date("December 25, 1995 13:00")
3. 一个年月，日，的整型值的集合： var xmax95 = new Date(1995, 11, 25)
4. 一个年月日，时分秒，的集合: var xmax95 = new Date(1995, 11, 25, 9, 30, 0);


## Date 对象的方法

1. set
2. get
3. to  tostring etc
4. parse, UTC, parse date string

getTime 获取从1970年1月1日的毫秒数


```js

var today = new Date();
var endYear = new Date(1995, 11, 31, 23, 59, 59, 999);
endYear.setFullyear(today.getFullYear);
var msPerDay = 24 * 60 * 60 * 1000; // today's ms
var daysLeft = (endyear.getTime() - today.getTime()) ; // ms perday
var daysLeft = Math.round(daysLeft);
```

parse
```js
var IPOdate = new Date();
IPOdate.setTime(Date.pargse("Aug 9, 1995"));
```

