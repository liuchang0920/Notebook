
## 块是什么
## 在调用方式时，能与参数一起传递的多个处理的集合。
## 块的执行次数由方法本身决定，因此不需要事前指定，甚至有可能一次都不执行

[1, 2, 3, 4, 5].each do |i|
    puts i ** 2

end

# （用的还是第一种吧）
# 对象. 方法名( 参数列表) do | 块变量 |
#     　希望循环的处理
#     end
    
#     或者
# 对象. 方法名( 参数列表) { | 块变量 |
#     　希望循环的处理
# }

# 块的使用方法

## 循环
sum = 0
outcome = {"参加费"=>1000, "挂件费用"=>1000, "联欢会费用"=>4000}
outcome.each do |pair|
  sum += pair[1] # 指定值
end
puts "合计：#{sum}"


## 隐藏常规处理
# file。close 操作被 隐藏调用

# File.open("test.txt") do |file|

#     file.each_line do |line|

#         print line
#     end
# end

# # File.open方法使用块时，块内部的处理完毕并跳出方法前，文件会自动关闭

# 等价于:
# file = File.open("sample.txt")
# begin
#   file.each_line do |line|
#     print line
#   end
# ensure
#   file.close
# end

# 替换部分的算法
# 自定义排列的顺序
array = ["ruby", "Perl", "PHP", "Python"]
sorted = array.sort{ |a, b| a <=> b }
p sorted

# 块的最后一个表达式不是指块的最后一行表达式，而是指在块中最后执行的表达式。
# 这个例子有问题

ary = %w(Ruby is a open source programming language with a focus)

call_num = 0    # 块的调用次数
sorted = ary.sort do |a, b|
    call_num += 1 # 累加块的调用次数
    a.length <=> b.length
end

# 不能有奇怪的空格。。 所以缩进还不如python..
puts "排序结果 #{sorted}"
puts "数组的元素数量 #{ary.length}"
puts "调用块的次数 #{call_num}"

# 块封装成对象 why ? 真的蛋疼

# 局部变量，块变量

x = 1
y = 1
p x
ary = [1,2 ,3]

ary.each do |x1|
    y = x1
end

p [x, y]

