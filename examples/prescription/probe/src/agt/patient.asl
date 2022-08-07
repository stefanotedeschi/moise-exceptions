//symptom(headache).
symptom(fever).

+!sendComplain : symptom(S)
	<- .print("I'm ill. Sending a complaint to the doctor...");
	   .send(doctor,tell,symptom(S)).

+!receiveFilled : filled(Treatment)
	<- .print("*** ALL DONE! I'll take a pill of ",Treatment).

+!receiveFilled : not filled(_) & not waited
	<- .wait(5000);
	   +waited;
	   !receiveFilled.

+!receiveFilled : not filled(_) & waited
	<- -waited;
	   goalFailed(receiveFilled);
	   .fail.
	
+!pollFilled
	<- .print("*** POLLING treatment from pharmacist...");
	   //.send(pharmacist,tell,poll);
	   raiseException(probe,[]).

+goalState(_,G,_,_,satisfied) : G=resendFilled | G=pollAgain
	<- resetGoal(receiveFilled).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
