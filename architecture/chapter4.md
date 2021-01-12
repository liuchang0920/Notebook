


# chapter 4. Architecture characterstics defined

a softwar esolution consiste of both domain requirment and architectural characterstics


* autitability
* performance
* security
* requirements
* data
* legality
* scalability

。。。

an architecture characterstic meets 3 criteria:

* specifies a nondomain design consideration
* influnences some strctural aspect of the design
* is cretical or important to application success


* specifies a nondomain design consideration


when designing an application, the requirements specify what the application should do; architecture characterstics specifify operationsl and design creteria for success, concerning how to implement the requiremtns and why certain choices were made.

For example: a common important architecture characterstic specifies a certain level of performance for the application, which often doesn't apear in a requirements documents. even more pertinent: no requirements document states 'prevent technical debt', but it is a common design consideration for architects and developers.

* influences some structural aspect of the design

### Critical or important to application success

> applications could support a huge number of architecture characteristics.. but shouln't. 

A critical job for architects lies in choosing the fewest architecture characterstics rather than the most possible.



## Architectural characterstics



...

## Operational architecture characterstics

operational architecture characterstics ocver capabilities such as performance, scalability, elasticity, availabiltiy, and reliability.


* availability
  * how long the system will need to be available, steps need to be in place to allow the system to be up and running quickly in case of any failure
* continuity
  * disaster recovery capability
  * includes stress testing, peak analysis, analysis of the frequency of functions used, capacity required, and response times.
* performance 
  * performance acceptance sometimes requries an exercise of its own, taking months to complete.
* recoverability
  * business continuity requirments (eg: in case of a disaster, how quickly is the system required to be on-line again?) This will affect the backup strategy and requirements for duplicated hardware.
* reliability/safeymission
  * critical in a way that affects lives. if it fails, will it cost the company large sums of money ?

**term/definition**


* robustness
  * ability to handle error and boundary conditions while running if the internet connections goes down or it there's a power outage or hardware failure.
* scalability
  * ability for the system to perform and oeprate as the number of users or requests increases.


operational architecture characterstics heavily overlap with oeprations and devops concersns, forming the intersection of those concerns in many osftware projects.

## Structural architecture characterstics

architects msut concern themselves with code structure as well. in many cases, the architect has sole or shared responsibility for code quality concerns, such as good modularity, controlled coupling between components, readable code, and a host of other internal quality assessments.


here lists a few structrual architecture characterstics

* configurabilty
  * ability for the end users to easily change aspects of the software's configuration (through usable interfaces)
* extensibility
  * how important it is to plug new piece of functionality in.
* installability 
  * ease of system installation on all necessary platforms
* leverageability/reuse
  * ability to leverage common components across mulitiple products
* localization 
  * support for mulitple languages on entry/query screens in data fields; on reports, mulitbyte character requirements and units of measure or currentcies.
* maintainability
  * how easy it is to apply changes and enhance the system?
* portability
  * Does the system need to run on more thatn 1 platform? (for example, does the frontend need to run aginst oracle as well as SAP DB?)
* supportabilty
  * what level of technical support is needed by the application? waht level of logging and other facilities are required to debug errors in the system?
* upgradeability
  * ability to easily/quickly upgrade from a previous version of this application/solution to a newer version on servers and clients.
  
## Cross-cutting architecture characterstics

while many architecture characterstics fall into easily recognizable categories, many fall outside or defy categorization yet form important design constraints and considerations.

* accessibility
  * access to all your users, including thoses with disabilty like colorblindness or hearing loss.
* archivability
  * will the data need to be archieve or deleted after a period of time (customer accoutns are to be deleted after 3 montsh or marked as obsolete and archived to a secondary database for fugure access.)
* authentication
  * security requrements to ensure userse are who they say they are.
* authorization
  * security reqreuiemtns to ensure user can access only certain functions within the application (by use case, subsystem, webpage, busines rule, field level, etc.)
* legal 
  * what legislative constraints is the system oeprations (data protection, sarbanes oxley, GDPR etc?) what reservation rights does the company require? any regulartions regardign the way the application is to be build or deployed?
* privacy
  * ability to hide transactions from internal company employees (encrypted transactions so even DBAs and network architect scannot see them).
* security
  * Does the data need to be encrypted in the database? encrypted for network communication between internal systems? what type of authentication need to be in palce for remote user access?
* supportabiliy
  * what level of technical support is needed by the application? what level of logging and other facilities are required to debug erros in the system?
* Usability/achievability
  * level of training required for users to achieve their goals with the application/solution. Usability requirements need to be treated as serious as any other architectural issue.


Any list of architecture acharacterstics will necessarily bea nincomplete list; any software many invent important architectural characterstics based on unique factors 

...

## Trade-offs and least worst architecture

...

Never shoot for the best architecture, but rather the least worst architecture.


Too many architecture characterstics leads to a generic solutions that are trying to solve every business problem, and those architectures rarely owrk because the design becomes unwieldy.

this suggests that architects should strive to design architecture to be as iterative as possible. 
