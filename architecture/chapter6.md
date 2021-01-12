  
  # Chapter 6. Measuring and govening architecture characterstics
  
  Architects must deal with the extraordinarily wide variety of architecture characterstics across all different aspects os software projects.
  
  Operational aspects like performance, elasticity, and scalability comingle with structural concerns such as modularity and deployability.
  
  ## Measuring Architecture characteristics
  
  
  serveral common problems exists around the definition of aarchitecture characterstics in organizations:
  
  * they aren't physics
  * wildly varying defnintions
  * too composite
  
  
  
  ## Operational measures
  
  The many flavors of performance
  
  Some of these metrics have additional implications for the design of applications. Many forward-thinking organization palce K-weight budgets for page downloads: a maximum number of bytes' worth of libraries and frameworks allowed on a particular page. Their rationale behiind this structure derives from physics constraints: only so many bytes can travel over a network at a time, especially for mobile devices in high-latency areas.
  
  High-level teams don't just estabilsh hard performance number; they base their definitions on a statical analysis. eg: for a video streaming service wants to monitor scalabilty. Rather tha nset an arbitrary number as the goal, engineers measure the scale over time, and build statical models, then reaise alarms if the real-time metrics fall outside the prediction mdoels. a failure can mean 2 things: the model is incorrect (which teams like to know) or something is amissing (which teams also would like to know).
  
  The kinds of characterstics that teams can now measure are evolving rapidly, in conjunction with tools and nuanced undersatnding. For example, many teams recently focused on performance budges for metrics such as first contentful paint and first CPU idel, bot hof which speak volumes about performance issues fro users of webpages on mobile devices. As devices, targets, capabilities, and myraid other things change, teams will find new things and ways to measure.
  
  
  
  ## Structural Measures
  
  some objective measures are not so obvious as performance, such as: modularity.
  
  
  ## Process measures
  
  some architecture characterstics interacts with software development processes. for example, agile often appreast as a desirable feature.
  
  ...
  
  ## Governance and fitness functions
  ??
  
  Modularity is a great example of an aspect of architecture that is important but not urgent; on many software projects, urgency domincates, yet architects still need a mechanism for govenance.
  
  ## Governing architectuer characterstics
  
  GOvernamce is an important responsibility of the architect role.
  
  The scope of architecture governamce covers any aspect of the software developemnt process that architects (including roles like enterprise architects) want to exert an influence upon.
  
  for example: ensuring software quality within an organization falls under the heading of architectural governance becaues it falls within the scope of architecture, and negligence can lead to disastrous quality problems.
  
  
  
  ## Fitness functions
  
  todo, 定义是啥？
  
