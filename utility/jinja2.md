

https://zhuanlan.zhihu.com/p/23669244
https://blog.csdn.net/wjs7740/article/details/73910970
http://www.bjhee.com/jinja2-block-macro.html


一些语法

### Delimiters

```html

{% .. %}  语句

{{ .. }} 跟angular一样的

{# #} 注释

# .. ## 行语句

eg: 
{# note: commented-out template because we no longer use this
    {% for user in users %}
        ...
    {% endfor %}
#}


```


### Variable

```html

{{ mydict['key'] }}
{{ mylist[3]}}
{{ myobj.somemethod }}

获取一个变量的属性有两种方式：

{{ foo.bar }}
{{ foo['bar'] }}

```

### 过滤器

```html
{{ items| join(', ') }}

{{ my_variable|default('my_variable is not defined') }}

```

常用的内置过滤器

sage: render 不转义
capitalize:首字母大写
lower: 
upper:
title: __每一个__单词首字母都大写
trim: 去掉首尾空格
striptags: 去掉值里面的html标签
default: 如果变量没有定义，使用默认值
random(seq) 返回一个序列里的随机元素
truncate(s, length=255, killwords=False, end='...') 截取出指定长度的文章（文章摘要
format(value, *args, **kwargs) 参考Python的字符串格式化函数
length 左边如果是列表，输出列表的数量；如果是字符串，则输出字符串的长度


## Tests 判断，测试
（略过）

## Loop 循环
（略过）

loop.index 当前迭代数，可以用来写评论的楼层数（从1开始）
loop.index0 同上，不过从0开始迭代
loop.revindex 反向的迭代数（基数为1）
loop.revindex0 反向的迭代数（基数为0）
loop.length 序列的数量
loop.first 是否是第一个元素
loop.last 是否是最后一个元素


## Whitespace control 空格控制

```html
<div>
  {% if True %}
    yay
  {% endif %}
</div>

会生成

<div>

        yay

</div>

jinja2语句占用的空行，输出的空格，tab  都会被保留

```


```html
使用减号

<div>
  {% if True -%}
    yay
  {%- endif %}
  
  两者效果相同：
  
  <div>
        yay
  </div>
```

如果前后都添加减号：
``` html
<div>
    {%- if True -%}
        yay
    {%- endif -%}
</div>

会变成这样：

<div>yay</div>


```

## 转义
略

raw 输出一些原始不被翻译的内容： 
```html
{% raw %}
    <ul>
    {% for item in seq %}
        <li>{{ item }}</li>
    {% endfor %}
    </ul>
{% endraw %}

```

## 模板继承
制作一个base html

```html
{% block content %}
  
{% endblock %}

（里面内容是空的）
```

在其他模板里extends继承它，并放置对应的内容到base模板里定义过的empty block

```html

{% extends "base.html" %}
{% block content %}
  子模板的内容
{% endblock %}


如果想添加内容在父模板的已经定义好的块：使用super函数

{% block sidebar %}
  <h3> table of contents </h3>
  ...
  
  {{ super() }}
  {# 父模板内容 #}
{% endblock %}


```

## 全局函数
略

## Macro 宏

```html
  
  {% macro input(name, type='text' value='') -%}
    <input type="{{type}}" name="{{ name }}" value="{{ value}}" />
  {% endmacro %}
  
  
  
  调用：
  
  <p>{{ input('username', value='user') }}</p>
  
  <p>{{ input('password', value='password') }}</p>
  
  <p>{{ input('submit', 'submit', 'Submit!') }}</p>
```

## 访问调用者内容：

```html

{% macro list_users(users) -%}
  <table>
    <tr><th>Name</th><th>Action</th></tr>
    {%- for user in users %}
      <tr><td>{{ user.name |e }}</td>{{ caller() }}</tr>
    {%- endfor %}
  </table>
{%- endmacro %}

调用者的代码：

{% set users=[{'name':'Tom','gender':'M','age':20},
              {'name':'John','gender':'M','age':18},
              {'name':'Mary','gender':'F','age':24}]
%}
 
{% call list_users(users) %}
    <td><input name="delete" type="button" value="Delete"></td>
{% endcall %}

这里我们使用了”{% call %}”语句块来调用宏

{{ caller() }} 部分被调用者 {{% call %}} 语句块的内容代替了

```

进一步 caller 传参》。。
```html
{% macro list_users(users) -%}
  <table>
    <tr><th>Name</th><th>Gender</th><th>Action</th></tr>
    {%- for user in users %}
      <tr><td>{{ user.name |e }}</td>{{ caller(user.gender) }}</tr>
    {%- endfor %}
  </table>
{%- endmacro %}


{% call(gender) list_users(users) %}
    <td>
    {% if gender == 'M' %}
    <img src="{{ url_for('static', filename='img/male.png') }}" width="20px">
    {% else %}
    <img src="{{ url_for('static', filename='img/female.png') }}" width="20px">
    {% endif %}
    </td>
    <td><input name="delete" type="button" value="Delete"></td>
{% endcall %}


```

还有些其他的，慢慢再了解。。



### 宏的导入
类似python里的import

```html
{% import ‘form.html’ as form %}
<p>{{ form.input('username', value='user') }}</p>
<p>{{ form.input('password', 'password') }}</p>
<p>{{ form.input('submit', 'submit', 'Submit') }}</p>

另一种导入方式：

{% from 'form.html' import input %}
<p> {{ input('usrename', value='user' )}}</p>
```

#### Include
与import不一样，include会把目标模板渲染出来。 同block块的集成也不一样，它一次渲染整个模板文件，不分块。

eg: 

```html
<body>
  ...
  {% include 'footer.html' %}
</body>


include 不报错：
    {% include 'footer.html' ignore missing %}


include multiple: 
    {% include ['footer.html','bottom.html','end.html'] ignore missing %}


```




## 其他内容..

诶 感觉python的说明文档怎么就比ruby的好太多

