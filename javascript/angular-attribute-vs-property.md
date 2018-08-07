
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







