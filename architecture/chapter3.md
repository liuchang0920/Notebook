
# Chapter 3. Modularity

## Definition

we use modularity to describe a logical grouping of related code, which could be a group of classes in an object-oriented lagnauge or functions in a structured of funtional launge.

eg: java package: `com.mucompany.customer` package should contain things related to customers.


### Modular reuse before classes

...

it is worth noting the general concept for namespace, separte fro mthe technical implementation in the .NET platform.

Developers often need precise, fully qualified names for software assets to separate differetn software assets (componenets, classes, and so on) from each other.

To solve naming conflicts, java was to create the `package` namespace mechanism, along with the requirement that the physical directory structure just mastch the package name.
eg: java package: `com.mucompany.customer` package should contain things related to customers.




## Measuring modularity

key concepts: conhesion, coupling, and connascence (团结，伴生)


## Cohesion (凝聚)


Cohesion refers to what extenet the parts of a module should be contianed within the sme module. In other words, it is a measure of how related the parts are to one another. Ideally, a cohesive module is one where all the parts should be packaged together, because breaking them into smaller pieces wuold require coupling the parts together via calls between modules to achieve useful results.

> attemping to divide a cohesive module would only result in increatese coupleing and decreased readability.

eg:


* functional cohesion
* sequential cohesion
* communicational cohesion
* procedural cohesion
* temporal cohesion
* logical cohesion
* coincidental cohesion

..

## Coupling

## Abstractness, instability, and distance fro mthe main sequence


## Connascence

## Static connanscence

refers to code level coupling


## Dynamic connascence

## connascnence properties

...


## From modules to components

we'll discuss deriving compontents from prblem domains in Chapter 8, but we must first dicsuss another funcamental aspect of software architecture: architecture characterstics and their scope.




