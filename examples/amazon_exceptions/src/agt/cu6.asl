
+!placeOrder
	<- println("DONE!").

+!cancelOrder
	<- println("Order cancelled!").
	
+!requestRefund
	<- println("TOO BAD =( I'll request a refund.").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
