### 一致性是什么
* 正确性条件
* 当数据存在副本同时被应用程序并发访问的时候，正确性非常重要
    - 如果一个应用程序进行写操作，那么之后的读操作可以观察到什么？ 如果这个操作来自其他应用程序呢？

* 弱一致性
    - read()可能返回不新鲜的数据 --不是最近写的操作结果

* 强一致性
    - read()返回的结果数据是最近一次的写操作结果

* 一般的权衡
    - 强一致性对程序的写操作 表现不错
    - 强一致性会影响性能
* 耕作的正确性条件(一致性模型)

### 一致性模型的历史

* 在架构中，系统和数据库社区存在独立发展
    - 带私有缓存的并行处理器访问共享内存
    - 并行客户端访问分布式文件系统
    - 分布式数据库之上的并行事物

* 不同的模型考虑不同的权衡
    - 可串行行(serializability)
    - 顺序一致性(sequential consistency)
    - 线性一致性(linearizability)
    - 单项一致性(entry consistency)
    - 松散一致性(release consistency)

### 理想的一致性模型
* 一个存在副本的文件表单的跟单一文件系统一样，就像很多客户端访问存在同一个机器的单一磁盘的文件
* 如果一个程序的写操作，之后的读操作会获得这个写的结果
* 如果两个程序同时写一个文件会怎么样？
    - 在文件系统中这种行文经常是未定义的 -- 文件也许会混个两个写操作的内容
* 如果两个应用程序并发写同一个目录会怎么样？
    - 一个一个顺序执行


### 不一致的来源
* 并发
* 机器失败
* 网络割裂

### 来自GFS的论文例子
* 主节点是备份分区b, 客户端添加1， 主节点将1发送给自己和分区备份A，告诉客户端失败，同事客户端访问分区B， 可能获得老的数据

### 为什么理想中的一致性模型在分布式文件系统中实现这么困难？
* 理想的一致性模型协议非常复杂 --后面会看到非常难实现的正确的系统
* 协议需要客户端和服务器进行通信，这样会小号性能

**GFS设计者为了追求更好的性能，和简单的设计而放弃理想的一致性模型**

* 能否使得应用程序开发人员的生活困难
    - 在一个理想的系统中，应用程序的行为不容易被观察到
    - 如：获得过期的数据
    - 如： 添加重复的记录
    - 应用数据不是银行账号，所以可能不存在问题

* 今天的论文 展现下面因素权衡的一个例子
    - 一致性
    - 容错性
    - 性能
    - 简单的设计

* GFS目标
    - 创建共享的文件系统
    - (管理)成千上万的物理机器
    - 存储大量的数据集

GFS存储什么
    - 可能有： 
    - 搜索索引， 数据库
    - web上的html
    - 图片文件

### 文件属性
* TB级别的数据集
* 很多大文件
* 文件只支持追加的方式

### 主要挑战
* 机器很多，所以出现的情况很常见， 假设一台机器一年出一次错误，平均每天又三台
* 高性能： 很多并发的读写操作，Map/Reduce工作会从GFS读取数据，然后保存最后的结果
* 高效的使用网络

### 高层次的设计
* 定义目录，文件，明明，打开、读、写操作，但是不符合posix标准
* 成百上千带有硬盘的linux块服务器
    - 存储64Mb的块
    - 每个块在三台服务器上备份
    - Q： 为什么是三份
    - Q： 除了数据可用，这个方案给我们带来了什么？ 负载均衡热文件的读取
    - Q：为什么不把每一份文件存储在RAID硬盘： RAID不是常用品，我们想给整台机器做容错，而不是仅仅针对存储系统
    - Q: 为什么chunk那么大

* GFS的主控服务器知道目录层次
    - 对于目录而言，知道里面有哪些文件
    - 对于文件而言，知道哪些数据块服务器存储了相关的64mb大小的数据块
    - 主控服务器在内存中保存状态信息，每个chunk在主控服务器上面保存64byte的元数据
    - 主控服务器为元数据准备的可回收数据库，可以从断电故障后快速恢复
    - 同事存在备份的主控服务器(shadow master)，数据略微比主控服务器延迟，可以被提升为主控服务器

### 基本操作
* 客户端读操作：
    - 向主控服务器发送文件名和偏移量
    - 主控服务器回复带有相关chunk的数据块服务器的集合，客户端临时缓存这些信息，然后访问最近的数据块服务器
* 客服端写操作：
    - 询问主控服务器，我应该往哪里写
    - 如果文件大小超过64mb， 主控服务器也许会选择一些新的数据块服务器

### 两种不同的容错计划
* 为了主控服务器设计
* 为了数据块服务器设计

### 主控服务器容错
* 单台主控服务器
    - 客户端都是跟主控服务器交互
    - 主控服务器整理全部的操作

* 长期存储有限的信息
    - 命名空间(目录)
    - 文件到chunk的映射

* 操作日志会改变他们
    - 操作日志存在多个备份
    - 客户端进行修改操作，状态在修改记录到操作日志之后才能返回？
    - 我们可以看到操作日志在多数系统中都发挥核心作用
    
* 限制操作日志的文件大小
    - 为主控制服务器的状态创建检查点
    - 删除操作日志中检查点之前的全部操作
    - 检查点复制备份

* 恢复
    - 操作日志从最新的检查点进行恢复
    - chunk的位置信息则通过询问数据块服务器获取

* 主控服务器的单点故障
    - 恢复很快，因为主控服务器的状态文件很小，也许会有很小的时间不可用
    - 影子服务器，他数据落后与主控服务器，他们用log中备份的数据进行恢复。服务器只执行符操作，返回的数据也许不是最新的
    - 如果主控服务器不能恢复，然后主控服务器有重新启动，系统必须避免出现两台主控服务器的出现

### 数据块服务器容错
* 主控服务器授予一个备份服务器契约，这个备份成为主控服务器，将确定的操作顺序
* 客户端将数据发给副本
    - 热捧理财师 form a chain
    - chain respects network topology
    - allows fast replication
    - 没懂。。

* 客户端发生写请求给主chunk服务器
    - 主chunk服务器分配序列号
    - 主chunk服务器在本地应用修改
    - 主chunk服务器向副本发送修改数据的请求
    -主chunk服务器接收到全部副本的ack消息后，回复给客户端

* 如果一个副本没有回复，那么客户端会重试
* 如果副本的数量少于某个值， master服务器会备份chunks， 重新负载备份

### chunk数据的持久化
* 有些数据因为错过了更新，所以过时了
* 通过chunk的版本号，判断数据是否是不新鲜的，在发生租约前， 增加chunk版本的号码，将数据发送到主数据块服务器，同事在其他数据块服务器中备份，主服务器和数据块服务器长久的存储版本信息
* 发送版本号给客户端
* 版本号帮助主控制服务器和客户端判断备份是否不新鲜

### 并发的写、追加
* 客户端们也许会并发的同事，写文件到同一个区域
* 结果是这些写操作的混合-- mo guarantees few applcations do this anyway, so it is fine
    - 在unix系统上面的并发写也会导致奇怪的输出
* 很多客户端也许想并发的往一个长文件里边添加
    - GFS支持院子操作，保证至少一次添加，主chunk服务器选择记录需要添加到的文件位置， 然后发送给其他副本。如果和一个副本的联系失败，那么主chunk服务器会告诉客户端重试。如果重试成功，有些副本会出现追加两次的情况(因为这个副本追加成功两次)。当GFS要去填塞chunk的边缘是，如果追加操作跨越chunk的边缘，那么文件也可能存在空洞？？

### 一致性模型
* 目录操作的强一致性
    - master 服务器院子的修改元数据，目录操作发生在理想的情况
    - 如果master服务器下线，只剩下备份的服务器，这时只允许只读操作，同时返回的数据可能不新鲜？？

* chunk操作的弱一致性
    - 一个失败的突变使得chunk变得不一致
        * 主chunk服务器更新chunk文件，但是同步给副本时失败，这时副本的数据过时了，
    - 客户端督导的数据不是最新的，当刷新获取新的租约的时候，客户端会获得新的版本

* 作者主张弱一致性对app而言不是什么大问题
    - 大多数文件更新操作只是追加
        * 应用程序可以使用添加记录中的uid判断是否重复
        * 应用程序也许只是读取到少量的数据
    - 应用程序可以使用临时文件和院子的重命名操作

### 性能（没看懂）
* 巨大的读操作总吞吐量
    - 125 Mb/s
    - 接近网络饱和状态

* 写入不同的文件低于可能的最大值
    - 作者怪网络堆栈？
    - chunk直接的复制操作会引起延迟

* 并发追加同一份文件
    - 被服务器存在的chunk所限制


### 总结
* GFS使用的重要容错技术
    - 操作日志，检查点
    - chunk之间的主备备份（primary=backup）
    
* GFS工作很好
    - 巨大的顺序读写操作
    - 追加
    - 巨大的吞吐量
    - 数据之间的容错

* 哪些GFS做的不好
    - master服务器的容错
    - 小文件(master服务器的瓶颈)
    - 多个客户端并发向同一个文件更新操作 ？？？