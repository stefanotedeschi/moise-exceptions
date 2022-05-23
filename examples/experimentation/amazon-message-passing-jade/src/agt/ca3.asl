
problem.

+obligation(Ag,_,done(_,deliverItems,Ag),_)[artifact_id(ArtId)]
	 : not problem &
	   goalArgument(_,shipOrder,"recipient",Recipient)
	<- .print("Delivering items...");
	   .send(Recipient,tell,order);
	   goalAchieved(deliverItems)[artifact_id(ArtId)].

+obligation(Ag,_,done(_,deliverItems,Ag),_)[artifact_id(ArtId)]
	 : problem & .my_name(Ag) &
       goalArgument(_,shipOrder,"recipient",Recipient) &
       play(Handler,carrierCustomerCareRepresentative,gca)
	<- .print("Problem in delivering items!");
	   .send(Handler,tell,exception(itemsLost,[recipient(Recipient)])).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
