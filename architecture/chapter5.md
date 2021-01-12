
# Chapter 5. Identifying architectural characterstics

## Extracting architecture characterstics from Domain concerns

a common anti-pattern in architecture entails trying to design a generic architecture, one that suports all the architecture characterstics. Each architecture characterstic the architecture supports complicates the overall system design;
supporting too many architecture charactestics lead to greater and greater complexity before the architect and developers have even started addressing the problem domain, the original motivation for writing the software. don't obsess over the number of characterstics, but rather the motivation to keep design simple.

## Extracting architecture characterstics from requirements
....

## Case study: silicon sandwiches

* Description
  * a national sandich stop wnat to enable online ordering (in additional to its current call-in service)
* Users
  * thousands, perhaps one day millions
* requirements
  * Users will place their order, then be give a time to pick up their sandwich adn directions to the shop 9whihc must integrate with serveral external mapping services that include traffic information)
  * if the shop offers a delivery service, dispatch the driver with the sandwich to the user
  * Mobile-device accessibility
  * offer national daily promotions/specials
  * offer local daily promotions/specials
  * accept payment online, in person, or upon delivery
* additional context
  * sandwich shops are franchised, each with a different owner, 
  * parent company has near-future place to expand overseas
  * coporate goal si to hire inexpensitve labor to maximize profit


First, separate the candidate architecture characterstics into explicit and implicit characterstics


## Explicit chracteristics

eg: a shopping website may aspire to suport a particular number of concurrent usres, which domain analysits specify i nthe requirement. An architect should consider each part of the requiremtns to see if it contributes to an architecture characterstic. But first, an architect should consider domain-level predictions about expected metrics, as reprepsentied in the Users section of the keata.

Architects must often decode domain language into engineering equivalents.

However, we also probably need to elasticity -- the ability to handle bursts or requests. These 2 characterstics often appear lumped toghether. But they have differnt constratins. Scalability looks lke the graph 

some systems are scalable but not elastic.

。。。

we also want to define performance number in conjunction wiht scalability number. In other workds, we must establish a base line of performance without particular scale, as well as determin what an accptable level of perforance is given a cerntain number of users. Quite often ,architecture charactesrtics interact with one another, forcing architects to define them in relation to one another.


## Implicit characteritiscs

many architecture charactesrtics aren't specificed in requiremnt in documents, yet they make up an important aspect of the design. One implicit architecture characterstic the system might want to suppport is avialbility: making sure using can access the andwich site.
closely to availability is reliabiliyt; making sure the site stays up druing interfactions - no one wnat to purchase form a site  that continues dropping connections, foring them to login again.


**Security** appears as an implicit characterstic in every system: no one want to creat insecure software. However, it may be prioritized depending on criticality, which illlustrates the interlocking nature of our definition. ar architect consider security an architecture characterstic if it influences some structural aspect of the design and is critical or important to the application.


the last major architecture characteristics for silicon sandwich is customizability. 



> There are no wrong answers in architecture, only expensive ones.









