+!parseAmount
	<- println("Parsing amount...");
	   parseAmount.

-!parseAmount
	<- goalInFault(parseAmount);
	   .fail.

+!throwNan
	<- println("Throwing exception!");
	   throwException(nan,[problem]).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
