

5.times do |i|
    puts "#{i}"
end

p 10.to_s
p Time.now.to_s

## 类方法

## 方法的标记法
# Array#each, Array#inject

# 类方法
# ClassName.method or ClassName::method

# define method
def hello(name="java")
    puts "Hello #{name}"
end

hello("ruby")
hello()

## 方法返回值
# 1. return 方法指定返回的内容
# 2. 省略return语句，方法的最后一个表达式的结果就会成为方法的返回值

def area(x, y, z)
    xy = x * y
    yz = y * z
    zx = z * x
  (xy + yz + zx) * 2
end

p area(2, 3, 34)

def max(a, b)

    if a > b
        a
    else
        b
    end
end

p max(10, 4)

## 定义带块的方法

def myloop
    while true
        yield
    end
end

num = 1
myloop do
    puts "num is #{num}"
    break if num > 100
    num *= 2
end

# 参数不确定： 有点像python 
def foo(*args)
    args
end

p foo(1,2 ,3)

def meth(arg, *args)
    [arg, args]
end

p meth(1)
p meth(1,2 ,3)

# 为什么要支持这种sb操作

def a(a, *b, c)
    [a, b, c]
end

p a(1, 23,3 ,4 ,5,6)
p a(1, 2)

# 关键字参数, 看着就很不清真
def area2(x: 0, y: 0, z: 0)
    xy = x * y
    yz = y * z
    zx = z * x
    (xy + yz + zx ) * 2
  end
  
p area2(x: 2, y: 3, z: 4)    #=> 52
p area2(z: 4, y: 3, x: 2)    #=> 52 （改变参数的顺序）
p area2(x: 2, z: 3)          #=> 12 （省略y）

# 接收未定义 的参数

def meth(x: 0, y: 0, z: 0, **args)
    [x, y, z, args]
end

p meth(z: 4, y: 34, x: 2)
p meth(x: 2, z: 3, v: 4, w: 5)

## 散列传递参数， 这个终于看着舒服一点
def area2(x: 0, y: 0, z: 0)
    xy = x * y
    yz = y * z
    zx = z * x
    (xy + yz + zx ) * 2
end

args1 = {x: 2, y: 3, z: 45}
p area2(args1)

args2 = {x: 2, z: 3}
p area2(args2)

