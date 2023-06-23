{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

wait.

+!reachDestination
     : wait
	<- .print("Reaching destination... Some roads are closed! I will be late");
	   -wait;
	   .wait(10000).

+!reachDestination
     : not wait
	<- .print("Reaching destination...").

+oblUnfulfilled(O)
	<- .print(O).

+oblUnfulfilled(obligation(Ag,_,done(_,reachDestination,Ag),_))
	 : not .my_name(Ag)
	<- !investigateDelay.

+!investigateDelay
	 : not account(reason(R))
	<- .print("*** REQUESTING DELAY REASON ***");
	   +accountRequestedByMe;
	   goalAchieved(requestDelayReason);
	   .wait({+account(_)});
	   !investigateDelay.

+!investigateDelay
	 : account(reason(roadworks))
	<- .print("*** ADDING CLOSED ROADS TO IGNORE LIST... ***");
	   +ignore(I).


+!reportDelayReason : not accountRequestedByMe
	<- .print("*** REPORTING DELAY REASON... ***");
	   giveAccount([reason(roadworks),roads([mainStreet,fifthAvenue])]).


// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
