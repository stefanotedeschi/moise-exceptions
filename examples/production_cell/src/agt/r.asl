// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

+!extendArm1
	<- .print("Extending robotic arm 1...").
	
+!grabPlateFromBelt
	<- .print("Grabbing plate from feed belt...").
	
+!movePlateOnPress
	<- .print("Moving plate on press...").
	
+!releasePlateOnPress
	<- .print("Releasing plate on press...").
	
+!retractArm1
	<- .print("Retracting robotic arm 1...").
	
+!turnRobot
	<- .print("Turning robot...").

+!extendArm2
	<- .print("Extending robotic arm 2...").
	
+!grabPlateFromPress
	<- .print("Grabbing plate from press...").
	
+!movePlateOnBelt
	<- .print("Moving plate on deposit belt...").
	
+!releasePlateOnBelt
	<- .print("Releasing plate on deposit belt...").
	
+!retractArm2
	<- .print("Retracting robotic arm 2...").
	
+!slowDownProduction
     : exceptionRaised(_,exStock,_) &
       exceptionArgument(_,exStock,availablePlates(N)) &
       N >= 5
	<- .print("Setting production speed to 70%...").
	
+!slowDownProduction
     : exceptionRaised(_,exStock,_) &
       exceptionArgument(_,exStock,availablePlates(N)) &
       N >= 2
	<- .print("Setting production speed to 30%...").
	
+!slowDownProduction
     : exceptionRaised(_,exStock,_) &
       exceptionArgument(_,exStock,availablePlates(N)) &
       N <= 1
	<- .print("Temporarily stopping production...").
	
+!scheduleTableMotorFix
	<- .print("Scheduling table motor fix...").
	
+!pauseProduction
	<- .print("Pausing production...");
	   .wait(5000);
	   goalReleased(turnTableMoveUp);
	   .print("Problem solved! Production resumed").
	   
+!emergencyStop
	<- .print("***EMERGENCY STOP***");
	   goalReleased(producePlate).

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
