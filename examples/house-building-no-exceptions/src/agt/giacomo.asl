// Agent Giacomo, who wants to build a house

{ include("common.asl") }
{ include("org_code.asl") }

/* Initial beliefs and rules */

// counts the number of tasks based on the observable properties of the auction artifacts
number_of_tasks(NS) :- .findall( S, task(S), L) & .length(L,NS).

iteration(1).

/* Initial goals */

!have_a_house.


/* Plans */

+!have_a_house
   <- makeArtifact("LogArt", "tools.LoggingArtifact",[], ArtId);
      +loggerArtifact(ArtId);
      println("Logging artifact created!");
      log("Logging artifact created")[artifact_id(ArtId)];
      !contract; // hire the companies that will build the house
      !execute.  // (simulates) the execution of the construction

-!have_a_house[error(E),error_msg(Msg),code(Cmd),code_src(Src),code_line(Line)]
   <- .print("Failed to build a house due to: ",Msg," (",E,"). Command: ",Cmd, " on ",Src,":", Line).


/* Plans for Contracting */

+!contract
   <- !create_auction_artifacts;
      !wait_for_bids.
//      !dispose_auction_artifacts.

+!create_auction_artifacts
   <-  !create_auction_artifact("SitePreparation", 2000); // 2000 is the maximum value I can pay for the task
       !create_auction_artifact("Floors",          1000);
       !create_auction_artifact("Walls",           1000);
       !create_auction_artifact("Roof",            2000);
       !create_auction_artifact("WindowsDoors",    2500);
       !create_auction_artifact("Plumbing",         500);
       !create_auction_artifact("ElectricalSystem", 500);
       !create_auction_artifact("Painting",        1200);
       !create_auction_artifact("Engineering",     5000);.

+!create_auction_artifact(Task,MaxPrice)
   <- .concat("auction_for_",Task,ArtName);
      makeArtifact(ArtName, "tools.AuctionArt", [Task, MaxPrice], ArtId);
      focus(ArtId).
-!create_auction_artifact(Task,MaxPrice)[error_code(Code)]
   <- .print("Error creating artifact ", Code).

+!wait_for_bids
   <- println("Waiting bids for 5 seconds...");
      .wait(5000); // use an internal deadline of 5 seconds to close the auctions
      !show_winners.

+!show_winners
   <- for ( currentWinner(Ag)[artifact_id(ArtId)] ) {
         ?currentBid(Price)[artifact_id(ArtId)]; // check the current bid
         ?task(Task)[artifact_id(ArtId)];          // and the task it is for
         println("Winner of task ", Task," is ", Ag, " for ", Price)
      }.

//+!dispose_auction_artifacts
//   <- for ( task(_)[artifact_id(ArtId)] ) {
//         stopFocus(ArtId)
//         //disposeArtifact(ArtId)
//      }.

/* Plans for managing the execution of the house construction */

+!execute
	: iteration(I) &
      loggerArtifact(LogArtId)
   <- println;
      println("*** Starting iteration no. ",I,"***");
      .concat("Starting iteration no. ",I,Log)
      log(Log)[artifact_id(LogArtId)];
      println;

      // create the group
      .my_name(Me);
      createWorkspace("ora4mas");
      joinWorkspace("ora4mas",WOrg);

      // NB.: we (have to) use the same id for OrgBoard and Workspace (ora4mas in this example)
      makeArtifact(ora4mas, "ora4mas.nopl.OrgBoard", ["src/org/house-os.xml"], OrgArtId)[wid(WOrg)];
      focus(OrgArtId);
      createGroup(hsh_group, house_group, GrArtId);
      //debug(inspector_gui(on))[artifact_id(GrArtId)];
      adoptRole(house_owner)[artifact_id(GrArtId)];
      focus(GrArtId);

      !contract_winners("hsh_group"); // they will enter into the group

      // create the GUI artifact
      makeArtifact("housegui", "simulator.House");

      // create the scheme
      .concat(bsch,I,ArtName);
      createScheme(ArtName, build_house_sch, SchArtId);
      //debug(inspector_gui(on))[artifact_id(SchArtId)];
      focus(SchArtId);

      ?formationStatus(ok)[artifact_id(GrArtId)]; // see plan below to ensure we wait until it is well formed
      addScheme(ArtName)[artifact_id(GrArtId)];
      commitMission("management_of_house_building")[artifact_id(SchArtId)];
      .

+!contract_winners(GroupName)
    : number_of_tasks(NS) &
      .findall( ArtId, currentWinner(A)[artifact_id(ArtId)] & A \== "no_winner", L) &
      .length(L, NS)
   <- for ( currentWinner(Ag)[artifact_id(ArtId)] ) {
            ?task(Task)[artifact_id(ArtId)];
            println("Contracting ",Ag," for ", Task);
            .send(Ag, achieve, contract(Task,GroupName)) // sends the message to the agent notifying it about the result
      }.
+!contract_winners(_)
   <- println("** I didn't find enough builders!");
      .fail.

// plans to wait until the group is well formed
// makes this intention suspend until the group is believed to be well formed
+?formationStatus(ok)[artifact_id(G)]
   <- .wait({+formationStatus(ok)[artifact_id(G)]}).

+!house_built // I have an obligation towards the top-level goal of the scheme: finished!
    : iteration(N) & N < 1000 &
      group(hsh_group,house_group,GrArtId)
   <- println("*** Finished iteration no.",N," ***");
      -iteration(N);
      +iteration(N+1);
      println("*** Starting iteration no.",N+1," ***");
      .concat("Starting iteration no. ",N+1,Log)
      log(Log)[artifact_id(LogArtId)];
      .concat(bsch,N+1,ArtName)
      clearHouse[artifact_id(HouseArtId)];
      createScheme(ArtName, build_house_sch, SchArtId);
      //debug(inspector_gui(on))[artifact_id(SchArtId)];
      focus(SchArtId);

      ?formationStatus(ok)[artifact_id(GrArtId)]; // see plan below to ensure we wait until it is well formed
      addScheme(ArtName)[artifact_id(GrArtId)];
      commitMission("management_of_house_building")[artifact_id(SchArtId)];
      .
      
+!house_built // I have an obligation towards the top-level goal of the scheme: finished!
    : iteration(N) & N >= 1000 &
      group(hsh_group,house_group,GrArtId)
   <- println("*** Finished iteration no.",N," ***");
      -iteration(N);
      +iteration(N+1);
      log("Finished")[artifact_id(LogArtId)];
      .
   
+exception(S,site_preparation_exception,Args)
   <- println("Notifying the companies that we had a problem in site preparation!");
      // Do something to notify the companies
      .
      
+!handle_windows_fitting_delay
    : exceptionThrown(bhsch,windows_delay_exception,Company) &
      exceptionArgument(bhsch,windows_delay_exception,weeksOfDelay(D))
   <- println("There is a delay in windows fitting by ",Company, " of ",D," weeks!");
      // Do something to handle the delay
      .
