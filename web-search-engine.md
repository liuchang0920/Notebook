

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
* design topi
