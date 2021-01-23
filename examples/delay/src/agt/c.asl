// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

+!handleDelay
     : exceptionThrown(_,delay,_) &
       exceptionArgument(_,delay,eta(N)) &
       N < 200
	<- println("I wait a little bit more...").

+!handleDelay
     : exceptionThrown(_,delay,_) &
       exceptionArgument(_,delay,eta(N)) &
       N >= 200
	<- println("I give up.");
	   goalReleased(task).

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
