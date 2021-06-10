// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

+!turnTableMoveUp
	<- println("Turning table and moving up...");
	   println("Unable to move up!");
	   goalFailed(turnTableMoveUp)
	   .fail.
	
+!turnTableMoveDown
	<- println("Turning table and moving down...").
	
+!notifyStoppedMotorNumber
	<- println("The broken motor is the number 2");
	   throwException(exMotor,[motorNumber(2)]).

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
