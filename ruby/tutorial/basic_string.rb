# 字符串的连接： + << concat, split..

# \ 转义字符
# 使用 %Q %q
desc = %Q{Ruby 的字符串中也可以使用'' 和""。}
str = %q|Ruby said, 'Hello world!'|

# %Q 相当于用 "" 创建字符串，使用 %q 相当于使用 '' 创建字符串，不会转义

## Here document

# 有一些奇怪的想法
p '面向对象编程语言'.length #=> 8

p '面向对象编程语言'.bytesize #=> 24

# empty, 必须带问号 我了个草的 什么jb玩意
p "".empty?
p "foo".empty?

hello = "Hello, "
world = "World!"

str= hello + world
p str # 创建新的字符串

# 修改当前的字符串的时候，使用 << 或者 concat 方法
hello << world
p hello
hello.concat(world)
p hello
