{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

satisfied(G) :- goalState(_,G,_,_,satisfied).

+!sell : not account(flourType(T)) & not satisfied(getAuthorization)
	<- .print("Getting authorization...");
	   goalAchieved(getAuthorization);
	   !sell.

+!sell : not account(flourType(T))
	<- .print("Requesting account to baker...");
	   goalAchieved(requestFlourTypeToBaker);
	   .wait({+account(flourType(_))});
	   !sell.

+!sell : account(flourType(organic))
	<- .print("Selling at a HIGHER price...").

+!sell : account(flourType(normal))
	<- .print("Selling at a LOWER price...").

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
