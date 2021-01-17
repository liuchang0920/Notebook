

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

once an architect has idenitfied initial components, the next step aligns requirements (or user stories) to those components to see how well they fit. This may entail（使必须） creating new components, consolicating exisitng ones, or breaking components aprt because they have too much responsbility. This mapping doesn't have to be exact -- the architect is attempting to find a good coarse-grained substrate to allow further design and refinement by architects, tech leads, and/or developers

## Analyze roles and responsibilities

when assigning stories to components, the architect also looks at the roles and responsbilities elucidated(已经阐明) during the requirements to make sure tha the granulrity matches. thinking about both the role and behaviors the applicat must support allow the architect to align the component and domain granularity. One of the greatest challenges for architects entails discovering the correct granularity for componenets, which encourages the iterative approach described here.


## Analyze architecture characterstics

when assigning requirements to components, the architect should also look at the architecture characterstics discovered earlier in order to think about how they might impact component division and granularity. For example, while 2 parts of a systme might deal with user input, the part that deals with hundreds of concurrent users will need different architecture characteristics than another part that needs to support only a few. Thus, while a purely functional view of component design might yield a single component to handle user interaction, analyzing the architecture characterstics will lead to a subdivision.

## Restructure components

feedback is critical in software design. Thus, architects must continually iterate their component ddsign with developers.


## Component granularity

finding the proper granularity for componenets in one of an architect's most difficult tasks. Too fine-grained a component desig nleads to too much communication between components to achieve this.

Too coarse-grained components encourage high internal coupling, which leads  to difficulties to deployability and testability. as well as modularity-related negative side effects.

## Component design

no accepted "correct" wa exists to design components. rather, a wide variety of techniques exists, all with vaiours trade-offs. In all processes, an architect takes requirements and tries to determine what coarse-grained building blocks will make up the application. Lots of different techniques exist, all with varying trade-offs and coupled to the software development process used by the team and organization.

Here, we talk about a few general wyas to discover components and traps to avoid.

## Discovering components

Architects, often in collboration wiht other roles such as developers, business ayanlysts, and subject matter experts, create an initial component design based on general knwoledge of the system and how they choose to decompose it, based on technical or domain partitioning. The team goal si an initila design that parttitions the problem space into coarse chunks that take into account differing architecture characterstics.

## Entity trap

eg, the architect has basically taken each entity idenitfied in the requirements and made a Manager component baed on that entity. This isn't an architecture; it's a component-relational mapping of a framework to a database. 


in other words, if a system only needs simple database CRUD operations (create, read, update, delete), then the architect ca ndownlaod a framework to create user interfaces directly from the database.

* naked objects and similar framworks



Rather, this anti-pattern generally indicates lack of thought about the actual workflow of the application. Components created with the entity trap also tend to be too coarse-grained, offering no guidance whatsoever to the development team in terms of the packaging and overall structuring of the source code.


## Actor/Actions approach

architects identify actors who perform activities with the application and the actions those actor may perform. It provides a technique for discovering the typical users of the system and what kinds of things they might do with the system.

The actor/actions approach became popular in conjunction with particular software development processes, especially more formal processese tat works well when the requirements feature distinct roles and the kinds of actions they can perform. This style of component decomposition works well for all types of systmes, monolithic or distributed.

## Event storming

In event storming, the architect assumes the project will use messages and/or events to communicate between the various components.

To that end, the team tries to determine which events occur in the system based on the requirements and identified roles, and build components around those even and message hanlders （听着比较make sense啊）

This works well in distributed architectures like microservices that uses events and messages, because it helps architects define the message used in the eventual system.

## Workflow approach 

an alternative to event storming offers a more generic appraoch for architects not using DDD or messaging. The workflow apporach models the components around workflows, mucjh like event storming, but without the explicit constraints of building a message-based system. A workflow approach identitfies they key roles, determines the kinds of workflows theses roles engage in, and builds components around the idenitified activieites.

Non of these techniques is superior to the others; all offer a different set of trade-offs. If a team uses a waterfall approahc or other older sotfware development processes, they might prefere the Actor/Actions approach because it is general. When using DDD and corresponding architectures like micorservices, event storming matches the software development process exactly.



## Case study: going, going, gone; discovering components

* Bidder
  * iew live videl stream, view live bid stream place a bid
* auctioneer
  * enter live bids into sysmte, receive online bids, mark item as sold
* system
  * start auction
  * make payment
  * track bidder activity


then we have the following solution:

Todo


