!start.

+!start
	<- .wait(1000);
	   !solve_a_problem.

+!solve_a_problem
     : group(GroupName,key_account_management_group,_) &
	   play(Am,key_account_manager,GroupName)
	<- .send(Am, tell, problem).

+ask_description[source(Sender)]
	 : description(D)
	<- println("Sending description...");
	   .send(Sender,tell,description(D)).
	   
+solution(S)
	<- println("Problem solved through ", S, ". Thank you!").
	
+cancel_request
	<- println("Too bad =(").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }