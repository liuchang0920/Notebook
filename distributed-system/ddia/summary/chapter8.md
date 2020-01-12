# trouble wich distributed systems

分布式系统存在的问题

The reality is even darker. We will now turn on our pssimism to the maximium and assume that anything that can go wrong will go wrong. if you ask nicely, they might tewll you some frightening sotries while nuring their scars of past  battles.

working with distributed systems is fundamentally different from writing software on a single computer -- and the main difference is that there are lots of new and exciting ways for things to go wrong. 

This chapter we will get a taste of the proglems that arise in **practice**, and an understanding of the things we can and cannot rely on.

in the end, our task as engineer is to build systems that do their job, in spie of everyhting oging wrong. 

This chapter is a thoroughly pessimistic and depressing overview of things that may go wrong in a distributed system. (ok, that's probably even way better than my life, so what)

* network
* clock and timing issue


## faults and partial failures


this is a deliberate choice in the design of compouters: if an iternal fault occurs, we perfer a compouter to crash completed rahter than returning a wrong result, because physical reality on which they are implemneted and present an idealized system model that operate with mathematical perfection. 

In distributed sytem, we are on loner operating in a idealized system mdoel -- we have no choice but to confront the messy reality of the physical world. and in the physical world, a remarkably wide range of things can go wrong, as illustracted by this anecdote..... "..."



Partial faliure: parts of the system are broken in some unpredictable way, even though other parts of the ssytem are working fine. 

The difficulty is that partial failures are non-deterministic



## Cloud computing and super computing

a super compouter is more like a single-node computer than a distributed system. it deals with partial faliure by lettign it escalate into total failure -- if any part of the system faile, just let everything crash



## unrealiable networks

Network is the only way those mahcines can communicate -- we assume that eachmachien has its own memory and disk, and one machine cannot accesss another machin'e memory or disk (except by making request to a service over the network)

"shared-nothing" is not the only way of building system, but it has become the dominatnt approach for building internet srevice, for serveral reasons: it's comparatiely cheap, because it requries no sepecial hardware, it can make use of commoditized cloud computing services, and it can achieve high reliability through redundancy across mulitple geographically distributed datacenters.

...


Usual way of handling this issue is a "timeout", after some time, you give up waiting and assume that the response is not going to arrive. However, when a timeout occurs, you still don't knwo whether the remote node got your request or not 




## network faults in practice


> Network partitions: when one part of the network is cut off from from the rest dueto a network fault, that is sometimes called a network partition or netsplit, in this book, we will generally stick with the more general term network fault, to avoid confusion with partitions of a storeage system,



## Detecting faults

这一段都讲了啥...


## timeouts and unbounded delays


how long a timeout should be? there's no simple answer



and Asynchronous networks have unbounded delays, that is they try to deliver packages as quickly as possible, but there's no upper limit on the time it amy take for a package to arrive, and most server implementations cannot guarantee that they can ahndle requriest within some maximum time 

### Network congestion and queuing


* lots of package send to same destination, then netowkr switch will queue them up
* if the destiantion CPU is currently busy, then incoming request from the network will be queued by by the OS
* virtualized enviornments, a running oS oftern puased for tens of ms for other virtual machine to run.
* TCP performs "flow control", such that additional queueing at the sender even before the data enters the network.
    * also, TCP consider a package loss and retrasmitted, though the app doesnt see the pckage loss and retransmit, it does see the resulting delay!

## Synchrnous CS asynchronous networks


Distributed systems would be a lot simpler if we could reply on the network to deliver packages with some fixed manximum delya, and not to drop packets.



比较


A circuit is good for an audio, or video call, which needs to transfer a faily constant traffic, 

On the other hand, requesting a web page, sending an email, or transfering a file doesnt have any particular bandwidth requirments -- we just want it to complete as quickly as possible.



## Unreliable clocks (不可靠的时钟)

apps depend on clocks in various ways

* request timeout?
* what is 99th percentile response
* how many queries persecond did this service handle on average in thelast five minutes
* how log did the user spend on our site?
* when was this article published?
* when does this cache expire?

看不动了,做题做题

继续继续

### Time of day clocks ?

time of dat clocks are usually syhncrhonized with NTP, which means that the timestamp from one machine menas the same as a timesatmp on another machine.



if particular, if the local lock is too far ahead of the NTP server ,it may be forcibley reset and apprear to jump back to a previous point in time. These jumps, as well as the fact that they often ignore leap seconds, make time of day clocks unsuitable for measuring elapsed time. 






### Monotonic clocks ?



which is suitable for measuring a duration (time interval), such as a timeout or a service' response teim  

eg: System.nanoTime() in Java are monotonic clocks.




However, the "absolute value" of the clock is meaningless: it might be the number of nanosendos since the computer was started, or something archibutrary, In particular, it makes no sense to compare monotonic clock values from two different computers, because they don't mean the same thing.




## Clock synchronization and accuracy  (时钟同步,以及准确性)

...


some accuracy can be achieved using GPS receiveer, and the Precision Time prtocol (PTP) can careaful deployment and monitoring. however, it rquires significant effort and expertise


## Relying on synchronized clocks (依赖同步时钟)


The problem with clocks is that while they seem simple and easy to use, they havea surprising number of pitfalls: a day may not have exactly 86400 seconds, tuime of day clokcs may move backward in time, and the time on one node may be quite different from the time on another node. 


Although clocks may work quite well most of the time, robust software needs to be prepared to deal with incorrect clocks.


### timestamps for ordering events (根据时间戳)


eg: 2 clients write to a distributed database, who got there first? which writeis the more recent one?


因为每台node的teimstap 不一致,导致看到的数据timestamp顺序有问题.


This conflict resolution strategy is called "last write wins(LWW)", and it is widely used in both multi-leader replication and leaderless database such as "Cassandra" etc..  

....
Thus, even though it is tempting to resolve conflicts by keeping the most "recent" values and discarding others, its important to be aware that the definition of "recent" depends on a local time-of-day clock, which may well in incorrect. Even with tightly NTPsynchronized clocks, you could send a packet at timesmape 100ms (in the sender's clock), and then have it arrive at timestamp 99ms (at the recipient's clock) -- so it appears as though the packet arrived before it was sent, which is impossible.





so-called "logical clocks" (逻辑时钟), which are based on incrementing counters rather than an oscillating quartz crystal, are a safer alternative for ordering events. 

Logical clocks do not measure the timeo fday or the number of seconds elapsed, only the relative ordering of events. In constrast, time-of-day and monotonic clocks, which measure actual elapsed tim,e are also known as "physical clocks."

### clock readings havea confidence internval (置信区间??)

这个提到了spanner里的internva的概念吧  这本书还是牛逼啊 (多看看以后多看论文)


though you can get such as fine-grainied measurement, that doens't mean the value is actually accurate to such precision. 

Thus it doens't make sense to think of a clock reading as a point in time -- it is more like a range of times, within a confidence internal: for example: a system may be 95% confident that the time now is betwee n10.3 and 10.5, part the minute, but doesn't know any more precisely than that.  If we only know the time +/- 100ms, the microsends digits in the timestmap are essentially meaningles (因为误差太大了?)


 #### Spanner

 spanner implmeents snapshot isolation across dataceters in this way: it uses the clokcs's confidence internal as reported by the TrueTime API, and is based on the following observation: if tyou have 2 confidence internals, each consisting an earies and latest possibel timestamp (A = [Ae, Al]) and B = [Be, Bl] and those 2 internalves do not overlap (ie: Al < Be)
 then B definitely happened after A -- there can be no doubt. Only if the internavls onverlap, are we unsure in which order A and B happended.

 in order to ensure that transaction timesmps reflect causality,m spanner deliberately waits for the length of the condifent internval before commiting a read-write transaction. By doing so, it ensurs that any transaction that may read the data is at a sufficiently later tim,e so their confidence intervals do not overlap (相当于是等待了internval那么多的时间,这样发生的时间,就可以是确定的时间,事件们就可以有先后顺序了)

 In order to keep the wait time as short as possible, Spanner nees t okeep the clock uncertainty as small as possible; for this purpose, Google deploys a GPS receiver or atomic clock in each datacenter, allowign clocks to be syncrhonized to withinin about 7ms.

 Using clokc syncrhonization for distributed transactions sematics is an area of active research. These ideas are intereseting, but they have not yet been implmeneted in mainstream databases outside of Google.


 ## process Pauses (进程的暂停?)

 leader hold a lease to remain the  leader status


 ```
while(true) {

    request = getIncomingRequest();

    // ensure that the elase always has at least 10 seonds remaining 
    if(lease.expiryTimeMillis - System.currentTillis() < 10000) {
        lease = lease.renew();
    }

    if(lease.isValid()) {
        process(request); // 应该是启动一个新的线程?
    }

}

 ```

This is wrong, there's nothing to tell this thread that it was paused for so long, so this code won't ontiece that thse elase has expired until the next iteration of the loop -- by which time it may have already done something unsafe by processing the request.




when writing mulit-threaded code on a single machin, we have failly good tools for making it thread-safe; mutexes, semaphores, atomic, counters, lock-free data strucutres, blockign queuees and so on. Unfortunately, these tools don't directly translate to distributed systems, because a distributed system has no shared memory -- only messages sent over an unreliable network.

a ndoe in a distirbvuted system must asume that its execution can be pased for a significant length of time at any point, even in the middle of a function. During the pause, the reset of the worlf keeps moving and may even declare the pauh node dead because it's not responding. Eventually, the paused node may continue running, without even noticing that it was asleep until it checks its clock sometime later.

### Response time guarantees (时间保证?)


in some systems, there's a deadline. by which the software must respone; if it doesn't meet the deadline, that may cause a filaure of the entire system. These are so-called "real-time" system. 实时系统



> is real-time really real? 省略



for most server-side data processing systmes, real-time guarantees are simply not econmical or appropriate. Consequently, these systems mus suffer the pauses and locks instability that come from oeprating in a non-real-time environment.

### limiting the impact of garbage collection (减少垃圾回收所带来的影响)

一种策略是关掉当前在GC的节点


an emerging idea is to treat GC pauses like brief planned outage of a node, and to let other nodes handle requests from clients while one node is collecting its garbage. if the runtime can warning the application that  a node soon requires a GC pause, the app can stop sending enw request to that node, wait forit to finihsed processing outstanting request, and then perform the GC while no reqeust are in progress.

This trick hides GC pauses from client and reduces the high percentiles of response time. Some latency-setitve financial trading systems use this approach. (可以使用这种方法)


另外一种variant是GC的时候直接让这台机器unavailable,就像是在给机器做upgrade一样.


## Knowledge, truth, and lies


There's no shared momory, only mesaeg passing via an unreliable network with variable dealys, and the system may suffer from partial failures, unreliable clocks, and procesin pauses.


If a remote ndoe doens't respons, there's no way of knowing what state it si in, because probelms in the network cannot reliably be distinguished from problems at nodes.


Fortunately, we don't need to go as far as figuring out the meaning of life. in a distributed system, we can statethe assumption we are making about the behavior and design the actual system in such a way that it meet those assumptions. Algorithms can be proved to function correctly weithin a certain system dmode. This menas that reliable behavior is achievable, even if the udnerlying syste model prevides very few guarantees.



I nthis chpater, we will further exporel thenotion of knowlege and truth in distributed system, which will help usthink about he kinds of assumptions we can make and the guarantees we may want to provide,. In chapter 9, we will process to loo kat some example of distributed systems, algorithms tht provide particular guarantees under particular assumptions.

## the truth is defined by the majority (一致性问题?)




The nature of a distributed system is that: it cannot exclusively rely on a single node, because a node may fail at any tim,e potentially leaving the system stuc kand unable to recover.

Instead, many distributed algorithms rely on a quorum, that is voting among some minimum number of votes from serveral nodes in order to redue the dependence on any one particular node.

That includes decisions about declaring nodes dead. 

### The leader and the lock

FREQUENTLY, A system requrie thre to be only one of some thing

eg:

* only one node is allowed to be the leader for a database partition, to avoid split brain
* only one transaction or client is allowed to holde the hold for a particular resource or object, to prevent concurrently writing to it and currupting it.
* only one user is allowed to register a particular username, because a username must uniqely identify a user.

Implementing this in a DS requires care, a node may have formerly been the leader, but if the other nodes declared it dead in the meantime, it may have been demoted and another leader may have already been elected.

### fencing tokens ??

rejecting old request, due to a old token  (a fencing token)

## Byzantine faults (拜占庭错误)

howver, in the kind of systems we discuss in this book, we can usually safely assume that there are no Byzantine faults. In your datacenter, all the nodes are controlled by your organization, and radiation levels are low enough that memory corruption is not a major problem. Protocols for making systems rely on support from the hardware level. In most sever-side data systems, the cost of deploying Byzantine fault-tolerant solutions makes them impractical.


## System Model and reality

Algorithm need to be written in a way that does not depend too heavily on the details of the hardware and software configuration on which they are run. This in turn requries that we somehow formalize the kinds of faults that we expect to happen in a system. we do this by defning a 'system model', which is an abstraction that describes what things an algorithm may assume.

##### sychronous model

#### 半同步

#### 异步

##### crash- stop fualts

##### crash-recovery faults

#### byzantine(arbitrary) faults



### correctness of an algo

### safety and liveness (安全 + availability)


### mapping system models to the real world





