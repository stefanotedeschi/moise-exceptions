// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

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
	
+!slowDownProduction
     : exceptionThrown(_,exStock,_) &
       exceptionArgument(_,exStock,availablePlates(N)) &
       N >= 5
	<- println("Setting production speed to 70%...").
	
+!slowDownProduction
     : exceptionThrown(_,exStock,_) &
       exceptionArgument(_,exStock,availablePlates(N)) &
       N >= 2
	<- println("Setting production speed to 30%...").
	
+!slowDownProduction
     : exceptionThrown(_,exStock,_) &
       exceptionArgument(_,exStock,availablePlates(N)) &
       N <= 1
	<- println("Temporarily stopping production...").
	
+!scheduleTableMotorFix
	<- println("Scheduling table motor fix...").
	
+!pauseProduction
	<- println("Pausing production...")
	   .wait(5000);
	   goalReleased(turnTableMoveUp);
	   println("Problem solved! Production resumed").
	   
+!emergencyStop
	<- println("***EMERGENCY STOP***")
	   goalReleased(producePlate).

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
