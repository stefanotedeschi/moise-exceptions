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

+exception(S,site_preparation_exception,Args)
    : .member(errorCode(flooding),Args) &
      focused(ora4mas,S,ArtId) &
      play(SPC,site_prep_contractor,hsh_group)
   <- println("Inspecting site...");
      performSiteAnalysis(Result);
      println("Done!");
      println("Fixing flooding...");
      fixFlooding(Result);
      .send(SPC,tell,handled(S,site_preparation_exception));
      println("Done!").
      
+exception(S,site_preparation_exception,Args)
    : .member(errorCode(archaeologicalRemains),Args) &
      focused(ora4mas,S,ArtId) &
      play(SPC,site_prep_contractor,hsh_group)
   <- println("Inspecting site...");
      delimitSite;
      println("Done!");
      println("RemovingRemains...");
      carefullyRemoveRemains;
      .send(SPC,tell,handled(S,site_preparation_exception));
      println("Done!").

/* plans for execution phase */

{ include("common.asl") }
{ include("org_code.asl") }