
+!notifyCustomer
     : exceptionArgument(_,itemsLost,recipient(Recipient))
	<- println("Notifying customer...");
	   .send(Recipient,tell,problemInOrderDelivery).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
