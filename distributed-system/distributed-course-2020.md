

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



# Lecture 4


### GFS

* big, fast
* global
* sharding
* automatic recovery

Single data center 
Internal use
Big sequencial
