# Consistency and consensus 

一致性以及达成共识

> is it better to be alive and wrong or right and dead?


The best way of building fault-tolerant systems is to find some general-purose abstractions with useful guarantees, implmenet them once, and then let applications rely on those guarantees. This is the same approach as we used with transactions in Chapter 7, by using a transaction, the application can pretende that therer are no crashes, and that nobody else is concurrently accessing the database.Even though crahes, race conditions, and disk failures do occur, the transaction abstraction hides those problems so that the application doesn't need to worry about them.

One of the most important abstractions in the distributed ssytem is "consensus": that is getting all of the nodes to agree on something.



## Consistency guarantees (一致性保障)

most replicated databases provide at least "eventual consistency", which means that if you stop writing to the database and wait for some unspecified length of time, then eventually all read requests will return the same value. In other works, the in-consistency is temporary, and it eventually resolves itself (assume that any faults in the network are also eventually repaired.) A better name for eventual consistency may be "convergence", as we expect all replicas to eventually converge to the same value. 

"Eventual conssitency" is hard for application developers because it is so different from the behavior of variables in a normal single-threaded program. if you assign a value to a variable and then read it shortly afterward, you don't expect to read back the old value, for the read to fail. 

when working with a database that provides only weak guarantees, you need to be constantly aware of its limitations and not accidentally assume too much. Bugs are often subtle and hard to find by testing, becaseu the application may work well most of the time. The edge of the eventual consistency only becomes appreat when there's a fault in the system (a network interruption) or at high concurrency.


In this chapter we wil explore stronger consistency models that dat systems may choose to provide. 

they don't come for free: systems with stronger guarantees may have worse performance or be less fault-tolerant than systems with weaker guarantees. Nevertheless, stronger guarantees can be appealing becasu they are easier to use correctly (事实..)

Once you have seen a few different consistency models, you'll be in a better position, to decide which one best fits your needs.

There is some similarity between distributed consistency models and the hierarchy of transaction isolation levels we discussed previously. 

Transaction isolation is primailry about avoiding race conditions due to concurrently executing transactions, whereas distributed consistency is mostly about corrdinating the state of replicas in the face of delays and faults.

* start with linearizability, and examine its pros and cons
* issue of ordering events in a distributed system
* atomically commit a distributed transaction, which will finally lead us toward solutions for the consensus problem.

ok...



## Linearizability 线性一致性

basic idea is to make the system appear as if there wrer only 1 copy of the data, and all operations on it are atomic. with this guarantee, even though there maybe mulitple replicas in reality, the application does not need to worry about them.

in a linearizable system, as soon as one client successfully completes a write, all clients reading from the database must be able to see the value just written. 


## what makes a system linearizable?

make the system as if there is only a single copy of the data.

eg: 9-2

* read(x) => v, means the client requested to read the value of register x, and the database returned the value v.
* write(x, v) => means the client requested to set the register x to value v, adn the database returned response r (which could be ok or error etc...)



补充 cas(x, Vold, Vnew) => r 这个方法....




### linearizability 跟 serializability的区别

#### serializability

is an isolation property of 'transactions', where every transaction may read and write mulitple objects (rows, documents, records). it guarantees that transactions behave the same as if they had executed in some serial order (each transaction running to completion befor ethe next transaction starts). it is okay ofr that serial order to be different from the order in which transactions were actually run.

#### linearizability

is arencency guarnatee on reads and writes of a register (an individual oject). it doesn't group operations together into transactions, so it does not prevent problems such ah write skew, unless you take additional measures such as materializing conflicts




## Relying on linearizabilty ?

妈的  看不进去

There are a few areas in which linearizability is an important requirement ofr making a system work correctly.



### Locking and leader election

eg: leader election. One wy of electing a leader is to use a lock: every node tries to acquire the lock, the one that succeeded bcomes the leader. No Matter how the lock is implemented, the lock must be linearizable. All nodes, must agree which node owns the lock: otherwise it is useless.


Coordination sevices like ZK, and etcd are aoften used to implment distriuted locks, and leader lection. They use concensus algo, to implmenet linearizable operations in a fault-tolerant way.


Distriuted Locking is also used at a much more granular level in some distriuted database, such as Oracle real application clusters.

### constrains and uniquness guarantees

uniqueness is common in databases.
if you want to enforce this constraitnt as the data is written, you need linearizability 


In real applications, it is sometimes acceptable to treat such constrints loosely. like booking flight...

In such cases, linearizabilit may not be needed, and we will discuss such loosely interperted constraints in "time and integrity " on page 524.



### cross-channel timing dependencies


The linearizability violation was only noticed becasue there was additional communication channel in the system. (eg: Alice's voide, to bob's ears)



eg: photo resize task: The image resider needs to be explicitly instructed to perform a resizing job, and this instruction is sent from the web server to the resizer via a message queue. The web server deson't place the entire photo on the queu, since most messge brokers are designed to hold smaller messages, and a photo may be several megabytes in size. Instead, the photo is first written to a file storage sevice, and once the write is complete, the instruction to the resizer is placed on the queue.

看图 9-5

这个例子如果不是linearizable会有问题,queue里的压缩请求会比acutal harddisk storage先触发,那么就会有null pointer.

This problem arises becase there are 2 differnt communication channels, between the wb server and the resizer.

Linearizability is not the only way of avoiding this race condition, but it's the simplest to understand.


## Implementing linearizable systems (如何设计系统呢?)

定义: 
behave has though there only a signle copy of the data, and all operations on it are atomic. 


比较几种方法

* single leader replication (potentially linearizable)
* consensus algorithms (linearizable)
    * consensus protocols contain measures to preven split brain and stale replicas. Thank to theses details, consensus algorithms can implement linearizable storage safely. This is how Zk and etcd work.

* multi-leader replication (not linearizable)
    * simply because they concurrently process write on mulitple nodes, and asyncronously replicate them to other nodes.
* leaderless replication (probably not linearizable)


### linearizability and quorums

??

## The cost of linearizability



### The CAP 理论

This issue is not just a consequence of single-leader and multi-leader replication: any linearizable database has this problem, not matter how it is implmeneted. THe isue also isn't specific to multi-datacenter deployments, but can occur on any unrelizable netowrk, even within one datacenter. 


THus --> applications that don't require linearizability can be more tolerant of network problems. 

因为netowrk 总是会出问题,所以问题实质上是:

> either consisteny or avaialble when partitioned


CAP does not help us understand system better, so CAP is best avoided.

The CAP theorem as formally defined is of very narrow scope: 

one consistency model and one kind of fault.  (?)


so CAP is historically influential, it has little prctical value for designing systems (有点东西)


### Linearizability and network delays

The reason to drop linearizabily is performance, not fault tolerance.


## Ordering guarantees 顺序保证

## Ordering and causality 因果关系

Order helps presreve causality.

Causaility impose an ordering on events: cause comes before effect; a mesage is sent before that message is received; the question comes before the answer. And, like in real life, one thing leads to another: one node reads some data and then write something as a result, another node reads the thing that was written and write something else in turn, and so on. These chains of causally dependent operations define the causal order in the system -- ie: what happend before what.


If a system obets the ordering imposed by causality, we say that it is causally consistent. For example, snapshot isolation provides causal consisteny: when you read from the database, you see some piece of data, then you must also be able to see any data that causally precedes it

### the causal order is not a total order (因果关系不是全局的关系)

* linearizability
    * in linearizable system, we have a totla order of operations: if the sustem behvaes as if ther's only a single copy of the data, and every operation is atomic, this menas that for any 2 operations, we can always say which one happended first. This total ordering is illustrated as a timeline .
* causality
    * two events are ordered if they are causally related. This menas that causality defines a partial order, not a total order: some operations are ordered with respect to each other, but some are incomparable.


Concurrency would mean that the timeline branches and mergees again -- and in this case, oeprations on different branches are incomparable (concurrent). We saw this phenomenon in Chpater 5.


### Linearizability is stornger than causal consistency (of course..)


### capturing causal dependencies


### sequenced number ordering

a timestemp could be helpful. it can be come from a logic clock, which is al algorithm to genreate asequence of numbers to dientiy oeprations, typeically using counters tht are incremented for every operation.


Such sequence numbers or timestemps are compact, and they provide a total order, 




### noncausal sequence number generators (没有因果关系的如何生成呢?)

* each node can genreate its own independent set of sequencen umber.

* you can attach a timestamp from a time-of-day clock (physical clock) to each operation. Such timestamps are not sequential, but if they have sufficiently high resolution, they might be suffient to totally order operations. This fact of used in the last write winds conflict resolution method.
* you can preallocate blocks of sequence numbers.

There's the issue: the sequence number generated from the generators do not correctly capture the ordering of operations across different nodes:



### Lamport timestamp (lamport 时钟)



each node has a unique identifier, and each node keeps a counter of the number of operations it has processed. The lamport timestamp is then simply a pair of (counter, node ID). Two nodes may sometimes have the same counter value, but by including the node ID in the timestamp, each timestamp is make unique.

it provides total ordering: if you have 2 timestamps, the one with a greater counter is greater timestemp; if the counter value are the same, the one with the greater node ID is the greater timestamp(强制有序?)


The key idea about Lamport timestamp, which makes them consistent with causality, is the following: every node and every client keeps track of the max counter value it has seen so far, and includes that max counter value on every request. When a node receives a request or response with a max counter value greater than its own counter value, it immediately increases its own counter to that max (won't there be wholes??)


As long as the max counter value is carried along with every operation, this scheme ensures that the ordering from the lamport timestamps is consistent with causality, because every causal dependency results in an increased timestamp.


difference between version vector?

* version vector
    * distinguish whether 2 operations are concurrent or whether one is causally dependent on the other
    * Lamport timestamps: always enforce a total ordering.


### timestamp ordering is not sufficient

eg: user creation with the same username

Howvere, it is not suffient when a node has just recieved a request from a user to create a username, and needs to decide right now whether the request should succeed or fail. At that moment, the node doesn't know whether another node is concurrently in the process of creating an account wiht the same username, and what timestamp that other node may assign to the operation (还是没有全局的信息)


In order to be sure that no other node is in the process of concurrently creating an account with the same username anda lower timestamp, you would have to check with every other node to see what it is doing. If one of the other nodes has failed or cannot be reached due to a network problem, this system would grind to a halt, This is not the kind of fault-tolerant system tat we needed.


The problems here is that the total order of operation only emerges after you have collected all of the operations. If another node has generated some operations, but you don't yet know what they are, you cannot construct the final ordering of operations: the unkonwn operations from the other node may need to be inserted at avarious positions in the total order.

To conclude, in order to implmeent something like a uniquenss constraint for username, it's not sufficient to have a total ordering of operations -- you alos ned t oknow when that order is finalized. If you have an operation to creata username, and you are sure that no ther node can insert a claim for the same username ahead of your operation i nthe totoal order, the nyou can safely declare the operation succesful.

## Total order broadcast

ordering by timestamp is not better than a single-leader replication.

which determines a total order of operations by choosing one node as the leader and sequencing all operations on a single CPU core on the leader. 


Total order broadcase is usually described as a protocol for exchanging messages between nodes. Informally, it requires that 2 safety properties always be satisfied.

#### reliable delivery

no messages are lost: if a message is delivered to one node, it is delivered to all nodes.


#### total ordered delivery

messages are delivered to every node in the same order

### Using total order broadcast

Consensus algo such as ZK wil implement a total order broadcast. 


Total order broadcase is exactly what needed for DB replication: if every message represnets a write to the DB, and every replica process the same writes in the same order, then the replicase will remain consistent with each other. (asign from any temporary replication lag). This principle is know as **State machine replication**, and we will return to it in Chapter 11.

Similarly, total order broadcase can be used to implement a serializable transactions: as discussed in "actual serial execution", eif every message reprsents a deterministic transaction to be executed as a stored procedure, and if every node processes those message in the same order, then the partitions and replicas of the database are keprt consistent with each other.



An important aspect of total order broadcast is that the order is fixed at the time the message are devlivered: a node is not allowed to retroactively insert a message into an earier position in the order if subsequence messages have already been delivered. This fact makes total order broadcase stronger than timestamp order.

Another way of looking at total order broadcast is that it is a way of creating a log(as in a replication log, transaction log, or write-ahread log): delivering a message is like appending to the log. and all messages are sequentially numbered in the order they appreat in thlog. The sequence number can then serve as a fencing token, because it is monotonically increasing. In ZK, the sequence number is called "zxid", 哈哈哈 看完都忘记了..;

### implementing linearizable storage using total order broadcast

As illustrated in Figure 9-4, in a linearizable system there is a total order of operations. Does that mean linearizability is the same as total order broadcast? Not quite, but there are close links between the two.

Total order broadcast is async: messages are guaranteed to be delivered reliable in a fixed order, but here's no guarantee about when a message will be delivered. (so one recipient may lag behind the others.) By contrast, linearizability is a recency guarantee: a read is guaranteed to see the latest value written.


eg:
you can implement such a linearizable compare-and-set operation as follows by using total order broadcast as an append-only log.

1. append a message to the log, tentatively indicating th username you want to claim.
2. read the log, and wait for the message you appended to be delivered back to you.
3. check for any messages claiming the username that you want. If the first message for your desired username is your own message, then you are successful; you can commit the username claim, (perhaps by appending another message to the log). and ack it to the client. If the first message for your desired username is from another user, you abort the operation. 

Because log entries are delivered to all nodes in the same order, if ther are several concurrent writes, all notes will agree on which one came first. Choosing the first of the conflicting writes as the winner and aborting later ones ensures that all nodes agree on whether a write was comited or aborted. A similar approach can be used to implmeent serializable multi-object transactions on top of a log.

However, this procedure ensures linearizable write, it doesn't guarantee linearizable reads -- if you read from a store that is synchonously updated from the log, it may be stale (To be precise, the procedure described here provides sequenctial consistency, sometime also known as timeline consistency. A slightly weaker guarantee than linearizability ??). To make reads linearizable, there are a few options:

* sequence read, through the log by appending a message, only returns the message when actually performed to this entry, and then devliered back to you. The message's position in the log thus defines the point in time which the read happens.
* if the log allows you to fetch the position of the latset log message in  alinearizable way, you can query that position, wait for all entries up to that position to be delivered to you, and then perform the read. (如果是lineariable 系统??)
* you can make your read fro ma replia that is synchronously updated on writes, and is thus sure to be up to dat.


### implementing total order broadcast using linearizable storage (线性一致性的存储,--> 实现 全局有序的广播)

The algo is simple, for every message you want to send through total order broadcast, you increment-and-get the linearizable integer, and then attach the value you got from the register as a sequence number to the message. You can then send the message to all notes (resending any lsot messagse), and the recipients will deliver the messages consecutively by sequence number.


Note that unlike Lamport timestamps, the number you get from incrementing the lineariable register for ma sequence with no gaps. Thus if a node has delivered message 4 and recieves an incoming message with a sequence number of 6, it knows that it must wait for message 5 before it can deliver message 6. which is not the same as Lamport timestamp, in fact, this is the key difference betweeen total order broadcast and timestamp ordering.


This is no coincidence: it can be proved that a linearizable compare-and-set register and total order broadcast are both equivalent to consensus. That is, if you can solve one of these problems, you can transform it into a solution for the oters. This is quite a profound and surprising insight!

now let's tackle on consensus problem head-on.


## Distributed Transactions and consensus

Consensus is one of the most important and fundamental problems in distriuted computing. On the surface, it seems simple: informally, the goal is simply to get serveral nodes to agree on something. You might think that this shouln't be too hard. unFortunately, amny broken systems have been build in the mistake belief that this problem is easy to solve.


There are number of situations in which it is important for nodes to agree. For example,

eg: 

#### leader election

The leadership position might become contested if some nodes cannot communicate with others due to a network fault. In this case, consensus is important to avoid a bad failover, resulting in a split brain (脑裂).  which 2 nodes both believe themselfes to be the leader. If there are 2 leaders, they would both acceprt writes and their data would diverge, leadeing to inconsistency, and data loss.

#### atomic commit (原子性提交)

if we want to maintain transqaction atomicity, we have to get all nodes to agree on the outcome of the transaction: eitherthey all abort/roll back, or theyall commit. This instance of consensus is known as the atomic commit problem.




In particular, we will discuss 2-phase (2PC) algo, which is the most common way of solving atmic commit and which is implmeented in various databases, messaging systems, and application severs. It turns out that 2PC is a kind of consensus alg -- bot not a very good one.

By learning from a 2pc we will then work our way toward better consensus algo, such as those used in ZK


## Atomic Commit and 2-phase commit (2PC)

The outcome of a transaction is either a successful commit , in which case all of the transactions's writes are made durable, or an abort, in which case all of the transactions' writes are rolled back.

Atomicity prevents failed transactions from littering the database with half-finished results and half-updated state.This is especially important for multi-object transactions, and databases that maintain secondary indexes.  Each secondary index is a separate data structure from the primary data -- thus, if you modify some data, the corresponding change needs to also be made in the secondary index. Atomicity ensures that the secondary index stays consisten with the primary data (if the index became inconsistent with the priamry data, it would not be very useful)

### from single-node to distributed atomic commit

for transactions that execute at a single DB node, atomicity is commonly implmeented by the storage engine. When the client asks the database node to commit the transaction, the database makes the transactions writes durable, and the nappends a commit record to the log on the disk. If the database crahes in the middle of this process, the transaction is recovered fro mthe log when the node restarts: if the commit record was success fully written to disk before the creash, the transaction is considered commited; if not ,any write from that transaction are rolled back.

Thus, on a single node, transaction commitment crucially dependes on theo order in which data is durably written to disk: first the data, then the commit record. The key deciding moment for whether the transaction commits or aborts is the moment at which the dis kfinished writing the commit record: bofore that moment, it is still possible to abort (due to a crash). But after that moment, the transaction is commited (even if the DB creahes). Thus it is a single deice that makes the commit atomic.






