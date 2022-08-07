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

+!receivePrescribePatient : .my_name(Patient) & prescription(Treatment,Patient)
	<- .print("Prescription received from doctor for ",Treatment," for me.").

+!receivePrescribePatient : .my_name(Patient) & not prescription(Treatment,Patient)
	<- .wait({+prescription(Treatment,Patient)});
	   !receivePrescribePatient.
	
+!forwardPrescribe : .my_name(Patient) & prescription(Treatment,Patient)
	<- .print("*** FORWARD prescription to pharmacist...");
	   .send(pharmacist,tell,prescription(Treatment,Patient));
	   raiseException(forward,[]).

+goalState(_,receiveForwardedPrescribe,_,_,satisfied)
	<- resetGoal(receiveFilled).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
