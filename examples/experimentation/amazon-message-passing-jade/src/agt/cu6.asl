
+focusing(ArtId,logart,"tools.LoggingArtifact",_,_,_)
	<- logStart[artifact_id(ArtId)].

+!placeOrder
	<- .print("DONE!");
	   logFinish.

+checkoutFailed
	<- .print("Order canceled!");
	   logFinish.
	
+itemsNotReceived
	<- .print("TOO BAD =( I'll request a refund.");
	   logFinish.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
