# 使用{}

h1 = {"a"=>"b", "c"=>"d"}

# hash.new
h1 = Hash.new
p h1["test"]

h2 = Hash.new("default")
p h2["test"]

# 推荐作为散列的key:
# String, Numeric, Symbol, Date

h = Hash.new
h["R"] = "Ruby"
p h["R"]    #=> "Ruby"

h = Hash.new
h.store("R", "Ruby")
p h.fetch("R")    #=> "Ruby"
h = Hash.new
h.store("R", "Ruby")
p h.fetch("R", "(undef)")    #=> "Ruby"
p h.fetch("N", "(undef)")    #=> "(undef)"

# 一次性获取所有的键值对
# 返回数组
h = {
    "a" => "b",
    "c" => "d"
}

p h.keys
p h.values
p h.to_a

# 指定默认值
# h = Hash.new do |hash, key|
#     hash[key] = key.upcase
# end

p h["a"]
p h["b"]

# 查看是否为散列对象或者值
# 4 个方法都是一样的。。蛋疼
p h.key?("a")
p h.has_key?("a")
p h.include?("a")
p h.member?("a")

# 查看散列的值中是否存在指定对象的方法。这两个方法只是把 key?、has_key? 方法中代表键的 key 部分换成了值 value，用法是完全一样的。
# h.value?(value)
# h.has_value?(value)

# 散列大小
p h.size
p h.length

# 删除键值
h.delete("a")
h.delete("noidea..")

p h["a"]
p h["noidea.."]

# 删除默认操作
# h = {"R"=>"Ruby"}
# p h.delete("P"){|key| "no #{key}."}    #=> "no P."

# h.delete_if{|key, val|...}
# h.reject!{|key, val|...}

# clear hash
h.clear
p h.size

# 散列中的散列
