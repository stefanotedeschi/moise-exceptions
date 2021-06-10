// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

+!reachDestination
     : not alternativePath & not wait
	<- println("Reaching destination...");
	   +wait;
	   .wait(10000);
	   println("Some roads were closed! I'm late'").

+!reachDestination
     : not alternativePath & wait
	<- println("Reaching destination... I'm a little bit late");
	   -wait.
	   
+!reachDestination
     : alternativePath
    <- println("Reaching destination ON ALTERNATIVE PATH...").
	   
+!reportDelayReason
	<- println("*** Reporting closed roads...");
	   throwException(exParcel,[reason(roadworks),closedRoads([mainStreet,fifthAvenue])]).
	

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
