
# 父类：Numeric
# 子类： 
# Integer -> Fixnum, Bignum
# Float
# Rational
# complex

# fixnum 范围以外的数字，ruby会自动转换为bignum类型。
n = 2 ** 10
puts n.class

m = 2 ** 1000
puts m.class

# ruby也可以处理有理数，复数...
# 数值的字面量... 略

# Math 模块

# 计数
arr = []
10.times do |i|
    arr << i
end
p arr

