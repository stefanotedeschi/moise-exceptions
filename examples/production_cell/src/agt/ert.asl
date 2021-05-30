// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

+!turnTableMoveUp
	<- println("Turning table and moving up...").
	
+!turnTableMoveDown
	<- println("Turning table and moving down...").

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
