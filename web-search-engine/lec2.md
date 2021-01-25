
# Disk and I/O efficient index buildling

## Memory hierarchy


volatile: cpu, cache, main memory
non-volatile: disk, tape

## Disk Model

* max transfer rate: per rotation, all data that fits on one track


cost = seek + rotation latency + transfer cost

## Disk performance modeling



....


## I/O efficient sorting (有效率的排序)



sorting needed in many IR and DB scenarios

* inverted index construction
* output in sorted order
* sort - based join
* offline B-tree index construction
* duplicate elimination
* group by
* pagerank ??


## I/O - efficient sorting

* data may not fit in main memory
* many algorithms will be inefficient if data on disk
* most popular I/O Efficient method: merge sort


d way merge: need d input buffers and 1 output buffer


* files now sorted in ascending order (left to right)
* note: heap-based merge makes pass from left to write
* if output buffer is full, write to disk; append to the output file
* if input buffer is empty, read next chunk of data from that file

larger d: fewer passes but smaller buffers, thus slower disk I/O


## Choose d:

* not too small (few passes)
* not too large (fast disk access)
* typically 1 or 2 passes for current machines


## Inverted index creation

4 basic methods

* linked list (bad)
* merge-sort
* merging subindexes
* lexicon partition (as in Google paper)

## Problem definition: Input

raw input data (html files..)

## Problem definition: Output

* inverted index
    * with inverted lists containing posting
* term lexicon
    * for each term, info about start in index, term stats
* Page/URL table
    * for each documenet, info about size, url/docID



