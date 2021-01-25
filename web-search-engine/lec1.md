

# Lec1

basic structure of a search engine

crawler -> disks -> indexing (analysis/minig) -> Index   <- search interface (query processing) <- customer inpu query


**4 major components**
* data acquisition/ web crawling
  * to collect pages from all over the web
  * messy process wit lots of hand tuning
* data analysis / web mining
  * link analysis, spam detection, query log analysis
  * usin map reduce or similar specialized platforms
* index building
* query processing


most of the cycles spent in data analysis and query processing



## Ranking
* return best pages first
* term- vs link- vs click-based approaches
* machine-learned ranking


## Main challenges for search engines

* coverage (need to cover large part of the web)
* good ranking (cases of braod and narrow queries)
* freshness (nee t update content)
* user load (>50000 queries on massive data)
* manipulation (sites wnat to be listed first)
* plus monetiation, personalization, localization

## Topic hierarchy

Chalenges:
* design topiic
* automatic classification
* compare to libarry classification

## Specialized search engines
* be the best on one particular topic (vertical search 垂直搜索？？)
* use domain-speicfic knowledge and structure
* limited resources -> do not crawl the entire web
* focused craling techniques, or meta search


## Meta search engines
* use other search engines to answer questions
* ask the right specialized search engine
* combine results from serveral large engines
* may need to be "familiar" with thousands of engines
* or just rerank/enrish results from a few
* ...but not clear this works

## Personal search assistants

* embedded into browser or desktop
* could suggest "related page"
* search by "highlighting text" -> can use context
* could exploit individual browsing and desktop behavior
* may collect and aggregate browsing information (privacy issues)
* usually work on top of large search engines (google, bing)


## Information retrieval (IR)


。。。

## Structured vs unstructured data

* IR: lesser known cousin of field of Databases
* datbasease: focus on structured data
* IR: nstructured data: "documents"
* unstructured data is actuallu not really unstructured
* IR focused on human user
* challenges: semistructured data, DB/IR gap, buildling on top of IR

## Evaluation in IR: precision vs recall

补一下吧。。 都忘了。。

