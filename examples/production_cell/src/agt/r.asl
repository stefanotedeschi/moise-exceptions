// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

!request.

+!request
	<- .wait(1000);
	   println("**** PERFORMING REQUEST ****");
	   goalAchieved(requestRemainingStock).

+!extendArm1
	<- println("Extending robotic arm 1...").
	
+!grabPlateFromBelt
	<- println("Grabbing plate from feed belt...").
	
+!movePlateOnPress
	<- println("Moving plate on press...").
	
+!releasePlateOnPress
	<- println("Releasing plate on press...").
	
+!retractArm1
	<- println("Retracting robotic arm 1...").
	
+!turnRobot
	<- println("Turning robot...").

+!extendArm2
	<- println("Extending robotic arm 2...").
	
+!grabPlateFromPress
	<- println("Grabbing plate from press...").
	
+!movePlateOnBelt
	<- println("Moving plate on deposit belt...").
	
+!releasePlateOnBelt
	<- println("Releasing plate on deposit belt...").
	
+!retractArm2
	<- println("Retracting robotic arm 2...").

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
