

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

## Typical operations in IR system

* indexing
* querying/ranking
* clustering: group docuemnts in sets of similar ones
* categorization: asign docuemnts to given set of categories
* citation analysis: find frequently cited or inflential papers


## Problems more typically addressed by NLP

* summarization: automatically create a summary
* machine translation: translate texte between languages
* info extraction/tagging: identitfy names of people, organizations

## Text index

* a data structure that for supporting IR queries
* most popular form: inverted index structure
* like index in a book (索引)

## Boolean query
..


## Web crawling

basic idea: 
* start a set of know URLs
* explore the web in "concentric circles" around theses URLs


## Traveral strategies:
* crawl will quickly spread all over the web
* load-balancing between servers
* in reality, more refined strategies (but still somewhat BFSish)
* many other strategies (focused crawls, recrals, site crawls)

## Details
* handling filetypes
* URL extensions and CGI scripts
* frames, imagemaps, basetags
* black holes (robot traps, spam bots)
* different names for same site (no perfect solution)
* duplicates, mirrors

performance consideration: later!

## Robot exclusion protocol

* file: robots.txt in the root directory
* allows webmaster to "exclude" crawlers (coralwers do not have to obey)
* may exclude only certain robots or certain parts of the site
* if at all possible, follow robot exclusion protocol


## Robot meta tags

* allow page owners to restrict access to pages
* does not require access to root directory
* exluce all robots
* not supported by all crawlers
* noindex, and nofollow

## Crawling courtesy

expected to be contacted..

## crawling chanllenges

* crawler may have to run for serveral weeks or months
* will interact with millions of web server
* unclear legal situation


## Storage system options: (for pages)

* storage pages in standard DBMS (不要这么做)

* use file systems
  * many pages per file
  * done, by internet archive
* use specialzied storage system
  * hash-partitioned or range -partitioned
  * GFS+ big table, Hbase hadoop, Dynamo, Cassandra etc
* operations: read, append, or scan many pages
* heavy use of SSDs in data center

## Indexing

* how to build an index
  * in I/O efficient manner
  * inparallel
* closely related to I/O efficient sorting
* also, how to compress an index (ideally while building it)

## Basic indexing concepts and choices
* lexicon: set of all "words" encountered (词典)
* for each word occurrence: store index of docuemnt where it occurs
* also store position in document? (probably yes)
  * increasees space for index significantly
  * allows eficient search for phrases
  * relative positions of words may be important for ranking (how to do re-rank ???)
* also store additional context ? (in title, bold, in anchrotext?)
* store works: is, a the..
* ignore stop words? (maybe better not)
  * save space in index
  * cannot search for "to be or not to be." kind long words...
  * quereis with stop words expensive
* stemming: runs == run == running

## Indexing (simplified approach)

1. scan through all documents
2. for every work encountered generate entry (word, doc#, pos)
3. for entries by (word, doc#, pos)
4. now transform into final form


## Boolean queries vs ranking


## 7. Link-Based Ranking Techniques


A page that is highly referenced is often better or more important


