
# 正则表达式

# 写法和用法，
# 我们把正则表达式模式的对象，(Regexp类对象)称之为 正则表达式

# eg:
re = RegExp.new("Ruby")


# /../ 匹配普通字符
# /ABC/ "ABC" "▶ABC◀"
# /ABC/ "ABCDEF" "▶ABC◀DEF"
# /ABC/ "123ABC" "123▶ABC◀"
# /ABC/ "A1B2C3" （不匹配）
# /ABC/ "AB" （不匹配）
# /AB/ "abc" （不匹配）

# 匹配 行首 行尾
# meta character, 不代表本身的含义： ^ $ 
# ^ 表示行首，  $表示行尾

# /^ABC$/

# eg: “012\nABC”
# 012
# ABC
# 那么用 ^ 才能匹配的到

# \z \Z ??? 什么区别

# 指定 匹配字符的范围： []
# [ A-Za-z_] 全部英文字母 + _

# . 匹配至少一个字符
# /A.C/  => "ABC", "AC" 不匹配

# 使用反斜杠的模式 ...

# 好多东西，  留着有必要的时候学一下...
