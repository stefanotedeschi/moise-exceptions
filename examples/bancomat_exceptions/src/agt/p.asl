
+!parseAmount
	<- println("Parsing amount...");
	   parseAmount.

-!parseAmount
	<- goalFailed(parseAmount).

+obligation(Ag,_,thrown(_,throwParseAmount),_)
	 : .my_name(Ag)
	<- println("DEVO LANCIARE UN'ECCEZIONE");
	   exceptionThrown(throwParseAmount,nan,[motivo(x)]).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
