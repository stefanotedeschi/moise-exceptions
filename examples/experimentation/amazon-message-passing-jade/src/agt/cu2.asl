
+exception(paymentRefused,_)[source(Sender)]
     : not alreadyRetried
	<- .print("Retrying once...");
	   +alreadyRetried;
	   .send(Sender,tell,retry).
	   
+exception(paymentRefused,_)
     : alreadyRetried & play(Receiver,customerUserAgent,gcu)
	<- .print("Failed again!");
	   .send(Receiver,tell,checkoutFailed);
	   .
	   
+!checkout
	<- .print("Checkout completed!").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
