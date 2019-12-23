

# Replication

我们希望能够复制数据，可能是出于各种各样的原因：
* 使得数据与用户在地理上接近 (减少延迟)
* 即使系统出现一部分的故障,系统也能够继续工作
* 扩展可以接收请求的机器数量(从而提高吞吐量)


如果只有一份数据,并且不会随着时间改变而改变,那么复制每一个节点就万事大吉,但是困难之处在于,处理复制数据的变更(change)

三种流行的复制算法:
* single leader
* multi leader
* leaderless

几乎所有的分布式都采用了三种方法之一

## Leader and follower

1. one of the replicas is designated the leader (master or primary)
2. the other replicas are know as followers(read replicas, slaves, secondaries etc)
3. when a client wants to read from the database, it can query either the leader or any of the followers. However, wreite are only acceptable on the leader (the followers are readonly from the client's point of view)

This mode of replication is built in for relational databases: PostgreSQL, MySQL, Oracle Data guard, etc.



## Syncrhonous Versus Asynchronous replication


...

The advantage of synchronous replication is that the follower is guaranteed to have an up-to-date copy o the dat that is consistent with the leader. If the leader suddenly fails, we can be sure that the data is still avilable on the follower. The disadvantage is that if the follower doesnt' respond, then the write cannot be processed. The leader must block all the writes and wait until the syncrhonous replica is available again.

sometimes, we need semi-synchronous.

weakenning durability may sound like a bad trade-off, but asynchronous replication is neverthessless widely used, especially they are many followers or if they are geographically distributed.



## setting up new followers

you could make the files consistent by locking the database (making if unavailale for writes), but that would go against our goal fo high availability. Fortunately, setting up a follower can usually be done without downtime. Conceptually, the process looks like this: 

1. take a conssitent snapshot of the leader's database at some point in time -if possible, without taking a lock on the entire database.
2. copy the snapshot to the new follower node
3. the follower connects to the leader and request all the data changes that have happended since the snapshot has taken. This requires that the snapshot is associated with an exact position in the leader's replication log. the position has variaous names: postgreSQLcalled it the log sequence number, and Mysql called if the binlog coordinates.
4. when the follower has processed the backlog of data changes since the snapshot, we say it has caught up. It can now continue to process data changes from the leader as they happen.


## handling not outages

Any node in the system can go down, perhaps unexpectedly due to a fault, but just as likely due to planned maintenance (for example, rebooting a machine to install a kernel security patch), being able to reboot individual nodes without downtime is a big advantage for operations and maintenance. Thus, our goal is to keep the system as a whole running despite individual node failures, and to keep the impact of a node outage as small as possible.



question: how to acieve high availability with leader-based replication?


### follower failure: catch-up recovery

On its local disk, each follower keeps a log of the dat chagnes it has received from the leader. if the follwer crashes and isrestarted, or if the network between the leader and the follower is temporarily interrupted, the follower can recovere quite easily fro mits log, it knows the last transaction that was processed before the fault occurred. Thus, the follower is able to connect to the leader and request all the data changes that occurred during the time when the follower was disconnected. Whne it has applied these changes, it has caught up to the leader and can continue receiving a stream of data changes as before. 

### leader failure: failover

it is tricky:  one of the follower needs to be promoted to be the new leader. clients need to be reconfigured to send thier writes to the new leader, and the other followers need to start consuming data chagnes from the new leader, This process is called **fail Over**. (从头再来?)

Failover can be manually but also automatically. An automatic failover process usually consists of the following steps

1. **Determing that the leader has failed.**
Things can go wrong: crahes, power outages, network issue, and more.

2. **choosing a new leader**
This could be done through a leader election process (leader is chosen by a majority of the remaining replicas)


3. **reconfiguring the system to use the new leader.**
... The system needs to ensure that the old leader becomes a follower and recognize the new leader


Failover is fraught with things that can go wrong

* If asynchronous repication is used, the new leader may not have the receive all the writes from the old ldeader before it has failed. The most common solution is for the old leader's unreplicated writes to simply be discarded, which may violate client's duarility expectation.

* Discarding writes is especially dangerous if other storage systems outside ofthe database need to e coordinated with the database contents. 

* In certain fault scenarios, if could happen that 2 nodes believe that they are the leader. "Split brain", 

* What is the right timeout before the leader is declared dead? If the timeout is too long, it takes a longer time to recovery in the case where the leader fails. However, if the timeout is too short, there could be unnecessay failovers.


-> 

These issues -- node failures; unreliable networks; trade-offs around replicas consistenty, durability, availability, and latency -- are in fact fundamental problems in distributed systems.


## Implemenatation of replication logs (log备份)

### Statement based replication

tahe leader logs every write request (statement) that it executes and sends that statement log to its followers. For a relational database, this means that every insert, update, or delete statement is forwarded to folowers, and each foloer parses and executes that sql statement as if it has bren received from a client. 

This approach can break down:

* Now() Rand(), is likely generate a different value on each replica
* Sequence Id: this can elimiting when there are multiple concurrently executing transactions
* statements that have side effects, may result in different side effects occurring on each replica, unless the side effects are absolutely deterministic

### write ahead log (WAL) shipping

storage engines represent data on disk, and we found that usually every write is appended to a log:
* in the case of a log -structureed storage engine (SSTable, LSM-trees), log is the main place for storage, log segments are compacted and garbage-collected in the background
* in the caes of a B-tree, which overwrites individual disk blocks, every modification is first written to a write-ahead log so that the index can be resotred to a consisten state after a crash.



In either case, log is an append-only sequence of bytes containing all write to the datase. We can use exact same log to build a replica on another node: besides writing the log to disk, the leader also sends it across the network to its followers.

When the follower processes this log, it builds a copy of the exact same data structure as found on the leader.


This method of replication is used in PostgreSQl and oracle, the disadvantageis that the log describes the dat on a very low level: a WAL  contains details of which bytes were changed in which disk blocks, This makes replication closely coupled to the storage engine, If the datbase changes its sotrage format fro mone version to another, it is typically not possible to run difffernt version of the database software on the leadre and the followers


意味着不能够使用failover来直接异步升级软件


### logical (row based) log replication

alternative is to use different log formats for replication and for the storage engine, which allows the repliation log to be decoupled from the storage engine internals.

A logical log for a relational database is usually a sequence of recors, describing writes to database tables at the granularity of a row


* for an inserted row, the log contains the new values of all columns
* for a dleted row, the log contains enough information to uniquely idenity the row that was deleted. Typically this would be the primary key, but if there's no primary key on the table, the old values of all columns need to be logged.
* for an updated row, the log contains enough information to uniquely identify the updated row , and the new values of all columns


Since a logical log is decoupled from the storage engine internals, it can more easily be keprt backward compatible, allowing the leader and the folower to run different versions of the datbase software, or even, differnt storage engines. 

### trigger based replication

a trigger lets you register a custom application code that is automatically executed when a data change occurs in a database system. The trigger has the oppportunity to log this change into a separate table, from which it can be read by an external process. That externa lprocess can then apply any necesary application logic and replicate d the data chagne to another system.

Trigger-based replication typically has greater overheads that other replications methods, and more prone to bugs. But, it can be useful due to its flexibility.


## Problems with replication lag (延迟)

Being able to tolerate node failures is just one reason for wanting replication. 

Leader-based replication, require all writes go through a single node, 
but read-only queries ca ngo to any replica.

In this read-scaling architecture, youcan increates the capacity of serving read-only requests simply by adding more followers. However, this approach only realistically works with async replication- if you tried to syn replicate to all followers, a single node failure or network outage would make the entire system unavailable for writing. And the more nods you have, the likler it is that one will be down, so a fully syhnc configuration would be very unreliable.

if you read from a replica, that haven't have fully synced, you will get stale data. This inconsistency is just a temporary state- if you stop writing to the database and wait a while, the followers will eventually catch up and become consistent with the leader. For that reason, this effect is know as 'eventual consistency' (最终一致性)

Lag跟长的,时候是一个非常严重的问题

## reading your own writes 

eg: a user makes a write, followed by a raed from a stale replica, To prevent this anomaly, we need read-after-write consistency (读写先后一致性)

raed-after-write consistency (read-your-writes consistency)

If makes no promieses about other userse: other users's updates may not be viisible until some later trime. However, it ensures the user that thier own input has been save correctly (一个user的角度,数据是对的)


how to implment rad-after-write consistency?


* when read something that user may have modifed, raed it from the leader; otherwise, read it from a follower. This requires someways to know hether somehting might have been modifed , without actually query it. one example: always raed users's own profile from the leader, and a ny other users' profiles from a follower

* if most things in the application are potentially editable yb the user, that approache won't be effective, at most thigns would have to be read from the leader. ....? You could also monitor the replication lag on followers and prevent queies on any followers that is more tha none minute behind the leader.

* The client can remember the timestamp of its most recent write --then the system can ensure that the replia serving any reads fro that user reflects updates at least until that timestamp. If a repliais not suffiently up to date, either the read can be handled byanother replica or the query can wait until the replia has caught up. The timesamp could be a logical timesatmp, or actual system clock
* if your replicas are distributed across multiple datacenters??


Another complication arises when the same user is accessing your service from mulitple devices, for example a desktop web brower, and a mobile app. In this case, you need to provie a coss-device read-after-write consistency: if the user enters some information on one device, then veiw it on another device, they should see the information they just entered.

additional issues to consider:

* approaches that requrie remembering the timestamp of the users's last update become more deifficult, because the code running on one device doens't know waht updates have happended ono the other device. This **metadata** will need to be centralized.

* if your replias are distriuted across different datacenters, there's no guarntee that connections from different devices will be routed to the same datcenter. (homepc: home broadband connection, mobile: uses ceuullar data network)

probably need to route all the request of the same user to the same data center (more effort?)


## Monotonic reads (单调读)

另一个情况: 用户读操作结果不一致 (原因是从不同的follower读取数据)

eg: a user first read fro ma fresh replica, the nfrom a stale replia, time appears to be backward. To prevent this anomaly, we need to monotonic reads.

"Monotonic reads"  is a guarantee that this kind of anomaly does not happen. It is a lesser guarantee than strong consistency, but a stronger guarantee than eventual consistency. when you rad data, you many see an old value; monotonic reads only mneas that if one user makes several reads i nsequence, they will not see tiem go backwards.


One solution is to make sure each user alawarys makes their reads from the same replica (differnt user may read fro mdiffernt replicas)

The replica can be chosen baed on the has of the user ID, rather than random ID. However, if the repli failes, the user's queries will need to be rerouted to another replica.

## Consistent prefix reads

如果还有一个人在监听另外两个人之间的对话,也可能会有不一致的情况

Preventing this kidn of anomaly require  another type of guarntee: consistent prefix reads. This guarantee says that if a sequence of writes happens in a certain order, then anyone reading those writes will see them apprea in the same order (group record 一致性?)

This is a particular problem in partitioned (sharded) databases, which we will discuss in Chapter 6. if the database always applies write in the same order, read alraesy see a consisten prefix, so this anomaly acnnot happen. However, in many ditributed databases, different partitions operate independently, so there is no global ordreing of writes: whe na user reads from the database, they may see some parts of the datbase in an older state and some in a newer sate.

One solution is to make sure that any writes that are casually related to each other, are written to the sae partition -- but in some applications, they cannot  be done efficiently. 


## Solutions for replication log (备份延迟的各种处理方法)

When worign with an eventually consistent system, it is work thinking about how the application behaves if the replication alg increases, to serveral minutes or even hours.

Single node transactions have eisted for a long time.Howeever, in the move to distributed databases, many systems have abandoned tem, claming that transactions are too expensive in the terms of performance and availability, and asserting that eventual consistency is inevitalbe in a scalable system. 


## Multi-leader replication

a natural extension of the elader -based replication model is to allow more than one node to accept writes. Replication still happens in the same way: each node that processes a write must format that data chagne to all the other nodes. We call this a multi-leader configuration. Eacach eader simultaneously acts as a follower to the other leaders.??


### User case for multi-leader replication

one single leader: with  a normal leader-based replication setup, the leader has to be in one of the datcenters, and all writes must go through that data center.

in a multi-leader cofiguration, you can havea leader in eacht datacenter, within each datacenter, regular leader-folwer repllicate is used; between data centers, each datacenters' leader replicates ins changes ot the leaders in other datacenters. (多个leader, 多个leader之间要有同步)


let's compare how the single leader and muti-leader configuartions fare in a multi-datacenter depoymnet:

* performance
    * every write must go over the internet to the datacenter with tthe leader. This can add significantly latency to writes and might contravene the purose of having multiple datacenters in the first place. In a multi-leader configuartion, every write can be processed in the local datacednter, and is replicated asyn to the other datacenters. Thus ,the inter-datacenter network delay is hidden from users, which means the perceived performance may be better.

* Tolerance of datacenter ourages
    * in a single-leader configuaration, if the atacenter with the leader failes, failover can promote a follower in another datacenter to be leader. In a multi-leader congfiguration, each datacenter can continue operatin independently, of the others, and replicaion catch up when the failed datacenter comes back online.

* Tolerance of network problems
    * traffic betwen datacenters usually goes over the public internet, which may be less reliaable than the local network within a datacenter. a single-leader configuration is very sensitive to bproblems in this inter-datcenter-link, because write are mode syncly over this link. a multi-leader configuartion with asyn replication can usuaully tolerate network problems better: a temporary netowrk interruption doesn not prevent writes **being processed.**


But everything has downsides:
* the same data may be concurrently modified in 2 different datacenters, and those write conflicts must be reoslved (indicated as conflict resolution ). We will discuss this issue in "handling write conflicts " on page 171


### clients with offline operation (like doc?)

another situation: where an application that needs to contineu to work while it is disconnected from the internet.

eg: calendar apps. You nee to e albe to see your meetins and enter new meetins at any time, regardless of whether your device currently has an internet connection. if you make any changes while you re offline, they ned to be syned with a server and your other devices when the device is next online.


In this ase, every device has a local database that acts as a leder (it acepts wrtie requests), and there's an synchrnous multi-leader replication process (sync) between teh replicas of your calendar on all of your devices. The lag may differ, depending on when you ahve internet access available.

From an architecture point of view, this setup is essentially the smae as multi-leader replication between datacenters, taken to the exterme: each device is a 'datacenter', and the network connection between them is extermeem unreliable. 

### Collaborative editing (协作编辑)
when editing a document, the changes are instantly applied to their local replica and asyn replicated to the server and nay other userse who are edigting the same document.

if you want to guarnatee that there will be no editing conflicts, the appliction must obtain a lock on the document before a user can edit it. If another user wants to edit the same docuemtn, they first have to wait until the first user has comited their changes nad release the lock. This collaborationmodel is equivalent to single-leader replicatio with transactions on the leader.


However, for faster collaboration, you may wnat to make the unit of change very small, and avoid locking. This approach allows mulitple users to edit simultaneously, but it also bring all the clanneges of multi=leader replication, including requireing conflict resolution.


## handling write conflicts (解决写冲突)

The biggest problem with multi-leader replication is that write conflicts can occur, which means that conflict resolution is required.



### sync, vs async conflict detection

on a mulit-leader sectup, both writes are successful, and the conflict is only detected asyn, at some later point in time. At that time, it may be tool ater to ask the user to resolve the conflict.


In principle, you could make the conflict detection syn, eg: wait for write to be replicaed, to all replicas, before telling the user that the write was successful. however, that would lose the main advantage of multi-leader repliation: allowing each replica to accept writes independently. If you want synchronous conflict detection, you might as well just use single-leader replciation.


### conflict avoidance

可以都route到同一个host去,就可以有时间先后的顺序,不需要解决冲突


### Converging toward a consistent state

single-leader: if there are several updates to the same field, the last write determines the ifnal value of hte field.



Every replication schemem must ensure that the data is eventualy the same in all replicas. Thus ,the datacenter must resolve the conflict in a "convergent way", which means that all replicas must arrive at the same final value, when all change have been replicated.


There are couple of ways to achieve convergent conflict resolution:

* given each write a unique ID(timesamp, long random number ,UUID etc), pick the write with the hightest ID as the winner, and throw away the rest. but this approach is prone to data loss

* given eacht replia a unie id, and let write that origninated at a hier numered replia ayaws take predecence overwrite that origizate at a lower numbered replica. This approach also implies data logss.
* somehow merge the vlues together --- order them alphabetically and then the merged title could be: "B/C" etc 

* record the conflict in an explicit dat structure, that repserve all information, and the write application code, that reoslve the conflict at some later time (like git reolsve conflicts)


### custom conflict resolution logic


The resolving logic code, may be executed onwrite or on read

* on write
    * as soon as the db detects a conflict in the log of replicated changes, it calls the conflict handler.
* on read
    * when a conflict is detected, all the confliecting writes are stored. The next time the data is read, these multiple verions of the data are returned to the application. The app, may prompr the user or automatically resolve the conflict, and write the rsult back to the database. CouchDB works this way, for example.




### What is a conflict??

Some kind of conflict are obvious. 

Other kinds of conflict can be more subtle to detect. 




eg: booking meeting. There is nt a quick ready-made answer, but following chapters we wil trace a path toward a good understanding of this problem.


## Multi-leader replication topologies (多个Leader的拓扑图)

eg:
* circular 
* star
* all to all topology

issue still occurs


... This is a problem of causality, similar to the ones we saw in "Consistent prefix rads", the update dependes on the prior insert, so we need to make sure that all nodes process the insert first, and then the update. Simply attaching a timesstamp to every write is not sufficient, becasue clocks cannot be tursted to e suffiiciently in syn to correctly order these events at another leader.


To order these events correctly, a technique called "version vector" 版本向量 can be used. which we will discuss later in this chapter. 


## Leaderless Replication

so far discussed, are about a leader determines the order in which writes should be processed, and folllowers apply the leader's writes in the same order.

Dynamo is leaderless repoiication.


--> Dynamo style



in some leaderless implmentations, the client directly sends its writes to serveral replicas, while in others, a coordinatornode does thsi on hehalf of the client. However, unlike a leader database, that coordinator does not enforce a particular ordering of writes. As we shall wee, this difference in design has profound consequences for the way the datbase is used. 


## Writing  to the DB when a node is down

On the other hand, in a leaderless configuration, failover does not exist. 

eg: one scenario, where user send set method to 3 replica, and 1 of them is offline. after some time, it went back, and user 2 query that exact record, he will get stale data.

To solve that problem, the client doesn't just send its request ot one replica: read request are also sent to serveral ndoes in parallel. The client may get differnt response from differnt nodes: id: the up-to-date value from one node and a stale value from another. Version number are used to determine which value is newer


### Read repair and anti-entropy

how to repair nodes?

2 mechanisms are ofter used in DYnamo-style datastores

* read repair
    * when a client makes a read from serveral nodes in parallel, it can detect any stale responses. For example, The client goet 3 response from 3 nodes, and write the newer value back to that replica, this approach works well for values that are frequently read.

* anti-entropy process?
    * in addition, some datastores have a background process that constantly looks for differences in the dat between replicas and copies any missing data from one replia to another. Unlike the replication log in leader-based replication, this anti-entropy process does not copy writes in any particular order, and there may bea significant delay before data is copied.

### Quorums for reading and writing

分析

if we know that every successful write is guarnteed to ge present on at leadst two out of thres replicase, that means at most one replica can be stale. Thus, if we read from at least 2 replicas, we can be sure that at least one of the two is up to date. If the thirst replica is down or show to respond, reads can nevertheless continue returning an up-to-date value.

More generally, if there're n replicas, every write must be confirmed by 2 nodes to be considered to be succesful, and we must query at least r nodes for each read. as long as w + r > n, we expted to get an up-=to date value when reading. because at leadt on e of the r nodes we are reading from must be up to date. Reads and writes that obey these r and w values are called quorum, reads and writes. **You can think of r and w as the minimum number of voites required fro the read or write to be valid.**

a usual choice:

w = r = (n+1) /2 (rounded up)

Normally, read and write are always sent to al n replias in paralel. The parameters w and r determine how many nodes we wait for. 

If fewer than the requiredw or r nodes are avilable, writes or reads return an error. A node could be unavilable for many reasons: because the node is down (crahsed, powered down), due to an error executing the operation (can't write because the disk is full, network iterruption). We only need to care whether the node returned a succesful response and don't need to distringuish betwee ndiffernt kinds of fault.

## Limitations of Quorum consisteny (局限性)

?



### monitoring staleness

From an operational perspective, it is important to monitor whether your database arereturning up-to-date results. Even if your application can tolerate stale read, you need to be aware of the heal of your replication/. if it falls behind significantly, it should alert you so that you can invistigate the root cause. 

However, in ssytem with leaderless replication, ther'es no fixed order in which writes are applied, which makes monitoring more difficult. 

## Sloppy QUorum and hinted handoff ??

### multi-datacenter operation


## Detectin concurrent writes