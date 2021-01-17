

# Chapter 7. Scope of architecture characterstics

## Coupling and connascnence


### Connascence (共生性)

2 components are connascnet if a change in one would require the other to be modified in order to maintain the overal correctness of the systme.



## Architectural quanta（定量） and granularity

### Architecture quantum
An independenctly deployable artifact with high functional cohesion and synchronous connascence

This definition contains serveral parts,

* independently deployable
* high funtional cohesion
* synchronous connascence


eg: Payment, Auction service example:

A poorly designed architecture would allow the first call to go through and allow the others to timeout.
Alternatively, and architect might design an asyncrhonous communication link between Payment and Auction, allowing the message queue to temporarily buffer the differences.
In this case, asynchrounous connascence creates a more flexbible architecutre. (will cover in detail in chapter 14)

## Case study: going, going, gone


Description
* an auction company wants to take its autions online to a nationwide scale. Customer choose the auction to aprticipate in, wait until the auction begins, then bid as if they are in there room with the auctioneers.
Users
 * scale up to hundreds of participants per auction, potentially up to thousands of participants, and as many siultaneous auctions as possible
Requirements
* auctions must be as real-time as possible
* bidders register with a credit card; the system automatically charges the card if the bidder wins
* bidders can see a live video stream fo the auction and all bids as they occur.
* both online and live bids mush be received in the order in which they are placed.
Additional Context
* auction company is expanding aggresively by mergin with samler competitiors.
* budget is not consitrained. this is a strategic direction
* company just exited a  lawsuit where it settled a suite alleging fraud.


---> 

* bidder feed back
  * encompasses the bid stream and video stream of bids
    * availability
    * scalabilty
    * performance
* Auctioneer
  * the live auctioneer
    * availability
    * reliability
    * scalability
    * elasticity
    * performance
    * security
* bidder
  * online bidders and bidding
    * reliability
    * availability
    * scalability
    * elasticity

