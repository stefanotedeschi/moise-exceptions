
+!withdraw
	<- finishWithdraw;
	   println("Withdrawal completed").
	   
+!retryLater
	<- failWithdraw;
	   println("TRY LATER").
	   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
