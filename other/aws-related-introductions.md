

## SQS VS SNS

* https://www.youtube.com/watch?v=mXk0MNjlO7A
* SNS to SQS: https://www.youtube.com/watch?v=VXsAgYoC1Jc



### SNS

* publisher/subscriber system
* publishing messages to a topic can deliver to many susbscribers (fan out) of different types (SQS, Lambda, Email etc)
* use SNS  when other systems care abou this event


### SQS

* queueing service for message processing.
* a system must poll the Queue to discover new events
* messges in the queue are typically processed by a single consumer
* use SQS when **your system** care about an event

## Step functions
* https://www.youtube.com/watch?v=zCIpWFYDJ8s
* https://www.youtube.com/watch?v=s0XFX3WHg0w - with lambda

* allow you to create workflows that follow afixed or dynamic sequence - aka "steps"
* can think of an orchestration for an application
* have built in retry functionality (also on AWS Services/Resources) - don't progress until success
* native integration with AWS services, eg: Lambda, SNS
* ADSL language, kind of JSON language
* GUI for auditing workflow progress, input/putout, etc.
* highly scalable and low cost


in summary:

it helps to create the orchestrate of the sequence of events that you code into your step functions, so that provided it fails, you can apply some retry policy etc





## API Gateway

* https://www.youtube.com/watch?v=vHQqQBYJtLI
