
https://angular.cn/guide/template-syntax

## HTML attribute 与 DOM property 的对比

要想理解 Angular 绑定如何工作，重点是搞清 HTML attribute 和 DOM property 之间的区别。

attribute 是由 HTML 定义的。property 是由 DOM (Document Object Model) 定义的。

* 少量 HTML attribute 和 property 之间有着 1:1 的映射，如 id。

* 有些 HTML attribute 没有对应的 property，如 colspan。

* 有些 DOM property 没有对应的 attribute，如 textContent。

* 大量 HTML attribute 看起来映射到了 property…… 但却不像你想的那样！


最后一类尤其让人困惑…… 除非你能理解这个普遍原则：

attribute 初始化 DOM property，然后它们的任务就完成了。property 的值可以改变；attribute 的值不能改变。

例如，当浏览器渲染 <input type="text" value="Bob"> 时，它将创建相应 DOM 节点， 它的 value 这个 property 被初始化为 “Bob”。

当用户在输入框中输入 “Sally” 时，DOM 元素的 value 这个 property 变成了 “Sally”。 但是该 HTML 的 value 这个 attribute 保持不变。如果你读取 input 元素的 attribute，就会发现确实没变： input.getAttribute('value') // 返回 "Bob"。

HTML 的 value 这个 attribute 指定了初始值；DOM 的 value 这个 property 是当前值。

disabled 这个 attribute 是另一种特例。按钮的 disabled 这个 property 是 false，因为默认情况下按钮是可用的。 当你添加 disabled 这个 attribute 时，只要它出现了按钮的 disabled 这个 property 就初始化为 true，于是按钮就被禁用了。

添加或删除 disabled 这个 attribute 会禁用或启用这个按钮。但 attribute 的值无关紧要，这就是你为什么没法通过 <button disabled="false">仍被禁用</button> 这种写法来启用按钮。

设置按钮的 disabled 这个 property（如，通过 Angular 绑定）可以禁用或启用这个按钮。 这就是 property 的价值。

**就算名字相同，HTML attribute 和 DOM property 也不是同一样东西.**

> 再强调一次： 模板的绑定，是通过property和事件来工作的，而不是attribute。 ？？

> 没有attribute的世界：
在angualr中，attribute的唯一的作用是初始化元素和指令的状态。 当数据绑定时，只是在与元素和指令的proper有和事件打交道，  attribute完全靠边了。


## 绑定目标

eg： <img [src]="heroImageUrl">

目标的名字总是property的名字。看到src的时候可能会当做attribute， 但是它不是，他是image的propery的名字
eg: <div [ngClass]="classes">[ngClass] binding to the classes property</div>

> 严格来说，angular正在匹配指令的输入属性的名字。这个名字指令inputs数组中所列的名字，或者带有@Input()装饰的属性。 这些输入属性被映射为指令自己的属性。


> 别忘了方括号，返回恰当的类型，消除副作用

### 属性绑定还是插值表达式？


在多数情况下，插值表达式是更方便的备选项。 实际上，在渲染视图之前，Angular 把这些插值表达式翻译成相应的属性绑定。

当要渲染的数据类型是字符串时，没有技术上的理由证明哪种形式更好。 你倾向于可读性，所以倾向于插值表达式。 建议建立代码风格规则，选择一种形式， 这样，既遵循了规则，又能让手头的任务做起来更自然。
> 但数据类型不是字符串时，就必须使用属性绑定了。  (propety)

所以尽量使用属性绑定？？


## Attribute, class, style  绑定

eg: 下面这种情况会报错：

<tr><td colspan="{{1 + 1}}">Three-Four</td></tr>

```md
Template parse errors:
Can't bind to 'colspan' since it isn't a known native property
```
td元素没有colspan属性，但是差值表达式和属性绑定，只能设置 属性（property），不能设置attribute


Attribute 绑定的语法与属性和绑定类似。但是方括号中的部分不是元素的属性名，而是由attr. + attribute名字的组合。

eg: [attr.colspan] 

```CSS
<table border=1>
  <!--  expression calculates colspan=2 -->
  <tr><td [attr.colspan]="1 + 1">One-Two</td></tr>

  <!-- ERROR: There is no `colspan` property to set!
    <tr><td colspan="{{1 + 1}}">Three-Four</td></tr>
  -->

  <tr><td>Five</td><td>Six</td></tr>
</table>

```

CSS类绑定

eg:

```HTML
<!-- standard class attribute setting  -->
<div class="bad curly special">Bad curly special</div>
如果想修改属性：

   <!-- reset/override all class names with a binding  -->
<div class="bad curly special"
     [class]="badCurly">Bad curly</div>

但是这是一个或者全有或者全无的替换型绑定。
当badCurly有值时，class这个attribute设置的内容会被完全覆盖。

```

类名的绑定：
```html
<!-- toggle the "special" class on/off with a property -->
<div [class.special]="isSpecial">The class binding is special</div>

<!-- binding to `class.special` trumps the class attribute -->
<div class="special"
     [class.special]="!isSpecial">This one is not so special</div>

```



