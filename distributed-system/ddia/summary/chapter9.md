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

