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
   <- .random([0,1],R1)
      if(R1 == 0) {
         +exterior_color(yellow);
      }
      else {
         +exterior_color(red);
      }
      .random([0,1],R2)
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
      
+!windows_fitted[scheme(S)]
    : hurryUp
   <- .print("Notifying weeks of delay");
      .random([0,1],N);
      if(N == 0) {
         .broadcast(tell,exception(S,windows_delay_exception,[weeksOfDelay(1)]));
      }
      else {
         .broadcast(tell,exception(S,windows_delay_exception,[weeksOfDelay(3)]));
      }
      .print("Fitting windows... I Have to hurry!");
      fitWindows;
      -hurryUp
      .print("Windows done!").

+exception(bhsch,windows_delay_exception,[weeksOfDelay(D)])[source(Sender)]
    : D >= 2 & focused(ora4mas,bhsch,ArtId)
   <- .print("There is a delay in windows fitting by ",Sender, " of ",D," weeks! I can reschedule my tasks");
      .send(Sender,tell,handled(S,windows_delay_exception)).

+!exterior_painted
    : play(HouseOwner,house_owner,hsh_group) &
      exterior_color(C) & available_colors(L) & not .member(C,L)
   <- .send(HouseOwner,tell,exception(bhsch,exterior_paint_exception,[alternativeColors(L)]));
      .wait({+newColor(NC)});
      -exterior_color(C);
      +exterior_color(NC);
      !exterior_painted.
      //resetGoal(exterior_painted)[artifact_id(ArtId)].

+!interior_painted[scheme(S)]
    : play(HouseOwner,house_owner,hsh_group) &
      interior_color(C) & available_colors(L) & not .member(C,L)
   <- .send(HouseOwner,tell,exception(bhsch,interior_paint_exception,[alternativeColors(L)]));
      .wait({+newColor(NC)});
      -interior_color(C);
      +interior_color(NC);
      !interior_painted.
      //resetGoal(interior_painted)[artifact_id(ArtId)].

{ include("org_code.asl") }
{ include("org_goals.asl") }
