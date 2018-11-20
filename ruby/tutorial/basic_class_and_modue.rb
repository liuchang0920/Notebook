
arr = Array.new
p arr
arr = []
str = 'hello'

p arr.class 
p str.class

p arr.instance_of?(Array)
p arr.instance_of?(String)

# 继承
p str.is_a?(String)
p str.is_a?(Object)
# is_a instance_of 都是object父类上的方法a

# clas creation
class HelloWorld

    def initialize(myname="Ruby")
        @name = myname
    end

    def hello
        puts "hellow, i am #{@name}"
    end

    # def name
    #     @name
    # end

    # # 这样可以从外部自由的访问对象内部的实例变量
    # def name=(value)
    #     @name = value
    # end
    attr_accessor :name
end

bob = HelloWorld.new("Bob")
ruby = HelloWorld.new

bob.hello

bob.name = "bob2"
bob.hello

# initialize 方法

# 存取器

# 更加便利的方法：
# attr_reader :name 只读
# attr_writer :name 只写
# attr_accessor :name 读写操作


# 特殊变量 self
# 引用方法的接收者

class HelloWorld2
    attr_accessor :name

    def greet
        puts "Hi, I am #{self.name}."
    end

    def test_name
        name = "ruby"
        self.name = "Ruby.." # 调用 name的set方法
    end
end

hw2 = HelloWorld2.new
hw2.test_name
puts hw2.name

# 类方法
# 类方法的操作对象不是实例，而是类本身


## 单利定义法？？？
# class << HelloWorld
#     def hello(name)
#       puts "#{name} said hello."
#     end
#   end
  
#   HelloWorld.hello("John")    #=> John said hello.

# 推荐写法
class HelloWorld3
    Version = "1.0"

    def self.hello(name)
        puts "#{name} said hello."
    end
end

puts HelloWorld3.hello("ass")

# class中定义常量
# 访问的形式是 :: 为什么.. 不make sense
p HelloWorld3::Version

# class 定义类变量

class HelloCount
    @@count = 0

    def HelloCount.count 
        @@count
    end

    def initialize(myname = "ruby")
        @name = myname
    end

    def hello 
        @@count += 1
        puts "hello, iam #{@name}"
    end
end

bob = HelloCount.new("Bob")
alice = HelloCount.new("Alice")
ruby = HelloCount.new

p HelloCount.count      #=> 0
bob.hello
alice.hello
ruby.hello
p HelloCount.count      #=> 3

# 限制方法的调用
# public 
# private 
# protected
class AccTest

    def pub
        puts "public method"
    end 

    # public :pub

    def priv
        puts "private"
    end

    private :priv
end

acc = AccTest.new
acc.pub
# acc.priv

# 推荐格式：

class AccTest2
    public

    def pub
        puts "public"
    end

    private 

    def priv
        puts "private"
    end
end

# protected, 在同一个类，或者子类中可以使用
class Point

    attr_accessor :x, :y

    protected :x=,:y= # set 方法设置成protected

    def initialize(x=0.0, y=0.0)
        @x, @y = x, y
    end

    def swap(other)
        tmp_x, tmp_y = @x, @y
        @x, @y = other.x, other.y
        other.x, other.y = tmp_x, tmp_y   # 在同一个类中
                                        # 可以被调用
        return self
    end
    
end

p0 = Point.new
p1 = Point.new(1.0, 2.0)
p [ p0.x, p0.y ]         #=> [0.0, 0.0]
p [ p1.x, p1.y ]         #=> [1.0, 2.0]

p0.swap(p1)
p [ p0.x, p0.y ]         #=> [1.0, 2.0]
p [ p1.x, p1.y ]         #=> [0.0, 0.0]

# p0.x = 10

# 扩展类

class String
    def count_word
      ary = self.split(/\s+/) # 用空格分割接收者
      return ary.size         # 返回分割后的数组的元素总数
    end
  end
  
  str = "Just Another Ruby Newbie"
  p str.count_word            #=> 4

  # 继承

  class RingArray < Array
    def [](i) # 重新定义运算符
        idx = i % size
        super(idx)
    end
  end

  wday = RingArray["日", "月", "火", "水", "木", "金", "土"]
  p wday[6]   #=> "土"
  p wday[11]  #=> "木"
  p wday[15]  #=> "月"
  p wday[-1]  #=> "土"

  ## alias and undef ???
  class C1
    def hello
        "hello"
    end
  end

  class C2 < C1
    alias old_hello hello

    def hello 
        "#{old_hello}, again"
    end
  end

  obj = C2.new
  p obj.old_hello
  p obj.hello

  # undef ???


# module
# 模块不能拥有实例
# 1. 提供命名空间
# 由于模块提供各自独立的命名空间，因此 A 模块中的 foo 方法与 B 模块中的 foo 方法，就会被程序认为是两个不同的方法。同样，A 模块中的 FOO 常量与 B 模块的 FOO 常量，也是两个不同的常量。

# 检查文件是否存在
p FileTest.exist?("/usr/bin/ruby")  #=> true
# 文件大小
p FileTest.size("/usr/bin/ruby")    #=> 1374684


## 利用mix-in 扩展功能
# mixin 就是把模块混合到类当中。使用include 语法。 模块里的方法，常量 都能够 使用
# 不支持多重集成
module MyModule


end

class MyClass1

    include MyModule
end

class MyClass2

    include MyModule
end

module HelloModul3
    Version = "1.0"

    def self.hello(name)
        puts "hello #{name}"
    end

    # or
    def hello2(name)
        puts "hello #{name}"
    end

    module_function :hello2
end

p HelloModul3::Version
HelloModul3.hello(:good)
HelloModul3.hello2("test..")


## Mix-in
module M
    def meth 
        "meth"   
    end
end

class C
    include M
end

c = C.new
puts c.meth
# C类包含模块M以后，M中的定义的方法，可以作为C类的实例方法，提供给程序调用
# 如果想知道类是否包含某个模块，使用 include? 方法

p C.include?(M)

# 实例在调用方法的时候，Ruby会通过C, M, C的父类Object的顺序类查找
# 虽然不是父类，但是却充当父类的作用

p C.ancestors
# [C, M, Object, Kernel, BasicObject]
# Kernel 是ruby内部的一个核心模块，ruby程序运行时所需要的共通函数，都封装在这个模块里面。

# 举例： enumerable 就是一个模块，在array, string, hash, io中都可以调用他的方法

# 查找方法的规则
# 1. 继承关系一样，原类中定义了同名的方法，优先使用该方法
module M
    def meth
        "M#meth"
    end
end

class C
    include M

    def meth
        "C#meth"
    end
end

c = C.new
p c.meth # override了
 
# 2.同一个类，包含多个模块的时候，使用最后包含的模块(怎么像js。。蛋疼玩意)
module M1
    
end

module M2 
end

class C 
    include M1
    include M2
end

p C.ancestors # [C, M2, M1, M, Object, Kernel, BasicObject]

# 3. 嵌套include的时候，查找顺序也是线性的。

module M1

  end
  
  module M2

  end
  
  module M3
    include M2        #=> 包含M2
  end
  
  class C
    include M1        #=> 包含M1
    include M3        #=> 包含M3
  end
  
  p C.ancestors       #=> [C, M3, M2, M1, Object, Kernel]

# 因为m3最后include，所以第一个祖先是它，然后是它的include, 然后再是C其他的include 

# 4. 相同的模块被包含两次以上时，第 2 次以后的会被省略。

module M11
  end
  
  module M21
  end
  
  class C1
    include M11       #=> 包含M1
    include M21        #=> 包含M2
    include M11       #=> 包含M1, 重复引用了，不考虑
  end
  
  p C1.ancestors       #=> [C, M2, M1, Object, Kernel, BasicObject]

# extend 方法
# extend 方法，可以使单利类包含模块，并且把模块的功能扩展到对象当中

module Edition
    def edition(n)
        "#{self} 第 #{n} 版本"
    end
end


str = "ruby tutorial"
str.extend(Edition)
p str.edition(4)

# 类与mixin

# class 的实例方法
module ClassMethods
    def cmethod
        "class method"
    end
end

module InstanceMethods
    def imethod 
        "instance method"
    end
end

class MyClass

    # 使用extend, 定义类方法
    extend ClassMethods
    #    include，定义实例方法
    include InstanceMethods

end

p MyClass.cmethod
p MyClass.new.imethod
# "class method"
# "instance method"
# 行吧， 区别一下extend, include

# 面向对象设计

# eg: f = 3.14, f.round
# 讲数据以及处理的操作方法，作为对象，合并在一起，贯穿整体，在面向对象的程序设计中是很常见的


# 面向对象程序设计会把，这种归类统一的数据，作为各种各样的对象来看待。
# 在对象中，数据以及处理数据的方法也是成套存在的，而且还负有处理数据的责任。


# 面向对象的特性

## 封装： 隐藏对象内部的数据结构，，以及具体的细节，内部的逻辑抽象的表达出来。
## 多态：同一个方法名，对于不同的类，得到的结果不一样； 虽然方法名一样，但调用的却是各个类专用的版本。

# 鸭子
def fetch_and_downcase(ary, index)
    if str = ary[index]
        return str.downcase
    end
end

ary = ["Boo", "Foo", "Woo"]
p fetch_and_downcase(ary, 1)  #=> "foo"

hash = {0 => "Boo", 1 => "Foo", 2 => "Woo"}
p fetch_and_downcase(hash, 1)  #=> "foo"

# 只要参数符合这两个要求，那么方法并不关心传入，进来的到底是数组还是散列

# eg

require "net/http"
require "uri"

url = URI.parse("http://www.ruby-lang.org/ja/")
http = Net::HTTP.start(url.host, url.port)
doc = http.get(url.path)

puts  doc.to_s

p url.scheme
p url.host
p url.port
p url.path
p url.to_s
