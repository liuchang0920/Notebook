

# Lecture 1


特征

* parallism * 
* fault tolerant * 
* physical
* security/isolated


难点
* concurrent
* partial failures
* performance

Fault tolerance
* availability
* recoverability

NV Storage (non vault storage)
* Replication


Topic - consistency
* put(k, v)
* get(k) -> v

* lots of versions of the key replicas



...

# Lecture 2


## Golang


### Threads


locking:


Coordination: there are times you intentionally want different threads to interact/wait for each other


* channels
* sync.cond
* waitGroup (coutDown latch? java, wait for a bunch of go routines to finish)



Deadlock

# Lecture 3

GFS

## Why hard?

* performance -> sharding
* faults -> tolerance
* tolerance -> replication
* replication -> inconsistency
* consistency -> low performance

### Bad replication design

S1, S2 (key, value pairs tables)




## GFS

* big, fast
* global
* sharding
* automatic recovery

Single data center 
Internal use
Big sequencial


### master data

filename -> array of chunk handles
handle -> list of chunk servers, version # for each chunk, primary, lease expiration (stores the information both in RAM and disk (log, checkpoint))



### Read

1. name, offset -> stores to Master
2. master sends Chunk handle, list of Servers, (clients caches the result)
3. client talks to one of the chunk servers



### Writes







# Lecture 4


what state?
P/B sync
cut over
Anomalies

`

...


# Lecture 9 ZK and CRAQ

Motivation to use ZooKeeper
* test and set 
* configration information
* Master Election

ZK API looks like a file system


## Znode

Types
* Regular
* Ephemeral (heart beat check on slave/worker machines)
* Sequential


## API

* Create(Path, Data, Flag) 
  * (Exclusive)
* Delete(Path, Version)
* Exists(Path, Watch)
  * ZK guarantee the client will be notified when the file path is created when Watch flag is set to true
* GetData(Path, Watch)
* SetData(Path, Data, Version)
*  


