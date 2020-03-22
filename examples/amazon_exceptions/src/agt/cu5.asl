
+!receiveItems
	<- println("Waiting for items...");
	   .wait({+order});
	   println("Order received!").
	   
+problemInOrderDelivery
	<- goalFailed(receiveItems).
	
+obligation(Ag,_,thrown(_,throwReceiveItems),_)[artifact_id(ArtId)]
	<- println("Throwing exception for receive items... Items not received!");
	   exceptionThrown(throwReceiveItems,itemsNotReceived)[artifact_id(ArtId)].

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
