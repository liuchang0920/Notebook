

http://www.ruanyifeng.com/blog/2016/07/yaml.html


http://nodeca.github.io/js-yaml/


source:

``` yaml
animal: pets

hash: { 
	name: ok, 
	foo: falue 
}

ojbk:
- cat
- dog 
- fish
-
 - 1
 - 2
 - 3 

animals: [Cat, Dog]


# 复合结构

languages:

- Ruby
- perl
- python

websites:
  YAML: yaml.org
  Ruby: ruby.org
  Python: python.org
  Perl: perl.org

# 纯量
# 字符串，布尔值，整数，浮点数，null，时间，日期
number: 12.3

isSet: true


# null, 最好不用缺省形式，容易误会
parent: ~

iso8601: 2001-12-14t21:59:43.10-05:00 

#  月份十位数如果不为1，需要用0补齐，用减号-连在一起
date: 2018-06-12

# 强制转换数据类型

e: !!str 123
f: !!str true

# 字符串，最复杂的数据类型

strWithSpace: asdf asdf @

# 转义, 双引号不会对特殊字符转义
s1: 'line break \n'
s2: "line break \n"

## 连续两个单引号，转义成一个单引号

s3: 'labor''s day'

# 字符串可以多行，从第二行开始，必须要有空格缩进，换行会转换成控股个

s4: asdf
 asdf
  asdf
  asdf 
  
# | 保留换行， > 折叠换行

this: |
 foo
 bar

that: > 
 foo 
 bar

# + 表示文字块末尾换行， -表示删除字符串末尾的换行

s6: |+
 foo
 
s7: |-
 bar
 
# 插入html标记
message: |

  <p style="color: red">
    段落
  </p>

# 引用
# & 锚点， * 别名

defaults: &defaults
 adapter: p
 host: local

developtment:
 database: my_dev
 # 直接引用锚点处的内容过来
 <<: *defaults

test:
 database: my_test
 <<: *defaults
 
# &用来建立锚点，<< 合并到当前的数据， * 引用锚点
arr:
 - &showwell steve
 - brain
 - *showwell


# 函数和正则表达式的转换 ??  有病




```
