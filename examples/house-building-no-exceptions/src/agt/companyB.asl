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

+obligation(Ag,_,done(_,site_prepared,Ag),_)
	: my_name(Ag)
   <- !site_prepared;
      goalAchieved(site_prepared).
       
+!site_prepared
   <- println("Preparing site...");
      prepareSite. // simulates the action (in GUI artifact)
   	  
-!site_prepared[env_failure_reason(F),scheme(S)]
    : focused(ora4mas,S,ArtId) &
      play(Eng,engineer,hsh_group) &
      play(HouseOwner,house_owner,hsh_group)
   <- println("The site is flooded due to ",F,"!");
      .send(Eng,tell,exception(S,site_preparation_exception,[errorCode(F)]));
 	  .send(HouseOwner,tell,exception(S,site_preparation_exception,[errorCode(F)]));
   	  .fail.
   	  
+handled(S,site_preparation_exception)
     : focused(ora4mas,S,ArtId)
	<- !site_prepared;
	   goalAchieved(site_prepared)[artifact_id(ArtId)].
   	  
 { include("org_code.asl") }