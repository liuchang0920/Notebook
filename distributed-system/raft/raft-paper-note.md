


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

* In the common case, a command can complete as soon as a majority of the clusters has responded to a single round of remote procedure calls, a minority of slow servers need not impact overall system performance



## 3. what is wrong with Paxos 

Paxos has been the nost synnonoymouse with consensus. Its correctnes has been proven, and it is efficient in the normal case

unfortunrately, paxos has 2 significant drawbacks.

1. exceptinally difficult to understand
2. Paxos does not provide a good foundation for building practical implementations. there's no widely aggreed-upon algorithm for multi-paxos. And this descriptions are mostly about single-decress Paxos.


As a result, practical systems bear little resemblance to Paxos.

## 4. Designing for understandability

goals for Raft:

1. must provide a compllete and practical foundation for system building. in order to reduce design work required for developers.

2. safe under all conditions and available under typical operating conditions.

3. understandability. Must be possible for a large audience to understand the algorithm comfortably. In addition, develop intuitiions about the algorithm, so that system builders can make extendions that are inevitable in real-work implementtation.



Mainly 2 techics used for developing Raft:

1. divide and conquer, decomposition

2. simplify the state space by reducing the # of state to consider, making the system more coherent and eliminating non-determinism where possible.

** specifically, logs are not allowed to have holes, and Raft limits the way in which logs can become inconsistent with each other.

we used randomization of simplify the Raft leader election algorithm.

## 5. The Raft consensus algorithm

Raft is an algorithm for managing a replicated log of the form described in section2. 

Raft implements consensus by first electin a distinguished 'leader', and then giving the leader complete responsibility for managing the replicated log. The leader accepts log entries from clients, replicates them on other servers, and tells servers when it is safe to apply log entries to their state machines. Having a leader simplifies the management of the replicated log. Eg: the leader can decide where to place new entries in hte log without consulting other servers, and data flows in a simple fashion from the leader to other servers. A leader can fila or become disconnected from the other servers, in which case a new leader is elected.


Given the leader approach, Raft decompose the consensus problem into 3 relatively independent subproblems, which are discussed in the sub section that follow:

* leader election: a new leader must be chosen when an existing leader fails

* log replication: the leader must accept log entries from clients and replicate them accoss the cluster, forcing the other logs to agree with its own.

* safety: The safety property is State Machine Safety property. The solution involves an additional restriction on the election mechanism.

### 5.1 Raft basics

Raft cluster contains several servers; 5 is a typical number, which allows the system to tolerate 2 failures. 

At any given time, each server is in one of 3 states:
1. Leader, 2. follower, 3. candidate.


Followers are passive: they issue no request on their own but simply respond to request from leaders and candidates. 

Leader handles all client requests (if a client contact a follower, the follower redirects it to the leader). The 3rd state, candidate, is used to elect a new leader.

Raft divies time into terms of arbitrary length. (任期). Terms are numbered with consecutive integers.


If a candidate wins the election, then it serves as leader for the rest of the term. in some situation, an election will result in a split vote. In this case the term will end with no leader; a new ter (with a new election) will begin shortly. Raft ensures that there's at most 1 leader in a given term.

Diferent servers may observe the transition between terms at different times, and in some situations a server may not observe an election, or even entire terms. Terms act as a logic clock in Raft, and they allow servers to detect obsolete information such as stale leaders. Each server store a current term number, which increase monotonically over time. Current terms are exchanged whenever servers communicate; if one server's current term is smaller than the other's then it updates its current term to the larger value. If a candidate or leader discovers that its terms is out of date, it immediately reverts tot folower state. If a server receives a request with a stale term number, it rejects the request also.

Raft servers communicate using remote prodedure calls (RPC calls) 为什么别人做完的事情，就都能记住，你怎么就能忘记了。

and the basic consensus algorithm requres only 2 types of RPCs, **RequestVote RPC** are initiated by candidates during elections, and **AppendEntries RPCs**  are initiated by leaders to replicate log entries and to provide a form of heartbeat. 

Servers retry RPCs if they do not receive a response in a timely manner, and they issue RPCs in parallel for best performance.

### 5.2 Leader election

领导选举
Raft uses a heartbeat mechanism to trigger leader election. When servers start up, they begin as followers. A server remains in follower state as long as it receives valid RPCs from a leader or candidate. Leaders send periodic heartbeats(AppendEntries RPCs that carr no log entries) to all followers in order to maintain their authority. If a follower receives no communication over a period of time called **election timeout**, then it assumes there's no viable leader and begins an election to choose a new leader.

To begin an election, a follower increments its current term and transitions to candidate state. It then votes for itself and issues RequestVoteRPC in parallel to each of the other servers in the cluster. A candidate continues in this state until 1 of 3 things happens: a. it wins the election b. another server established itself as a leader, or c. a period of time goes by with no winner. These outcomese are discussed separated in the paragraphs below.

a candidate wins an election if it receives votes from a majority of the servers in the full cluster for the same term. Each server will vote for at most one candidate in a given term, on a first-come-first-serve basis. The majority rule ensures that at most one candidate can win the election for a particular term. Once a candidate wins an election, it becomes leader. It then sends heartbeat messages to all of the other servers to establish its authority and prevent new elections.

While waiting for votes, a candidate may receive an AppendEntries RPC from another server claiming to be leader. If the leader's term(included in its RPC) is at least as large as the candidate's current term, then the candidate recognize the leaderas legitimate and returns to follower state. If the term in the RPC is smaller than the candidate's current term, then the candidate rejects the RPCC and cotinues in the candidate state (过时的leader信息)

The third possible outcome is that a candidate neither wins nor loses the election: if many followers become candidates at the same time, votes could be split so that no candidate obtain a majority. When this happens, each candidate will time out and start a new election by incrementing its term and initiating another round of RequestVote RPCs. However, without extra measures split botes could repeat indefinitely.


Raft uses randomized election timeouts to ensure that split votes are rare, and that they are resolved quickly. To prevent split votes in the first palce, election timeouts are chosen randomly from a fixed interval(150-300ms)

This spreads out  the servers so that in most cases only a single server will timeout; it wins the election and sends heartbeats before any other servers time out. The same mechanism is used to handle split votes. Each candidate restarts its randomized election timeout at the start of an election, and it waits for that timeout to elapse before starting the next election; this reduces the likelihood of another split vote in the new election. 

Elections are an example of how understandability guided our chose between design alternatives. Initially, we planned to use a ranking system: each candidate was assigned a unique rank, which was used to select between competing candidates. If a candidate discovered another candidate with higher rank, it would return to follower state so that the higher rank, it would return to folower state so that the higher ranking candidate coiuld more easily win the next election. We found that this approach created subtle issue around availability ( a lower -ranked server might need to time out and become a candidate again if a higher-ranked server fails, but if it does so too soon, it can reset progress towards electing a leader).

We made adjustments to the algorithm serveral times, but after each adjustment new corner cases appeared. Eventually we concluded that the randomized retry approach is more obvious and understandable.

### 5.3 Log replication 

日志备份

Once a leader has been elected, it begins servicing client requests. Each client request contains a command to be executed by the replicated state machines. The leader appends the command to its log as a new entry, then issues AppendEntries RPCs in parallel to each of the other servers to replicate the entry. When the entry has been safely replicated(as described below), the leader applies the entry to its state machine, and returns the rsult of that execution to the client. (同步好以后，再写入状态机，然后返回给client端). If followers crash or run slowly, of if network package are lost, the leader retries AppendEntries RPC indefinitely(even after it has responded to the client) until all followers eventually store all log entries. （应该是为了eventual consistency, 最终每一个节点的内容应该是一致的）

Logs are organizaed as show in Figure 6. Each log entry stores a state machine command along with the term number when the entry was received by the leader. The term number s in log entries are used to detec inconsistencies between logs and to ensure some of the properties in Figure3. Each log entry also has an integer index identifying its position in the log. 

The leader decides when it is safe to apply a log entry to the state machines; such an entry is called **commited**, Raft guanrantees that committed entries are durable and will eventually be executed by all of the available state machines. A log entry is committed once the leader that created the entry has repliaced it on a majority of the servers. This also commits all preceding entries in the leader's log, including entries created by previous leaders. 

Leader keeps track of the highest index it knows to be committed, and it includes that index in future AppendEntries RPCs(including heartbeats) so that the other servers eventually find out. Once a follower learns that log entry is commited, it applies the entry to its local state machine (in log order).

We design the Raft log mechanism to maintain a high level of coherency between the logs on different servers. Not only does this simplify the system's behavior, an dmake it more predictable, but it is an important component of ensuring safety. raft maintains the following properties, which together constitute the log matching property in Figure 3:

* if 2 entries in differnt logs have the same index and term, then they store the same command
* if 2 entries in different logs have the same index and term, then the logs are identical in all preceding entries.

The first property follow from the fact that a leader creates at most 1 entry with a given log index, in a given term, and log entries never change their position in the log. The second property is guanranteed by a simple consistency check performed by AppendEntries. When sending an AppendEntries RPC, the leader incudes the index and term of the entry in its log that immediately precedes the new entries. If the follower does not find an entry in its log with the same index and term, then if refuses the new entries. []  

