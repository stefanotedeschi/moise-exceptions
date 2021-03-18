+!parseAmount
	<- println("Parsing amount...");
	   .wait(2000);
	   parseAmount.

-!parseAmount[env_failure_reason(firstNaNIndex(Value))]
	<- println("The inserted string is not a number!");
	   +firstNaNIndex(Value);
	   goalFailed(parseAmount);
	   .fail.

+!throwNan
     : firstNaNIndex(I)
	<- .wait(2000);
	   println("Throwing exception NAN: ", index(I));
	   throwException(nan,[index(I)]);
	   -firstNaNIndex(I).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
