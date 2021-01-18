+!parseAmount
	<- println("Parsing amount...");
	   parseAmount.

-!parseAmount
	<- println("The inserted string is not a number!")
	   goalInFault(parseAmount);
	   .fail.

+!throwNan
	<- println("Throwing exception NAN!");
	   throwException(nan,[index(0)]).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
