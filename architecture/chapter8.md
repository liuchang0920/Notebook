

# Chapter 8. componenet based thinking

most languages support pyhsical packing as well:

Jar - java
dll - .NET
gem - Ruby


## Component scope


### Library
A simple wrapper is often called a library, which tends to run in the same memory addres as the calling code and communicate via language funtion call mechanisms. Libraries are usually compile -time dependnecies (with notable exceptions like dynamic link libraries)

### Service
Another type of component is: Service, tends to run on its own addres space and communicates via low-level netowrking protocols like TCP/IP or higher-levle formats like REST or message queues, forming stand-alone, deployable units in architectures like microservices.

Nothing requires  an architect to use components - it just so happens that it's often useful to have a high level of modularity than the lowerest level offered by the language.


In Microservices architectures, simplicity is one of the architectural principles. Tus a service may consist of enough code to warrant components or may be simple enought to just contain a ssmall bit of code

## Architect role


Typiecally, the architect defines, refines, manages, and governs components within an architecture.

software architecs, in collaboration with business analysts, subject matter experts, developers, QA engineers, operations, and enterprise architects, create the initial design for software, incorportaing the architecture characterstics, and the requirements for the software systems.

An architect must identify components as one of the first tasks on a new project (如何组件). but before an architect can identify components, they must know how to partition the architecture. (如何分片？ 划分)



## Architecture partitioning

The first law of software architecture states that everthing in software is about trade-off.



## Case study: sillicon sandwiches: partitioning


Design focus on domains (workflows)

* purchase
* promotion
* make order
* manage inverntory
* recipes
* delivery
* location

### Domain partitioning
...

## Developer role 

Devellpers typically take components, jointly designed with the architect role, and further subdivide them into classes, functions or subcompoennts. 

In general, class and function design is the shared responsibiliyt or archiects, tech leads, and developers, with the lions's share going to developer roles.

Developers should never take componenets designed by architectus as the last word; all software design benefits from iteration (也就是说不一一定是对的)
Rather, thta initial design should be viewed as a first draft, where implementation will reveal more details and refinedments

## Component identitification flow
...


## Identifying initial components
before any code exists for a software project, the architect must somehow determine whwat top-level components to beign with, based on what type of top-level partitioning they choose.
Outside that, an architect has the freedoom to make up whatever componenets they want, then map domain functionality to them to see where behavior should reside.
While this may sound arbitrary, it's hard to  start with anything more concrete if an architect designs a system from scratch.

The likelyhood of achieving a good design from this initial set of components is disparagingly small, which is why architects much iterate on component design to improve it.


## Assign requirements to componenets



