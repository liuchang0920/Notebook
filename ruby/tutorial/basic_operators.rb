# 运算符应用 
# name = "ruby"
# if var 
#     name = var

# end

# # 等同于
# name = var || "Ruby"


# item = nil
# if arr
#     item = arr[0]
# end

# item = arr && ary[0]
# 跟js 一个尿性

var ||= 1
var = var || 1

# if
a = 1
b = 2
v = ( a > b) ? a:b

p Range.new(1, 10).to_a
p (1..10).to_a

p (5..10).to_a
p (5...10).to_a


# override 操作符
# 二元运算符
class Point

    attr_reader :x, :y

    def initialize(x=0,y=0)
        @x, @y = x, y
    end

    def inspect
        "(#{x}, #{y})"
    end

    def +(other)
        self.class.new(x - other.x, y-other.y)
    end
end


point0 = Point.new(3, 6)
point1 = Point.new(3, 6)
p point0 + point1


# 一元运算符。。略

# 下标方法
# obj[i] or obj[i] = x, 分别对应： [] []=

class Point

    def [](index)
        case index
        when 0
            x
        when 1
            y
        else
            raise ArgumentError, "out of range #{index}"
    end

    def []=(index, val)
        case index
        when 0
            self.x = val
        when 1
            self.y = val
        else
            raise ArgumentError, "out of range `#{index}'"
        end
    end
end


point = Point.new(4, 5)
p point[0] 
p point[1]