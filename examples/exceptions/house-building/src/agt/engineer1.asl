// This company bids for site preparation
// Strategy: decreasing its price by 150 until its minimal value



// This company bids for site preparation
// Strategy: decreasing its price by 150 until its minimal value

my_price(2500). // initial belief

!discover_art("auction_for_Engineering").

+currentBid(V)[artifact_id(Art)]        // there is a new value for current bid
    : not i_am_winning(Art) &           // I am not the winner
      my_price(P) & P < V               // I can offer a better bid
   <- //.print("my bid in auction artifact ", Art, " is ",math.max(V-150,P));
      bid( math.max(V-150,P) ).         // place my bid offering a cheaper service

+!inspect_site
    : .my_name(Ag) &
      focused(ora4mas,bhsch,ArtId)
   <- println("Inspecting site...");
      .wait(2000);
      println("Done!");
      println("Fixing flooding...");
      .wait(2000);
      println("Done!");
      fixFlooding;
      goalReleased(site_prepared)[artifact_id(ArtId)];
      goalAchieved(inspect_site)[artifact_id(ArtId)].

/* plans for execution phase */

{ include("common.asl") }
{ include("org_code.asl") }