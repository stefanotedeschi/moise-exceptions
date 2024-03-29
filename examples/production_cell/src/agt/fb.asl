// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

inventory([plates(5),screws(100)]).
//inventory([plates(20),screws(100)]). //this one does not enable the handling policy
//inventory([plates(2),screws(100)]).
//inventory([plates(1),screws(100)]).

+!conveyPlateToTable
	 : not wait
	<- .print("Conveying plate to table... Have to wait for delivery");
	   +wait;
	   .wait(10000);
	   .print("Plates delivered! Performing job...").

+!conveyPlateToTable
	 : wait
	<- .print("Conveying plate to table...");
	   -wait.
	   
+!notifyRemainingStock
     : inventory(I) & .member(plates(N),I)
	<- .print("Notifying available plates...");
	   raiseException(exStock,[availablePlates(N)]).

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
