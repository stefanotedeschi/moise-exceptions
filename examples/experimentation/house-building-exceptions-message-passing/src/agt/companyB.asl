// This company bids for site preparation
// Strategy: decreasing its price by 150 until its minimal value

{ include("common.asl") }

my_price(1500). // initial belief

!discover_art("auction_for_SitePreparation").

+currentBid(V)[artifact_id(Art)]        // there is a new value for current bid
    : not i_am_winning(Art) &           // I am not the winner
      my_price(P) & P < V               // I can offer a better bid
   <- //.print("my bid in auction artifact ", Art, " is ",math.max(V-150,P));
      bid( math.max(V-150,P) ).         // place my bid offering a cheaper service

/* plans for execution phase */

+!site_prepared  // the organisational goal (created from an obligation)
   <- .print("Preparing site...");
      prepareSite;
      .print("Done!").

-!site_prepared[env_failure_reason(F)]
   <- .print("The site is flooded due to ",F,"!");
      //.send(Eng,tell,exception(S,site_preparation_exception,[errorCode(F)]));
 	   //.send(HouseOwner,tell,exception(S,site_preparation_exception,[errorCode(F)]));
      .broadcast(tell,exception(bhsch,site_preparation_exception,[errorCode(F)]));
      .fail.

+handlerProposal(bhsch,site_preparation_exception)[source(Sender)]
    : not (handlerProposal(bhsch,site_preparation_exception)[source(AnotherSender)] & Sender \== AnotherSender)
   <- -handlerProposal(bhsch,site_preparation_exception)[source(Sender)];
      .send(Sender,tell,handlerProposalAccepted(bhsch,site_preparation_exception)).

+handled(bhsch,site_preparation_exception)[source(Sender)]
    : focused(ora4mas,bhsch,ArtId)
	<- -handled(S,site_preparation_exception)[source(Sender)];
      !site_prepared;
	   goalAchieved(site_prepared)[artifact_id(ArtId)].

{ include("org_code.asl") }
{ include("$jacamoJar/templates/common-cartago.asl") }
