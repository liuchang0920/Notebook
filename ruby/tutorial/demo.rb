puts "hello world"

BEGIN {
    puts "init"
}

END {
    puts "end"
}

class Customer 
    # 类变量
    @@no_of_customers = 0

    # local variable
    VAR1 = 100

    def initialize(id, name, addr) 
        @cust_id = id
        @cust_name = name
        @cust_addr = addr
    end

    # member function, 
    # preferred lowercase letters
    def hello 
        puts "hello ruby"
    end

    # instance variables
    def display_details
        puts "cust id: #@cust_id"
        puts "cust name: #@cust_name"
        puts "addr: #@cust_addr"
    end

    # clas variable
    def total_no_of_cust
        @@no_of_customers += 1
        puts "total num: #@@no_of_customers"
    end

    def show 
        puts "local var1: #{VAR1}"
    end

end 

cust1 = Customer.new(1, "a", "b")
cust2 = Customer.new(2, "d", "e")

cust1.hello


$global_var = 10

class Class1 
    def print_global
        puts "c1 #$global_var"
    end
end

class Class2
    def print_global
        puts "c2 #$global_var"
    end
end

c1 = Class1.new
c2 = Class2.new


c1.print_global
c2.print_global

cust1.display_details
cust2.display_details

cust1.total_no_of_cust
cust2.total_no_of_cust

# 调用常量..
cust1.show

## array
arr = [1, 2, 3, "4"]
arr.each do |i|
    puts i
end


## hashes
colors = {
    "red" => 0xf00,
    "green" => 0x0f0,
    "blue" => 0x00f
}

colors.each do |key, value|
    print key, " is ", value, "\n"
end


# range
# .. 左右闭区间
# ... 左闭右开区间

(1..5).each do |i|
    puts i

end

puts
(1...5).each do |i|
    puts i

end

# 三元表达式 ?:

# defined? 
foo = 42
puts defined? bar # 不会报错
puts defined? foo
puts defined? $_

# . and :: operator
# :: allows a unary operator that allows: constants, instance methods, and class methods defined within a class or module

MR_COUNT = 0
module Foo
    MR_COUNT = 0
    ::MR_COUNT = 1 # set local to 1
    MR_COUNT = 2# set global... to 2 why?
end

puts MR_COUNT
puts Foo::MR_COUNT

# comments

=begin
 
multi comment..

=end

# if else statement
x = 1
if x > 2
    puts " x > 2"
elsif x <= 2 and x != 0
    puts "x = 1"
else 
    puts "no idea"
end

# unless
unless x >= 2
    puts "x < 2"
else
    puts "x >= 2"
end

age = 5
case age
when 0..2
    puts "baby"
when 3..5
    puts "little child"
when 6..20
    puts "big baby"
end

# loops
$i = 0
$num = 5

while $i < $num do
    puts "i = #$i"
    $i += 1
end

# until statement
$i = 0
until $i > $num do
    puts "i = #$i"
    $i += 1
end

for i in 0..5
    puts "var of local var: #{i}"
end

# break
for i in 0..5
    if i > 2 then
        break
    end
    puts "Value of local variable is #{i}"
end

# next
for i in 0..5
    if i < 2 then
        next
    end
    puts "Value of local variable is #{i}"
end

# retry ??
# for i in 0..5
#     retry if i > 2
#     puts "local var #{i}"
# end


## blocks 什么鬼

# Module
$LOAD_PATH << '.'
require  'trig'

y = Trig.sin(1)
puts y


# Mixin in ruby
# mixin give a wondeful controlled way of adding functinality to classes

# 相当于把别人的功能,直接拿过来用,当做自己的
# 待补充

# strings
x, y, z = 10 , 11, 13
puts "value of x: #{x}"
puts "x + y = #{ x + y}"

# builtin
myStr = String.new("THIS is TEST")
foo = myStr.downcase

puts "#{foo}"

# names = Array.new(10) { |e| e = e * 2}
# names = Array.new(10, "ojbk") 
names = Array[1, 2, 3, 4,5]

puts names.size
puts names.length
puts names  

# hashes
# months = Hash.new( "month1")

# puts "#{month[0]}"
# puts "#{month[72]}"

H = Hash[
    "a" => 100,
    "b" => 200
]

puts "#{H['a']}"
puts "#{H['b']}"

# or

month = Hash.new
month = {
    "1" => "jan",
    "2" => "feb"
}

puts month