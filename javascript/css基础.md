
# CSS 基础
## Css  层叠次序

当同一个HTML被多个HTML元素被多个样式定义，使用样式的顺序：

1. 浏览器缺省设置
2. 外部样式表
3. 内部样式表
4. 内联样式

## CSS语法
```css
h1 {
  color: rred;
  font-size:14px;
}

p { color: #ff0000; }
p { color: #f00; }
p { color: rgb(255,0,0); }
p { color: rgb(100%,0%,0%); }

// 记得加引号
p {font-family: "sans serif";}

```

## 选择器的分组
```css
h1,h2,h3,h4,h5,h6 {
  color: green;
  }
```
## 继承问题

```css
body  {
     font-family: Verdana, sans-serif;
     }

td, ul, ol, ul, li, dl, dt, dd  {
     font-family: Verdana, sans-serif;
     }

// 如果不希望p标签继承body
p  {
     font-family: Times, "Times New Roman", serif;
     }
```

## 派生选择器
``` css
li strong {
    font-style: italic;
    font-weight: normal;
  }

```

## id 选择器

<p id="red">这个段落是红色。</p>
<p id="green">这个段落是绿色。</p>

```css
#red {color:red;}
#green {color:green;}
```

id属性只能在HTML文档中出现一次
被标注的元素，只能出现一次

## CSS类选择器

```css
.center {text-align: center}

<h1 class="center">
This heading will be center-aligned
</h1>

<p class="center">
This paragraph will also be center-aligned.
</p>
```

## 属性选择器？？

## 如何插入样式表

``` html
import 
<head>
<link rel="stylesheet" type="text/css" href="mystyle.css" />
</head>

inside
<style type="text/css">
  hr {color: sienna;}
  p {margin-left: 20px;}
  body {background-image: url("images/back40.gif");}
</style>

inline
<p style="color: sienna; margin-left: 20px">
This is a paragraph
</p>

```

## 多重样式
如果属性在不同的样式表中被同样的选择器定义，那么属性值将从更具体的样式表继承

``` css
import :
h3 {
  color: red;
  text-align: left;
  font-size: 8pt;
  }
inline:

h3 {
  text-align: right; 
  font-size: 20pt;
  }

final:

color: red; 
text-align: right; 
font-size: 20pt;
  
```

# CSS 样式
## CSS 背景


背景颜色
``` css
p {background-color: gray;}
p {background-color: gray; padding: 20px;}
```
背景图像
``` css
body {background-image: url(/i/eg_bg_04.gif);}

重复
background-repeat: repeat-y;
定位
background-position:center;
百分比
background-position:50% 50%;
背景关联，能够保证图像相对于可视区域固定
background-attachment:fixed
```

位置关键字
center
top
bottom
right
left

# CSS 文本

缩进文本

p {text-indent: 5em;}

水平对齐

text-align:center 与 <CENTER>

center对整个元素集中，text-align只会影响内部的内容，文字 等等

字间隔

``` css
p.spread {word-spacing: 30px;}
p.tight {word-spacing: -0.5em;}

<p class="spread">
This is a paragraph. The spaces between words will be increased.
</p>

<p class="tight">
This is a paragraph. The spaces between words will be decreased.
</p>
```

字母间隔

``` css
h1 {letter-spacing: -0.5em}
h4 {letter-spacing: 20px}

<h1>This is header 1</h1>
<h4>This is header 4</h4>
```

文本装饰
text-decoration:
1. none
2. underline
3. overline
4. line-through
5. blink

不过要注意的是，如果两个不同的装饰都与同一元素匹配，胜出规则的值会完全取代另一个值。请考虑以下的规则

h2.stricken {text-decoration: line-through;}
h2 {text-decoration: underline overline;}

对于给定的规则，所有 class 为 stricken 的 h2 元素都只有一个贯穿线装饰，而没有下划线和上划线，因为 text-decoration 值会替换而不是累积起来。

``` css

```

处理空白符
white-space ??

## CSS 字体
定义了5中通用的字体

    Serif 字体
    Sans-serif 字体
    Monospace 字体
    Cursive 字体
    Fantasy 字体

指定字体
``` css
body {font-family: sans-serif;}
if one not exist, use second
h1 {font-family: Georgia, serif;}
```
字体风格：

    normal - 文本正常显示
    italic - 文本斜体显示
    oblique - 文本倾斜显示

``` css
p.normal {font-style:normal;}
p.italic {font-style:italic;}
p.oblique {font-style:oblique;}
```

字体变形

``` html
<html>
<head>
<style type="text/css">
p.normal {font-variant: normal}
p.small {font-variant: small-caps}
</style>
</head>

<body>
<p class="normal">This is a paragraph</p>
<p class="small">This is a paragraph</p>
</body>

</html>

```

字体加粗
``` css
p.normal {font-weight:normal;}
p.thick {font-weight:bold;}
p.thicker {font-weight:900;}

```
字体大小

绝对值: 
  * 文本设置指定大小
  * 不允许浏览器中改变大小
  * 绝对大小在舒畅的无力尺寸时很有用
 
相对大小：
  * 相对周围元素设置大小
  * 允许用户在浏览器改变文本大小
  
``` css
h1 {font-size:60px;}
h2 {font-size:40px;}
p {font-size:14px;}

```

## CSS 链接

``` css
a:link {color:#FF0000;}		/* 未被访问的链接 */
a:visited {color:#00FF00;}	/* 已被访问的链接 */
a:hover {color:#FF00FF;}	/* 鼠标指针移动到链接上 */
a:active {color:#0000FF;}	/* 正在被点击的链接 */
```

## CSS 列表

``` css

ul {list-style-type : square}
ul.circle {list-style-type:circle;}
ul.square {list-style-type:square;}
ol.upper-roman {list-style-type:upper-roman;}
ol.lower-alpha {list-style-type:lower-alpha;}
```

## CSS 表格

``` css
table, th, td
  {
  border: 1px solid blue;
  }

```

折叠边框（边框之间是否有空隙）

``` css
table
  {
  border-collapse:collapse;
  }

table,th, td
  {
  border: 1px solid black;
  }
  
  height
  
  table
  {
  width:100%;
  }

th
  {
  height:50px;
  }
对齐

td
  {
  text-align:right;
  }
垂直对齐
td
  {
  height:50px;
  vertical-align:bottom;
  }
  
other attributes
td
  {
  padding:15px;
  }

table, td, th
  {
  border:1px solid green;
  }

th
  {
  background-color:green;
  color:white;
  }
  
```

## CSS 轮廓

轮廓（outline）是绘制于元素周围的一条线，位于边框边缘的外围，可起到突出元素的作用。
CSS outline 属性规定元素轮廓的样式、颜色和宽度。
``` css
p 
{
border:red solid thin;
outline-style:dotted; // 外部轮廓变成红点点
outline-color:#00ff00;
}

```

## CSS 框模型

CSS 框模型 (Box Model) 规定了元素框处理元素内容、内边距、边框 和 外边距 的方式。

提示：背景应用于由内容和内边距、边框组成的区域。
内边距、边框和外边距都是可选的，默认值是零。但是，许多元素将由用户代理样式表设置外边距和内边距。可以通过将元素的 margin 和 padding 设置为零来覆盖这些浏览器样式。这可以分别进行，也可以使用通用选择器对所有元素进行设置：

![](http://www.w3school.com.cn/i/ct_css_boxmodel_example.gif)

``` css
#box {
  width: 70px;
  margin: 10px;
  padding: 5px;
}

```

width宽度能保证，然后加上padding的距离是box的全部长度，跟外部的距离是10px margin

单边内边距属性

``` css

h1 {
  padding-top: 10px;
  padding-right: 0.25em;
  padding-bottom: 2ex;
  padding-left: 20%;
  }
h1 {padding: 10px 0.25em 2ex 20%;}

　二者等同
```

## CSS 边框



