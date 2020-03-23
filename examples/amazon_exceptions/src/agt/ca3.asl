
problem.

+obligation(Ag,_,done(_,deliverItems,Ag),_)[artifact_id(ArtId)]
	 : not problem &
	   goalArgument(_,shipOrder,"recipient",Recipient)
	<- println("Delivering items...");
	   .send(Recipient,tell,order);
	   goalAchieved(deliverItems)[artifact_id(ArtId)].

+obligation(Ag,_,done(_,deliverItems,Ag),_)[artifact_id(ArtId)]
	 : problem
	<- println("Problem in delivering items!");
	   goalFailed(deliverItems)[artifact_id(ArtId)].

+obligation(Ag,_,thrown(_,throwDeliverItems),_)[artifact_id(ArtId)]
     : goalArgument(_,shipOrder,"recipient",Recipient)
	<- println("Throwing exception for deliver items... Items lost!");
	   exceptionThrown(throwDeliverItems,itemsLost,[recipient(Recipient)])[artifact_id(ArtId)].

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
