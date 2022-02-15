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
      
+!site_prepared
   <- println("Preparing site...");
      prepareSite. // simulates the action (in GUI artifact)
   	  
-!site_prepared[env_failure_reason(F),scheme(S)]
    : focused(ora4mas,S,ArtId)
   <- println("The site is flooded due to ",F,"!");
      +failureReason(F);
      goalFailed(site_prepared)[artifact_id(ArtId)];
   	.fail.
   	  
+obligation(Ag,_,done(Scheme,notify_site_preparation_problem,Ag),_)
    : .my_name(Ag) &
      focused(ora4mas,Scheme,ArtId) &
      failureReason(F)
   <- //println("THROWING SITE PREPARATION EXCEPTION WITH ERROR CODE ",F,"!")
      throwException(site_preparation_exception,[errorCode(F)])[artifact_id(ArtId)];
      -failureReason(F);
      goalAchieved(notify_site_preparation_problem)[artifact_id(ArtId)].
   	  
 { include("org_code.asl") }