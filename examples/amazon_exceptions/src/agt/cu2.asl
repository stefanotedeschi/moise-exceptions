
+obligation(Ag,_,done(_,retry,Ag),_)[artifact_id(ArtId)]
     : not alreadyRetried
	<- println("Retrying once...");
	   +alreadyRetried;
	   resetGoal(checkout)[artifact_id(ArtId)].
	   
+obligation(Ag,_,done(_,retry,Ag),_)[artifact_id(ArtId)]
     : alreadyRetried
	<- println("Failed again!");
	   goalFailed(retry)[artifact_id(ArtId)].
	   
+obligation(Ag,_,thrown(_,throwRetry),_)[artifact_id(ArtId)]
	<- println("Throwing exception for retry...");
	   exceptionThrown(throwRetry,checkoutFailed)[artifact_id(ArtId)].
	   
+!checkout
	<- println("Checkout completed!").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
