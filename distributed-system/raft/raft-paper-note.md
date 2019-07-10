


## Overview


Raft is similar in many ways to existing consensus algoritms

* strong leader:
    * log entries only flow through from leader to other services (simplifies the management of replicate log)

* leader election:
    * use randomized timer to elect leader

* Membership changes:
    * uses a 'joint consesus' approachm, allows cluster to ocntinue operating normally during configuration changes



We believe that Raft is superior to Paxos and other consensus algorithm.


The paper structure:

* section 2: Replicated state machine problem
* section 3: the strengths and weakness of Paxos
* section 4: describe general approach to unstandability
* section 5-8: Represent raft
* section 9: evaluate raft
* section 10: related work

## 2 replicated state machine

备份状态机

state machines on a collection of server compute idential copies of the same state, and can continue operating even if some of the servers are down.

are used to solve variety fault tolerant problems in distributed systems.

example of Replicated state machines: Chubby, Zookeeper

Keep the replicated log consistent is the job of the consensus algorithm. Once commands are properly replicated, each server's state machine processes them in the log order, and the outputs are returned to clients. As a result, the servers apper to form a single, highly reliable state machine.


Consensus algorihms for practical system typically have the following properties:

* They ensure safety under all non-Byzantine conditions (includes: network delays, partitions, and packet loss, duplication, and reordering)
* Fully functional(available) as long as any majority of the servers are operational and can communicate with eatch other and with clients. Thus, a typical cluster of 5 severs can tolerate the failure of any 2 servers

* they do not depend on timing to ensure the consistency of the logs

