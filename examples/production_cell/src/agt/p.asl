// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

+!movePressDownUp
	<- println("Can't move the press");
	   .fail.
	   
+!explainSlowdownReason
	<- println("A human operator is in the dangerous area!");
	   throwException(exHuman,[slowdownCode(ux57),humanCoords(1,2)]).

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
