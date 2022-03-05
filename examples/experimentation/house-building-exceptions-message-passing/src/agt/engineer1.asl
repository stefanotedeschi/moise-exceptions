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

+exception(bhsch,site_preparation_exception,Args)[source(Sender)]
    : (.member(errorCode(flooding),Args) | .member(errorCode(archaeologicalRemains),Args))
   <- .print("Proposing as handler for site preparation exception...");
      .send(Sender,tell,handlerProposal(bhsch,site_preparation_exception)).

+handlerProposalAccepted(bhsch,site_preparation_exception)[source(Sender)]
    : exception(bhsch,site_preparation_exception,Args) &
      .member(errorCode(flooding),Args)
   <- -exception(bhsch,site_preparation_exception,Args)[source(Sender)];
      -handlerProposalAccepted(bhsch,site_preparation_exception)[source(Sender)];
      .print("Inspecting site...");
      performSiteAnalysis(Result);
      .print("Done!");
      .print("Fixing flooding...");
      fixFlooding(Result);
      .send(Sender,tell,handled(bhsch,site_preparation_exception));
      .print("Done!").

+handlerProposalAccepted(bhsch,site_preparation_exception)[source(Sender)] 
    : exception(bhsch,site_preparation_exception,Args) &
      .member(errorCode(archaeologicalRemains),Args)
   <- -exception(bhsch,site_preparation_exception,Args)[source(Sender)];
      -handlerProposalAccepted(bhsch,site_preparation_exception)[source(Sender)];
      .print("Inspecting site...");
      delimitSite;
      .print("Done!");
      .print("RemovingRemains...");
      carefullyRemoveRemains;
      .send(Sender,tell,handled(bhsch,site_preparation_exception));
      .print("Done!").

/* plans for execution phase */

{ include("common.asl") }
{ include("org_code.asl") }