# Partitioning


名词

Partition

* MongoDB, Elasticsearch: Shard
* HBase: region
* Bigtable: tablet
* Cassandra: vnode
* Couchbase: vBucket



Normally, parttions are defined in such a way that each piece of data (each record, row, or document) belongs to exactly one partion. The main reason for wanting to partition data is 'scalability'. Different partitions can be placed on different nodes in a shard-nothing cluster

Thus, a large dataset can be distributed across many disks, and the query load can be distributed across many processors.


We will first look at differnt approaches for partitioning large datasets and observe how the indexing of  data interacts with partitioning.

We will then talk about rebalancing, which is necessary if you want to add or remove nodes in your cluster.

Finally, we will get an overview of how database route request to the right partiion, and execute queries.


## Partitioning and replication

partition ususally combined with replication so that copies of  each parition are stored on mulitple nodes. even though each record belongs to exactly one partiion, it may still  be stored on muiltile different nodes, for fault tolerance.

a node may store more than one partition (逻辑分片?), take figure 6-1 as example


## Partitioning of kye-value data

Our goal with partioning is to spread the data and query load evenly across nodes. if every node takes a fair share, then 10 nodes should be hanlde 10 times as much data and 10 times the read, and write through put of a single node. (ignoring replication for now)

if the partition is unfair, so that some partitions have more data or queries than others, we call it "skewed" (倾斜的). The presence of skew makes partioning much less effetive. 

A partition with disproportionaley high load is called a "hot spot" (过热)

如果随机random distribute to all nodes, there's a disadvantage of that: when you try to read a particular item, you have no way of knowing which node it is on, so you have to query all noes in parallel (要query全部的node)

## partition by key range

One way of partitioning is to assign a continuous range of keys (from some minimum to some maximum) to each partition, like th volumnes of a paper encyclopedia figure 6-2

The range of keys are not necessarily evenly spaced, because your data may not be evenly distributed. 

The partition boundaries might be chosen manually by an administrator, or the database can choose them automatically (or how to rebalancing partitions)

within each partition, we can keep the keys in sorted order, which has the advantage that range scans are easy, and you can treat the key as a concatenated index in ordre t ofetch several related records in one query. 

However, the downside of key range partitioning is that certain access partterns can lead to hot spots. If the key is a timestamp, then the partition correspond to ranges of time. becase we write data from the same partition(the one for the day), so that partition can be overloaeded wit writes while others sit idle.

to avoid this problem, need to use something other than the timestamp as the first element of the key. for example, you could previs each timestmp with the sensor name, so that the partition is first by sensor name and then by time (然后根据sensor name 去partition (可以避免单点过热)), the write load will end up more evenly spread across the partitions. Now, when you want to fetch the vlaues of multiple sensors within a time range, you need to perform a separte range query for each sensor name. 

## partitioning by hash of key


because of the risk of skew and hot spots, many distributed datasstores use a hashfunction to detemrine the partition of a given key.



## Consistent Hashing (一致性哈希)

it is a way of evenly distributing load across an internet-wide system of caches such as a content delivery network(CDN)

it uses randomly chosen partiion bourdaries to aoid the nee for central control or distributed consensus. "Consistent" her descrives a particular approach to rebalancing

it is rarely used in practice ? becasuse this particular approach actually doesnt work very well for databases.




## skewed workloads and relieving hot spot

today, most data systems are not able to automatically compensate for such a highly skewed workload, so it's the responsibility of the application to reduce the kew. 


for now, you need to think through the trade-offs ofr your own appliation.

## partitioning and secondary indexes??

A seconday index usually doens't identity a record uniquely, but rather is a way of searching for occurrences of a particular value: find all actions by usre 123, find all articles contaiing the work hogwash, find all cars whose color is read and so on..
secondary indexes are the bread and butter of relational databases, and they are common in document databases too. many key value store (Hbase) have avoided secondary indexes becasue of thier added implmenttation complexity, but some have started adding them because they are so useful for data modeling. 

there are two main approaches to partitioning a database with secondary indexes: document-based partitioning and term-based partitioning

## partiioning secondary indexes by document ?

eg: figure 6-4, a website for selling used cars


secondary index on car color, then everything a red car is added to the database, the database partition automatically adds it to the list of docuemtnIds for the index entry "color:red"


in this indexing approach, each partition is completed separate: each partiion maintains its own secondary indexes, covering only hte documents in that partition. For this reason,
a document-parittioned index also know as "Local index" (as oppose to a global index,. which will be described in the next section)



con: you need to send query to all partitions, and combine all the results you get back.

This approach to querying a partitioned database is sometimes known as "scatter/gather", and it can make read queries on secondary indexes quite expensive. Even if query the partitions in parallel, scatter/gather is prone to tail latency amplication. Evertheless, it is widely use: MongoDB, Cassandra etc


it is recommended to design the partition scheme, so that secondary index queiers can be served from a single partiion, but that is not always possible, especially wheen you're using mulitple secondary indexes in a single query, 


## partitioning secondary indexes by Term

we can construct a "global index", that covers data in all partitions. However, we can't just sotre that index on one node, sinceit would likely become a bottleneck, and defeat the purpose of partiioning. 

a global index must also be partitioned, but it can be partitioned differenly from the primary key index.


example: figure 6-5

The name "term" comes from full-text indexes (a particular kind of secondary index). where the terms are all the works that occur in a document.

The advantage of a global (term-partitioned) index over a docuemnt-partitioned index is that it can make reads more efficient: rather than doing scatter/gather over all parittions, a client only neds to make a request to the partition containing the term that it wants.

However, the downsides of a global index is that writes are slower and more complicated, because a write to a single docuemtn may not affect mulitple partitions of the index (every term in the documetn might be on a differernt partition, on a differnt node)

In an ideal work, the idnex would always be up to date, and every document written to the database would immediately be reflected in the index. However, in a ter-partitioned index, that would require a districuted transaction across all partitions affected by a write, which is not supported in a databases 

In practice, update to global secondary indexes are often asynchrnous (that is if you read the index shortly after a write, the change you just make may not yet be reflected in the index (这不就是那个问题么)). for exmple, Amazon DynamoDB state that its global secondary indexes are updated within a fraction of a second in normal circumstances, but may exprience logner propagation delays in cases of faults in the infrastructure. 

## Rebalancing partitions (重新平衡)

over time, things change in a database

* the query throughput increases, so you want to add more CPUs to handle the load,
* the dataset size increases, so you want to add more disk and RAM to store it
* a machine fails, other machines need to take over the failed machine's responsibility


The process of moving load from one node in the cluster to another is called "rebalancing"

some minimium requirements:

* after rebalancing, the load should be shraed fairly between the nodes in the cluster
* while rebalancing is happening, the database shoudl ocntinue accepting reads and writes
* no more data than necessary shoudl be moreved between nodes, to make rebalancing fast  and to minimize the network and disk I/O load.

## Strategies for rebalancing 策略?


### hash mod N

The problem of this approach is that if the number of nodes N changes, most of the keys will need to be moved from 1 node to another.

we need an approach that doens't move data around more than necessary.


### fixed number of partitions

simple solution:

create many more partitions than there are noes, and assign several partitions to each node. eg: 10 noes, and split into 100 0 paritions. if a node is added to the cluster, the new node can steal a few partitions from every exsiting node, until partitions are fairly distributed once again. example: figure 6-6. 

(这个例子简单一点看,暂时先不考虑replica,那么这个的好处就很直接,obvious)

The nubmer of partitions does not change, nor does the assignment of keys to partition( hash 不变, key --> partition). This chagne of assignments is not immediate -- it takes some time to transfer a large amount of data over the network -- so that old assignment of partitions is used for any reads, and writes that happen, while the transfer is in progress... (不会有问题么)

In principle, you can even account for (弥补)  mismatched hardward in your cluster. By assigning more partitions to noes that aremore powerful, you can force those nodes to take a greater share of the load.

In this configuration, the number of partitions is usually fixed, when the database is first set up and not changed afterwards. although in principle it's possible to split and merge partitions 

you need to choose it high enough to accommmodate future growth. Howveer, each partition also has management overhead, so it is couterproductive to choose too high a number (任何的partition都会有overhead,也不能够选取太多)



If partitions are very large, rebalancing and recovery from node failures become expensive, but if partitions are too small, they incur too much overhead. The best performance is achieved when the size  of partitions is "just right", neighter too bigh nor too small, which can be hard to achieve, if the number of partitions is fixed but the dataset size varies.



### Dynamic partitioning (动态分片)

For database that use eky range partitioning, a fixed number of partitions with fixed boundaries owuld be very in-convenient. 

for that reason, key range-partitioned datbases such as HBase, create partitions dynamically.  when a partition gorws to exeeded a configured size (HBase, default is 10GB), it is split into 2 partitions so that approxiately half of the data ends up on each side of the split. conversely, if lots of data is delted and a prtition srhinks belowsome threshold, it can e merged with an adjacent partition. This process is similar to what happens at the top level of a B-tree


Each partition is assigned to a node, and each noe can handle mulitple partitions. after a large partition has been split, one of its two halves and be transferred to another node, in order to balance the load. In this case, the HBase, the transfer or partition files happens through HDFS, the udnerlying distributed filesystems.

However, a caveat is that an empty database starts off with a signle partition, since there is no a "priori" (没有用来可以参考的内容) information about where to draw the partition boundaries. while the dataset is small -- until it hits the point at which the first partition is split -- all write have to be processed by a single node, while the other noes sit idle. 

Solution: pre-splitting, initial set of partitions...



### partitioning proportionally to nodes (按照比例划分)

in other words: havea fixed number of partitions per node. In this case, the size of each partition grows proportionally to the dataset size, while the numberof nodes remains unchanged, but when you increase the nubmer of nodes, the partition becomes smaller again. since, a larger data volumne generally requires a larger nubmer of nodes t ostore, this approach also keeps the size of each partition fairly stable.

## Operations: automatic or manual rebalancing


some db: does it autuomatically, but reqruie an admin to commit it before it take effect


fully automated rebalancing can be convenient, because there is less oeprational work to do for normal maintaenance. However, it can be unpredictable. Rebalancing is an expensive operation, becasue it requires rerouting request and moving a large amount of data from one node to another. If it is not done creafully, this process can overload the network, and , or the nodes and harmd the performance of other requets whilet the rebalancing is in progress.


## Request routing (这个比较关键,partition完成以后,如何访问到他们?)

there is an instance of a more general problem called: "service discovery", 发现服务


FIGURE6-7 3 different ways of routing a request to the right node.



on a high level, there are a few differnt approaches to this problem 

1. alow clients to contact any node
2. send all reqeusts from clients to a routing tier first, which determines the ndoe that should bhanlde each reqeust and forwards it accordingly.  (acts like load balancing)
3. require that client be aware of the partitioning and the asignment of partitions to nodes. 


Many distributed data system reply on a separte coordination service such as zookeeper to keep track of this cluster metadata. as illustrated in firture 6-8


each node register itself in ZK, and ZK maintains the authoritative mapping of partitions to nodes, other actors, such as the routing tier or the partitioning-aware client, can subscribe to this information in ZK, whenever a partition changes ownership, or a node is added or removed, ZK will notify the routing tier, so that it can keep its routing information up to date. (ZK de watcher功能, 有点方便)

Eg: LInksedin's espresso uses Helix, which udnerline relies on ZK

Cassandra and Riak take a differnt approach, ehy se a "gossip protocol" among noedes  to disseminate any changes in the cluster state. Reqeust can be sent to any node, and node forward them to the appropriate nodes. This puts more omplexity in the database nodes, but avoid the depedency on an external coordination service such as ZK (but i prefer this approach)


## Parallel query execution (并发查询)

5

