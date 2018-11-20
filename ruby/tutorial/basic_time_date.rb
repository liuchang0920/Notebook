
# 时间获取

p Time.new
p Time.now

t = Time.now
p t.year
p t.month
p t.day

# 时间计算
# t1 = Time.now
# sleep(10)
# t2 = Time.now
# p t2 - t1


# locale  时区
t = Time.now
t.utc
p t
t.localtime
p t


# str to date
require "time"
Time.parse("Sat Mar 30 03:54:15 UTC 2013")

# 日期的获取
require "date"
d = Date.today

p d.year
p d.month
p d.day
p d.wday # week of day
p d.mday # month of day
p d.yday # year of day

p "one month, before or after"
p d
p d >> 1 # 一个月的间隔
p d << 1

