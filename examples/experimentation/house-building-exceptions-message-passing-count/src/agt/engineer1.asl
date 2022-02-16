// This company bids for site preparation
// Strategy: decreasing its price by 150 until its minimal value



// This company bids for site preparation
// Strategy: decreasing its price by 150 until its minimal value

my_price(2500). // initial belief

!discover_art("auction_for_Engineering").

!discover_logging_art.

+currentBid(V)[artifact_id(Art)]        // there is a new value for current bid
    : not i_am_winning(Art) &           // I am not the winner
      my_price(P) & P < V               // I can offer a better bid
   <- //.print("my bid in auction artifact ", Art, " is ",math.max(V-150,P));
      bid( math.max(V-150,P) ).         // place my bid offering a cheaper service

+exception(bhsch,site_preparation_exception,Args)[source(Sender)]
    : (.member(errorCode(flooding),Args) | .member(errorCode(archaeologicalRemains),Args)) &
      loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      println("Proposing as handler for site preparation exception...");
      .send(Sender,tell,handlerProposal(bhsch,site_preparation_exception)).

+handlerProposalAccepted(bhsch,site_preparation_exception)[source(Sender)]
    : exception(bhsch,site_preparation_exception,Args) &
      .member(errorCode(flooding),Args) & loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      -exception(bhsch,site_preparation_exception,Args)[source(Sender)];
      -handlerProposalAccepted(bhsch,site_preparation_exception)[source(Sender)];
      println("Inspecting site...");
      performSiteAnalysis(Result);
      println("Done!");
      println("Fixing flooding...");
      fixFlooding(Result);
      .send(Sender,tell,handled(bhsch,site_preparation_exception));
      println("Done!").

+handlerProposalAccepted(bhsch,site_preparation_exception)[source(Sender)] 
    : exception(bhsch,site_preparation_exception,Args) &
      .member(errorCode(archaeologicalRemains),Args) & loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      -exception(bhsch,site_preparation_exception,Args)[source(Sender)];
      -handlerProposalAccepted(bhsch,site_preparation_exception)[source(Sender)];
      println("Inspecting site...");
      delimitSite;
      println("Done!");
      println("RemovingRemains...");
      carefullyRemoveRemains;
      .send(Sender,tell,handled(bhsch,site_preparation_exception));
      println("Done!").

/* plans for execution phase */

{ include("common.asl") }
{ include("org_code.asl") }
{ include("exception_logging.asl") }