
# Advanced Web crawling

## Topic

* high performance crawling systems
* targeted/focused crawling
* recrawling
* random walks

## 2 basic components of the crawler

* Crawling application
* crawling system

## System vs strategy

* 2 components
* crawling application implements crawling strategy
* more or less integrated based on 
    * complexity of crawling strategy
    * degree of agility/ maneuverability required
* example 1: crawling and recrawling in a large engine:
    * use map-reduce jobs in DA to determine what to crawl next
    * send files with millions of URLs to crawling system
* example 2: small focused crawler
    * may decide what to crawl next based on last few pages

## Scaling Network and I/O


..

## High-performance crawling systems

* Industry
    * google bot and crawlers fro other large engine
    * crawlers to monitor the web
* Research projects
    * mercator/atrax ??????

## Focused Crawling

* problem: crawl only certain types of pages
* how to specify a topic: classifier, maybe a query
* how to evaluate performance: harvest rate ???? 
* how to decide what to crawl next:
    * a machine-learning problem
    * crawler can learn "on the job"
    * assumption: after crawling, we know if a page is relevant


## Evaluating a focused crawler

* harvest rate: num of relevant pages/ number crawled
* start pages should be relevant if possible
* Unfocused (BFS) will soon lose focus
* focuses crawlers should maintain ahigh harvest rate
* Greedy may not be best


## Recrawling strategies (怎么维护更新 好像当时没答好)

* Problem: VFS only good for the initial crawl
* afterwards: need to maintain index more efficiently
* some pages change more frequently than others
* some pages are more important than others
* some changes are more significant than others
* also, discover new pages, not just changes ones
* simplified problems: given a limited amount of crawl resources, try to maximize freshness of the index
* no weights, no new pages, no significance model (?）


## Estimating change probabilities

* suppose you have crawled a page n times
* sometimes it changed, sometimes it did not
* match to a poisson process model 

这个没讲清楚，不过确实怎么recrawl确实是一个有意思的topic...





