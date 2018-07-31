
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

border style
``` html
<style type="text/css">
p.dotted {border-style: dotted}
p.dashed {border-style: dashed}
p.solid {border-style: solid}
p.double {border-style: double}
p.groove {border-style: groove}
p.ridge {border-style: ridge}
p.inset {border-style: inset}
p.outset {border-style: outset}
  
多种样式
p.aside {border-style: solid dotted dashed double;}
</style>


四个方向
p {
  border-style: solid;
  border-top-width: 15px;
  border-right-width: 5px;
  border-bottom-width: 15px;
  border-left-width: 5px;
  }
p {border-style: solid; border-width: 15px 5px;}

```
border-style默认是none，如果没有声明样式，相当于是none。
如果需要边框出现，就需要声明一个**边框样式**

## Border? Border-style ??

## CSS 外边距

margin 属性
``` css
h1 {margin : 0.25in;}
h1 {margin : 10px 0px 15px 5px;} //  默认顺序从top 顺时针旋转

p {margin : 10%;} // margin可以设置百分比
```

百分数是相对于夫元素的width计算的。 p元素的margin设置成外部width的10%

值复制
![](http://www.w3school.com.cn/i/ct_css_margin_value.gif)

换句话说，如果为外边距指定了 3 个值，则第 4 个值（即左外边距）会从第 2 个值（右外边距）复制得到。如果给定了两个值，第 4 个值会从第 2 个值复制得到，第 3 个值（下外边距）会从第 1 个值（上外边距）复制得到。最后一个情况，如果只给定一个值，那么其他 3 个外边距都由这个值（上外边距）复制得到。

隔一个引用。。



## CSS 外边距 合并 ？？
外边距合并（叠加）是一个相当简单的概念。但是，在实践中对网页进行布局时，它会造成许多混淆。

简单地说，外边距合并指的是，当两个垂直外边距相遇时，它们将形成一个外边距。合并后的外边距的高度等于两个发生合并的外边距的高度中的较大者。

当一个元素出现在另一个元素上面时，第一个元素的下外边距与第二个元素的上外边距会发生合并。请看下图

垂直方向
http://www.w3school.com.cn/css/css_margin_collapsing.asp
![](http://www.w3school.com.cn/i/ct_css_margin_collapsing.gif)

maybe it is useful

## CSS定位

## 一切皆为框

div, h1, p 称为块级元素， 显示一块内容
span, strong等成为行内元素，即行内框

您可以使用 display 属性改变生成的框的类型。这意味着，通过将 display 属性设置为 block，可以让行内元素（比如 <a> 元素）表现得像块级元素一样。还可以通过把 display 设置为 none，让生成的元素根本没有框。这样的话，该框及其所有内容就不再显示，不占用文档中的空间
  
 ## CSS 定位机制
 
 1. 普通流
 2. 浮动
 3. 绝对定位

* static：元素框正常显示，块级元素生成一个矩形框。作为文档流的一部分，行内元素则会创建一个或多个行框，置于其父元素中。
* relative：元素框偏移某个距离。元素仍保持其未定位前的形状，它原本所占的空间仍保留。
* absolute: 元素框从文档溜完全删除，并相对于其包含块 定位。包含块可能是文档中的另一个元素或者是初始包含块 ？？
  元素原先在正常文档流中所占的空间会关闭，就好像元素原来不存在一样。元素定位后生成一个块级框，而不论原来它在正常流中生成何种类型的框。
  
* fixed: 元素框的表现类似于将 position 设置为 absolute，不过其包含块是视窗本身。

## fixed absolute 区别 （资料补充）

1、static（静态定位）：默认值。没有定位，元素出现在正常的流中（忽略 top, bottom, left, right 或者 z-index 声明）。

2、relative（相对定位）：生成相对定位的元素，通过top,bottom,left,right的设置相对于其正常（原先本身）位置进行定位。可通过z-index进行层次分级。　　

3、absolute（绝对定位）：生成绝对定位的元素，相对于 static 定位以外的第一个父元素进行定位。元素的位置通过 "left", "top", "right" 以及 "bottom" 属性进行规定。可通过z-index进行层次分级。

4、fixed（固定定位）：生成绝对定位的元素，相对于浏览器窗口进行定位。元素的位置通过 "left", "top", "right" 以及 "bottom" 属性进行规定。可通过z-index进行层次分级。

static与fixed的定位方式较好理解，在此不做分析。下面对应用的较多的relative和absolute进行分析：

https://www.cnblogs.com/theWayToAce/p/5264436.html


## CSS 相对定位
设置为相对定位的元素框，会偏移某个距离，元素仍然保持其未定位前的形状，它原本所占的空间，仍然保留 (相对于在流模式下的位置？)

eg：
``` css
#box_relative {
  position: relative;
  left: 30px;
  top: 20px;
}
```
![](http://www.w3school.com.cn/i/ct_css_positioning_relative_example.gif)

## CSS 绝对定位
设置为绝对定位的元素框，从文档流完全删除，并相对其包含块定位，包含块可能是文档中的另一个元素，或者初始包含块。
元素原先在文档流中的空间会关闭，就好像该元素不存在一样。
元素定位后，生成一个块级框，而不论原来它在正常流中生成何种类型的框。

绝对定位使元素的位置与文档流无关，因此不占据空间。这一点与相对定位不同，相对定位实际上被看作普通流定位模型的一部分，因为元素的位置相对于它在普通流中的位置。

绝对定位的元素的位置，相对于最近的已定位祖先的元素，如果元素没有已定位的祖先元素，那么她的位置相对于最初的包含块。

eg:
``` css
#box_relative {
  position: absolute;
  left: 30px;
  top: 20px;
}
```

![](http://www.w3school.com.cn/i/ct_css_positioning_absolute_example.gif)

## CSS 浮动 
浮动的框可以左右移动，直到它的外边缘碰到包含框或者另一个浮动框的边框位为止。
由于浮动框不在文档的普通流中，所以文档的普通流中的块框表现的就像是浮动框不存在一样

![](http://www.w3school.com.cn/i/ct_css_positioning_floating_right_example.gif)

eg:

当框1向左浮动的时候，由于它脱离了文档流并向左移动，直到它左边碰到框的左边缘， 因为它不在处于文档流中，所以不占用空间，实际上覆盖住了框2.


![](http://www.w3school.com.cn/i/ct_css_positioning_floating_left_example.gif)

如下图所示，如果包含框太窄，无法容纳水平排列的三个浮动元素，那么其它浮动块向下移动，直到有足够的空间。如果浮动元素的高度不同，那么当它们向下移动时可能被其它浮动元素“卡住”：

注意高度入多不统一的话会有一些问题

![](http://www.w3school.com.cn/i/ct_css_positioning_floating_left_example_2.gif)

## CSS float属性

???

让我们更详细地看看浮动和清理。假设希望让一个图片浮动到文本块的左边，并且希望这幅图片和文本包含在另一个具有背景颜色和边框的元素中。您可能编写下面的代码：

```css
.news {
  background-color: gray;
  border: solid 1px black;
  }

.news img {
  float: left;
  }

.news p {
  float: right;
  }

<div class="news">
<img src="news-pic.jpg" />
<p>some text</p>
</div>
```

![](http://www.w3school.com.cn/i/ct_css_positioning_floating_clear_div.gif)

一种方案：
使用空的div

``` css
.news {
  background-color: gray;
  border: solid 1px black;
  }

.news img {
  float: left;
  }

.news p {
  float: right;
  }

.clear {
  clear: both;
  }

<div class="news">
<img src="news-pic.jpg" />
<p>some text</p>
<div class="clear"></div>
</div>
```

另一种办法：

对容器div进行浮动
``` css
.news {
  background-color: gray;
  border: solid 1px black;
  float: left;
  }

.news img {
  float: left;
  }

.news p {
  float: right;
  }

<div class="news">
<img src="news-pic.jpg" />
<p>some text</p>
</div>
```

事实上，W3School 站点上的所有页面都采用了这种技术，如果您打开我们使用 CSS 文件，您会看到我们对页脚的 div 进行了清理，而页脚上面的三个 div 都向左浮动。


用一个空的占位。。

## CSS 元素选择器
```css
html {color:black;}
h1 {color:blue;}
h2 {color:silver;}

```

“类型选择器匹配文档语言元素类型的名称。类型选择器匹配文档树中该元素类型的每一个实例。”

## CSS 分组

``` css
h2, p {color:gray;}
两个不同的元素

```

## CSS 类选择器
结合元素选择器

``` css
p.important {color:red;}

```
只会匹配class守护星包含important的p元素


多个类选择器链接到一起

``` css
.important.urgent {background:silver;}

<p class="important urgent warning">
This paragraph is a very important and urgent warning.
</p>

```
不出所料，这个选择器将只匹配 class 属性中包含词 important 和 urgent 的 p 元素。因此，如果一个 p 元素的 class 属性中只有词 important 和 warning，将不能匹配。不过，它能匹配以下元素：

## CSS ID 选择器详解
``` css
#intro {font-weight:bold;}
<p id="intro">This is a paragraph of introduction.</p>
```


## ID vs Class ?????
区别 1：只能在文档中使用一次

与类不同，在一个 HTML 文档中，ID 选择器会使用一次，而且仅一次。
区别 2：不能使用 ID 词列表

不同于类选择器，ID 选择器不能结合使用，因为 ID 属性不允许有以空格分隔的词列表。
区别 3：ID 能包含更多含义

类似于类，可以独立于元素来选择 ID。有些情况下，您知道文档中会出现某个特定 ID 值，但是并不知道它会出现在哪个元素上，所以您想声明独立的 ID 选择器。例如，您可能知道在一个给定的文档中会有一个 ID 值为 mostImportant 的元素。您不知道这个最重要的东西是一个段落、一个短语、一个列表项还是一个小节标题。您只知道每个文档都会有这么一个最重要的内容，它可能在任何元素中，而且只能出现一个。在这种情况下，可以编写如下规则：


在这种情况下，可以编写如下规则：

#mostImportant {color:red; background:yellow;}

这个规则会与以下各个元素匹配（这些元素不能在同一个文档中同时出现，因为它们都有相同的 ID 值）：

<h1 id="mostImportant">This is important!</h1>
<em id="mostImportant">This is important!</em>
<ul id="mostImportant">This is important!</ul>

## 区分大小写

类选择器， ID选择器区分大小写

#intro {font-weight:bold;}

<p id="Intro">This is a paragraph of introduction.</p>

所以不会匹配上


。。。。。


# CSS 高级

## css 水平对齐
## 对齐块元素

块元素指的是占据去哪部可用宽度的元素，**并且在其前后都会换行**

``` css
h1, p , div etc..
```

## 使用margin 水平对齐

margin: auto

把左右外边距设置为auto， 规定均等的分配可用的外边距，

``` css
.center
{
margin-left:auto;
margin-right:auto;
width:70%;
background-color:#b0e0e6;
}
```

> 提示：如果宽度是 100%，则对齐没有效果。

## 使用position属性进行左右对齐

方法之一是使用绝对定位：

``` css
.right
{
position:absolute;
right:0px;
width:300px;
background-color:#b0e0e6;
}
```
> 绝对定位的元素会被从正常的流中删除，并且能够交叠元素


## 使用float， 进行左右对齐

``` css
.right
{
float:right;
width:300px;
background-color:#b0e0e6;
}

```
## 兼容问题 ？？


## CSS 尺寸， 这里继续看
http://www.w3school.com.cn/css/css_classification.asp
属性 	描述
height 	设置元素的高度。
line-height 	设置行高。
max-height 	设置元素的最大高度。
max-width 	设置元素的最大宽度。
min-height 	设置元素的最小高度。
min-width 	设置元素的最小宽度。
width 	设置元素的宽度。


## n-child 用法
https://themarklee.com/2013/09/29/repeating-patterns-nth-child/


## Mixin 知识点
https://www.w3cplus.com/preprocessor/sass-mixin-or-extend.html


## Box with Arrow
https://stackoverflow.com/questions/5623072/how-can-i-create-a-tooltip-tail-using-pure-css/5633146#5633146
http://www.cssarrowplease.com/

## Angularjs ng-repeat with columns in one row
https://stackoverflow.com/questions/27211799/angular-ng-repeat-add-bootstrap-row-every-3-or-4-cols


## Box without moving when changing border
by giving outline and border, toggle transparent each time

https://codepen.io/sifulislam/pen/KgXLmr

## height与line-height区别

在css中可以使用height与line-height来控制高度，其中height是指标签块的高度；而line-height是指元素的行高，line-height包括元素高度和空白的高度。

