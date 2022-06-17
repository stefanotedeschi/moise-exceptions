// This company can bid for all types tasks,
// but can commit to at most 2 of them
// Strategy: fixed price

{ include("common.asl") }

// a rule to help the agent infer whether it can commit to another task
can_commit :-
   .my_name(Me) & .term2string(Me,MeS) &
   .findall( ArtId, currentWinner(MeS)[artifact_id(ArtId)], L) &
   .length(L,S) & S < 2.

// initial beliefs about valuations for the auction
my_price("SitePreparation", 1900).
my_price("Floors",           900).
my_price("Walls",            900).
my_price("Roof",            1100).
my_price("WindowsDoors",    2000).
my_price("Plumbing",         600).
my_price("ElectricalSystem", 300).
my_price("Painting",        1100).

available_colors([white,gray,red,orange,cyan]).

!setup_initial_colors.

//!discover_art("auction_for_SitePreparation").
!discover_art("auction_for_Floors").
!discover_art("auction_for_Walls").
!discover_art("auction_for_Roof").
!discover_art("auction_for_WindowsDoors").
!discover_art("auction_for_Plumbing").
!discover_art("auction_for_ElectricalSystem").
!discover_art("auction_for_Painting").

+!setup_initial_colors
   <- .random([0,1],R1);
      if(R1 == 0) {
         +exterior_color(yellow);
      }
      else {
         +exterior_color(red);
      }
      .random([0,1],R2);
      if(R2 == 0) {
         +interior_color(green);
      }
      else {
         +interior_color(white);
      }
      .

@lbo[atomic] // atomic to ensure it still winning less than two when the bid is placed
+currentBid(V)[artifact_id(Art)]        // there is a new value for current bid
    : task(S)[artifact_id(Art)] &
      my_price(S,P) &                   // get my valuation for this service
      not i_am_winning(Art) &           // I am not the winner
      P < V &                           // I can offer a better bid
      can_commit                        // I can still commit to another task
   <- //.print("my bid in auction artifact ", Art, ", Task ", S, ", is ", P);
      bid( P )[ artifact_id(Art) ].     // place my bid offering a cheaper service

/* plans for execution phase */

+!windows_fitted
    : not hurryUp
   <- .print("Fitting windows...");
      +hurryUp;
      .random([0,1],N);
      if(N == 0) {
         .wait(1500);
      }
      fitWindows;
      .print("Windows done!").

+!windows_fitted
    : hurryUp
   <- .print("Fitting windows... I Have to hurry!");
      fitWindows;
      -hurryUp;
      .print("Windows done!").

+!notify_windows_fitting_delay[scheme(S)]
	: focused(ora4mas,S,ArtId)
   <- .print("Notifying weeks of delay");
      .random([0,1],N);
      if(N == 0) {
         //.print("********** RAISING WINDOWS DELAY EXCEPTION!");
         raiseException(windows_delay_exception,[weeksOfDelay(1)])[artifact_id(ArtId)];
      }
      else {
         //.print("********** RAISING WINDOWS DELAY EXCEPTION!");
         raiseException(windows_delay_exception,[weeksOfDelay(3)]); // This exception would enable the handling goal
      }
      .

+!exterior_painted[scheme(S)]
    : focused(ora4mas,S,ArtId) &
      exterior_color(C) & available_colors(L) & not .member(C,L)
   <- goalFailed(exterior_painted)[artifact_id(ArtId)];
      .fail.

+!interior_painted[scheme(S)]
    : focused(ora4mas,S,ArtId) &
      interior_color(C) & available_colors(L) & not .member(C,L)
   <- goalFailed(interior_painted)[artifact_id(ArtId)];
      .fail.

+!notify_painting_failure[scheme(S)]
    : focused(ora4mas,S,ArtId) & available_colors(L)
   <- //.print("********** RAISING PAINT EXCEPTION!");
      raiseException(paint_exception,[alternativeColors(L)])[artifact_id(ArtId)].

+newColor(C)
    : focused(ora4mas,bhsch,ArtId) &
      goalState(bhsch,exterior_painted,_,_,failed)
   <- -exterior_color(_);
      +exterior_color(C);
      resetGoal(exterior_painted)[artifact_id(ArtId)].

+newColor(C)
    : focused(ora4mas,bhsch,ArtId) &
      goalState(bhsch,interior_painted,_,_,failed)
   <- -interior_color(_);
      +interior_color(C);
      resetGoal(interior_painted)[artifact_id(ArtId)].

{ include("org_code.asl") }
{ include("org_goals.asl") }
{ include("$jacamoJar/templates/common-cartago.asl") }