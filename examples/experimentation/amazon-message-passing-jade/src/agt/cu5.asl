
+!receiveItems
	<- .print("Waiting for items...");
	   .wait({+order});
	   .print("Order received!").

+problemInOrderDelivery
     : play(Receiver,customerUserAgent,gcu)
	<- .print("Items not received!");
	   .send(Receiver,tell,itemsNotReceived).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
