
+!receiveItems
	<- println("Waiting for items...");
	   .wait({+order});
	   println("Order received!").
	   
+problemInOrderDelivery
	<- goalInFault(receiveItems).
	
+obligation(Ag,_,done(_,raiseItemsNotReceived,Ag),_)[artifact_id(ArtId)]
     : .my_name(Ag)
	<- println("Throwing exception for receive items... Items not received!");
	   throwException(itemsNotReceived,[])[artifact_id(ArtId)];
	   goalAchieved(raiseItemsNotReceived).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
