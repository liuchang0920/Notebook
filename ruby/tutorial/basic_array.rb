
# 介绍 Array类

# 使用迭代器可以逐个取出元素
# names.each{ |name| puts name }

a = Array.new

# 使用 %w %i, 创建不包含空白的字符串数组的时候，使用%w, 不要使用delimiter
lang = %w(a b c)
p lang

# 创建 symbol, 同样不要使用delimiter
lang = %i(a b c)
p lang

# to_a 方法，将其他对象转换为数组
color_table = {black: "#000000", white: "#FFFFFF"}
p color_table.to_a

# split, 默认找逗号或者 空格符
column = "2013/05/30 22:33 foo.html proxy.example.jp".split()
p column

# 使用索引，跟python一样，可以使用负数-1 最后一位数字
# [] 有以下三种用法
# 1. a[n]
# 2. a[n..m] or a[n...m]
# 3. a[n, len]

# 等价于：

# 1. at(n)
# 1. slice(n)
# 2. slice(n..m)
# 3. slice(n, len)

# 如何把数组作为集合使用。
# 交集： ary = ary1 & ary2
# 并集： ary = ary1 | ary2
num = [1, 2, 3]
even = [2, 4, 6]
p (num + even)
p (num | even)

# 数组作为队列或者栈， 怎么跟python
# push, shift 实现队列
# push pop 可以实现栈
alpha = [1, 2, 3, 4, 5]
p alpha.push(6)
p alpha.shift # 额这里方法可以省略括号，因为没有参数
p alpha

# first, last
p alpha.first
p alpha.last

# 数组方法

# unshift, 等价于java 的 insert
a = [1, 2, 3]
a.unshift(0)
p a

# push 等价于 << 
a = [1, 2, 3]
a << 4
p a

# a + b 等价于 concat()
a = []
a.concat([8, 9])
p a

# 数组中删除元素

# compact 删除所有的nil 元素 （nil 跟go一样。。）
a = [1, nil, 3, nil, nil]
p "new a:"
p a.compact
p a
a.compact!
p a

a = [1,2,3]
a.compact! # 如果没有nil，返回它本身，it only removes nil after all
p a

a.delete(2) # remove value "2"s from the array, 具有破坏性
p a

# 条件判断 delete_if reject! 方法都是具有破坏性的方法
a = [1,2,3,4,5]
a.reject!{ |i| 
    i>2
}
p a

# slice？？ 

# uniq 删除重复元素， uniq具有破坏性方法
a.uniq!
p a

# 替换数组的元素
# 将元素替换为别的元素的方法中，分为带！和不带!的方法
# collect, collect!, map, map!
a = [1,2,3,4,5]

a.collect { |item|
    item * 2
}
p a

a.collect! { |item|
    item * 2
}

p a 

# fill 用法
# a.fill(value)
# a.fill(value, begin)
# a.fill(value, begin, len)
# a.fill(value, n..m)

# flatten!
# reverse!
# sort!
# sort_by{ |i| -i }

# 数组与迭代器
a = 1...45
b = a.collect{ |i| i += 2 }
p b


# each 逐个获取元素
list = [1,2,3,4,5]
sum = 0
list.each do |elem|
    sum += elem
end

p "sum:", sum

list = ["a", "b", "c", "d"]
list.each_with_index do |elem, i| # 第二个参数是index
  print "第", i+1,"个元素是",elem,"。\n" 
end

# 具有破坏性的实现循环 不就是队列么》。。
while item = a.pop
    # 
end

# zip 函数。。。

# 迭代器还是不太会啊
