

# Chapter 1 Introduction

architecture is about the important stuff... whatever it is..


Readers should keep in mind that all architectures are a product of their context.

## Defining software architecture



## Expectation of an architect

Defining the role of a software architecture presents as much difficulty as defining software architecture. it can range from expert programmer up to defning the strategic technical direction for the company. Rather than wate time on the fool's errand of defnine the role, we recommend focusing on the expectations of an architect.

8 core expectations places on a software architect, irrespective of any give role, title, or job description:

* make architecture decisions
* continually analyze the architecture
* keep current with the latest trends
* ensure compliance with decisions
* diverse exposure and experience
* have business domain knowledge
* possess interpersonal skills
* understand and navigate politics

The first key to effectiveness and success in the software architect role depends on understanding and practicing each of these expectations.

## Make Architecture Decisions

An architect is expected to define the architecture decisions and design principles used to guid technology decisions within the team, the department, or across the enterprise.

`Guide` is the key operative word in this first expectation. An architect should guide rather than specity technology choices.

eg: chosse React, it is rather a technical decision rather than an architectural decision, or design principle to help the development team make choices. An architect should instead should instruct development teams to use a 'reactive-based' framework for frontend web development, hence guiding to choose between a wide range of frameworks.

guiding technology choices through architecture decision and design principles is difficult. The key ..

That said, and architect on occiasion might need to make specific technology decisions in order to preserve a particular architectural characterstic such as scalability, performance, or availability. In this case it would be still considered an architectural decision, even though it speicifies a particular technology. Architects often struggle with finding the correct line

## Continually analyze the architecture

An architect is expected to continually analyze the architecture and current technology environment and then recommend solutions for improvement.

## Keep current with latest trends

an architect is expected to keep current with the latest technology they use on a daily basis to remain releveant (and to retain a job!). An architect has an even more critical requirement to keep current on the latest technical and industry trends. The decision an architect make tend to be long-lasting and difficult to change. Understanding and following the long-lasting and difficult to change. understanding and following key trends helps the architect prepare for the future and make the correct decision.

Tracking trends and keeping current with those trends is hard, particularly for a software architect. (see chapter 24)


## Ensure compliance with decisions

an architect is expected to ensure compliance with architecture decisions and deisgn principles

## Diverse exposure and experience

an architect is expected to have exposure to multiple and diverse technologies, frameworks, platforms, and environments

This does not mean an architect must be an expert in every framework, platform, and language, but rather that an architect must at least be familiar with a variety of technologies. Most environments these days are heterogeneous, and at a minimum an architect should kenow how to interface with multiple systems and services, irrespective of the language, platformt, and technology those systems or services are written in.

One of the best ways of mastering this expectation is for the architect ot stretch their comfort zone. focusing only on a single technology or platform is a safe haven. An effective softwrae architect should be aggressive in seeking out opportunities to gain experience in multiple languages, platforms, and technologies. A good way of masteringthis expectation is to focus on techinical breadth rather than techinical depth. Technical breadth includes the stuff you know about, but not at a detailed level, combined with the stuff you know a lot about. For example: it is far morevaluable for an architect to be familiar with 10 different caching products and the associate pros and cons of each rather than to be an expert in only 1 of them (确实，要花额外的时间)


## Have business Domain knowledge

an architect is expected to have a certain level of business domain expertise (至少某个领域是专家。。)

The most successful architects we know are thoses who have broad, hands-on technical knowledge coupled with a strong knowledge of a particular domain. these software architectes are able to effectively communicate with C-level executives and business users using the domai nknwoledge and langueage that theses stakeholders know and understand. This in turn creates a strong level of confidence that the software architect knows waht they are doing and is competent to create an correct architect.

## Possese interpersonal skills

an architect is expected to possses exceptional interpersonal skills, includign teamwork, facilitation, and leadership.

having exceptional leadership and interpersonal skills is a diffisult expectation for most developers and architects. they like to solve problems, not people problems."no matter what they tell you, it's always a people problem"
an architect is not only expected to provide technical guidance to the team, but is also expected to lead the development teams through the implementation of the architecture.  Leadership skills are at least half of the role or title the architect has.

The industry is flooded with software architects, all competing for a limite number of architecture positions. Having strong leadership and interpersonal skills is a goodway for an architect to differentiate themselves from other architects and stand out from the crowd. We've know many software architects who are excellent technologiest but are in-effective architects due to the inability to lead treams, coaach and mentor developers, and effectively communicate ideas and architecture decisions, and principles. Needless to say, those architects ahve difficulties holding a position or job.

## Understand and havigate politics

an architect is expected to understand the political climate of the enterprise and be able to nagivate the politics (能够呼风唤雨，左右风向)

...

The main point is that almost every decision an architect makes will be challenged (要能够stand for himself). Architectural decisions will be challenged by product owners, project managers, and business stakeholders doe to increated costs or increatse effort (time) involved. Architectual decisions will also be challenged by developers who feel their approcah is better. In either case, the architect must navigate the politics of the company and apply basic negotiation skills to get most decisions approved. This fact can be very frustrating to a software architet, because most decisions makde sa a developet did not require approval or even a reveiw. Programming aspects such as code structure, class design, design pattern selection, and sometimes even language chose are all part of the art of programming. However, an architect , now able to finally be able to make broad and impoartant decisions, must justify and fight for almost every one of these decisions. Negotiation skills, like leadership skills ,are so critical and necessary that we've dedicated an entire chapter in the boo kto undrstanding them (chapter 23)


## Intersection of architecture and operations

Now, architectures such as microservices freely leverage former solely operational concerns. For example, elastic scale was once painfully built into architectures (Chapter 15), while microservices hanlded it less painfully via a liaison architects and devops.


## Engineering practices

Traditionally, software architecture was seaparate from the development process used to create software. Dozens of popular methodologies exists to build softwrae, including Waterfall and many falvors of Agile (such as Scrum, exteeme programming, lean, and crystal), which mostly don't impact software architecture.

software engineering practices, on the other hand, refer to process-agnostic practices that have illustrated, repeatable benefit. For example, continuous integration is a proven engineering practice that doesn't rely on a particular process.

#### The path from extreme programming to continuous delivery

The origins of extreme programming nicely illustrate the difference between process and engineering. 


As any experience in the software development world illustrates, nothing remains static. Thus, architects may design a system to meet certain creteria, but that design msut survive both implementation (how can architects make sure that thier design is implemented correctly) and the inevitable change driven by the softwrae development ecosystem. What we need is an evolutionary architecture.

`Building evolutionar architectures` introduces the concept of using 'fitness functions' to protect (and govern) architectural characterstics as chagne occurs over time. The concept comes from evolutionary computing. When designing a genetic algorithm, developers have a variety of techniques to mutate the solution, evolving new solutions iteratively. 

还有很多废话。。


## Operations/DevOps

The most obvious recent intersection between architecture and related fields occurred with the advent of Devops, driven by some rethinking of architectural axioms. For many years, many companies considered operations as separate function from software development.

...



The buiders of the microservices style of architecture realized that these operational concerns are better handled by operations. By creating a liaison between architecture and operations, the architects can simplify the design and rely on oeprations ofr the things they handle bests. Thus, realizing a misappropriation of resources led to acciedental complexity, and architects and operations teamed up to create microserviers, the details of which we cover in Chapter 17.



## Process

Another axiom is that software architecture is mostly orthogonal to the software development process; the way that you build software (process) has little impact o nthe software architecture (structure). THus while the softtware development process a team uses has some impact on software architecture (especially around engineeering practices), historically they have been though of as mostly separate. Most books on softwrae architecture ignore the sotware development process, making specious assumptions about things like predictability. Howevery, the process by which teams develop software has ean impact on many facets of software architecture. For example, many companies over the last few decades have adopted agile developmet methodologies because of the nature of software.  Architects in agile projects can assume iterative development and therfore a faster feedback loop for decision, that in turn allows architects to be more aggresive about experimentation and other knowledge that relies on feedback.

One critical aspect of architecture where Agile methodologies shine is restructuing, Teams often find that they need to migrate thier architecture from 1 pattern to another. for example, a team started with a monolithic architecture because it was easy and fast to bootstrap, but now they need to move to a more modern architecture. 

agile methodologies support these kind of changes better than planning-heavy processes because of the tight feedback loop and encouragement of techniques like the 'strangler pattern' and 'feature toggles'


## Data

A large percentage of serious application development includes external data storage, often in the form for a relational (NOSQL) database. However, many books about sfotware architecture include only a light treatment of this important aspect of architecture. code and data have a symbiotic relationship (共生): one isn't useful withou the other.


Database administrator often work alongside architects to build data architecture for complex systems, analyzing how relationships and resuse will affect a portfolio of appplications. we won't delve into that level of specialized details in this book .at the same time, we won't ignore the existence and dependence on external storage. In particular, when we talk about the oeprational aspects or architecture and architectural quantum (chapter 3), we include important external concerns such as databases.

## Laws of software architecture

> if an architect thinks they have disccovered something that isn't a trade-off, more likely they just haven't idenitfied the trade-off yet. 



```
why is more important than how.

```



An architect can look at an existing system they have no knowledge of, and ascertain how the structure of the architecture works, but will struggling explaning why certain choices were made versus others.

Throughout the book, we highligh **why** architects make certain decisions along with trade-offs. We also hightlight good techniques for capturing important decisions in 'architecture decision records'



# Part 1. Foundations

to undersatnd important trade-offs in architecture. developers must understand some basic concepts and terminology concerning compoennts, modularity, coupling , and connascene.



# Chapter 2 Architectural thinking


An architect see things differently from a developers' point of view

This is called architectural thinking.


## Architecture Versus Design

at architect is responsible for thinkgs like 

* analyzing business requirements to extract and define the architectural characterstics
* selecting which architecture patterns and styles would fit the problem domain,
* creating components ( the building blocks of the system)


The artifacts created from theses activites are then handed off to the development team, which is responsible for creating class diagram for each component, creating user interface screens, and developing and testing source code




