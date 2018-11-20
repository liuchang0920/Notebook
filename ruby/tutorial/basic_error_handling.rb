
# error handling
# use syntax: begin, rescue, end

# $! 异常对象， $@ 异常的位置信息
# 异常对象的方法: class, message, backtrace

ltotal =0
wtotal = 0
ctotal =0

ARGV.each do |file|
    begin
        input = File.open(file)
        l =0
        w=0
        c=0

        input.each_line do |line|

            l += 1
            c += line.size
            line.sub!(/^\s+/, "")          # 删除行首的空白符
            ary = line.split(/\s+/)        # 用空白符分解
            w += ary.size

        end
        input.close
        printf("%8d %8d %8d %s\n", l, w, c, file)  # 整理输出格式
        ltotal += l
        wtotal += w
        ctotal += c

    rescue => exception
        # print ex.message, "\n"           # 输出异常信息（B）
        p "ojbk"
    end
end

# ensure: 后处理，不管是否发生异常都需要执行的处理。
def copy(from, to)
    src = File.open(from)         # 打开原文件from（A）
    begin
      dst = File.open(to, "w")    # 打开目标文件to（B）
      data = src.read
      dst.write(data)
      dst.close
    ensure
      src.close                   # （C）
    end
end

# 重试 ？？

file = ARGV[0]
begin
  io = File.open(file)
rescue
  sleep 10
  retry
end

data = io.read
io.close

# 异常处理 补充： 如果整个方法体都用begin, end包含的话，那么可以省略begin 以及end

# def foo
# 　方法体
# rescue => ex
# 　异常处理
# ensure
# 　后处理
# end


# begin
# 　可能发生异常的处理
# rescue Exception1, Exception2 => 变量
# 　对Exception1 或者Exception2 的处理
# rescue Exception3 => 变量
# 　对Exception3 的处理
# rescue
# 　对上述异常以外的异常的处理
# end

# 异常类
MyError = Class.new(StandardError)    # 新的异常类
MyError1 = Class.new(MyError)
MyError2 = Class.new(MyError)
MyError3 = Class.new(MyError)
# 应该跟java一样，如果具体类 被 更加general的rescue先捕获到了，后面就无法再被catch到了

# 主动抛出异常 raise
使用raise方法，可以使程序主动抛出异常。在基于自己判定的条件抛出异常，或者把刚捕捉到的异常，再次抛出并且通知异常的调用者等情况下，我们会使用raise方法

``` ruby

raise message
raise 异常类

```

