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

// obligation to achieve a goal
+obligation(Ag,_,done(_,notify_site_preparation_problem,Ag),_)[artifact_id(ArtId)]
    : .my_name(Ag)
   <- println("THROWING SITE PREPARATION EXCEPTION WITH ERROR CODE bad_weather!")
      throwException(site_preparation_exception,[errorCode(bad_weather)])[artifact_id(ArtId)];
      goalAchieved(notify_site_preparation_problem)[artifact_id(ArtId)].

+!site_prepared
   <- println("Preparing site...");
      .wait(2000);
      prepareSite. // simulates the action (in GUI artifact)
   	  
-!site_prepared
    : focused(ora4mas,bhsch,ArtId)
   <- println("The site is flooded due to bad weather!");
      goalInFault(site_prepared)[artifact_id(ArtId)];
   	  .fail.
   	  
 { include("org_code.asl") }