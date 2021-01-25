
# Advanced Search engine architecture and query processing

## Main tasks in a large search engine

* data acquisition (web crawling)
    * web crawling
    * refresh
    * data extraction
    * other data sources
* Data analysis (web mining)
    * page rank
    * spam detection
    * log and click-through analysis
    * index and crawl optimizations
* index buildling
    * index build and maintenance
* query processing
    * query analysis and rewriting
    * routing
    * tiering
    * execution
    * final ranking
    * snippet generation


## Index partitioning techniques

* local vs global index organization
* local index organization (also called horizontal)
    * each machine has subset of documents
    * build index on this subset
    * returns top-k results on this subset
    * query integrator mergers results from nodes

* Global index organization (also called vertical)
    * each machine has subset of the inverted lists
    * lists need to be transmited between nodes
    * network traffic needs to be minimized


## local vs global index organization

* global avoids broatcasting query to all nodes
* problem with global: sending long inverted lists (serveral MB for 100 M docs)
* updates require routing of postings

## Local index organization

* symmetrical and simple: every node just build its own search engine
* problem: every query requires some work by every node
* this is OK if lists are long
* but bad if lists are short especially if index is on HDD


* general principle in parallel computation: not a good idea to split a small amount of work among many machines (especially disk I/O)
* but in large search engines, theres' a lot of work, and we can split this onto hundreds machines and more with little overhead
large search engines use local index organizations (or hybrids)

## Parallel query processing summary
* global vs local index organization
* most engines use global or ybrids
* scaling and fault tolerance via replication
* but simple replication schemes do not work well
* problem 1: replicating machines not good approach to fault tolerance
* problem 2: mapping data directly onto machines also not a good idea


## Index sharding

少了一部分ppt..
