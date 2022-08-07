treatment(headache,ibuprofen).
treatment(fever,paracetamol).

+!receiveComplain : symptom(S)
	<- .print("Complaint from patient received! The symptom is ",S).

+!sendPrescribe : symptom(Symptom)[source(Patient)] & treatment(Symptom,Drug)
	<- .print("Sending prescription to pharmacist...");
	   .send(pharmacist,tell,prescription(Drug,Patient)).

+!resendPrescribe : symptom(Symptom)[source(Patient)] & treatment(Symptom,Drug)
	<- .print("*** RESENDING prescription to pharmacist...");
	   .send(pharmacist,tell,prescription(Drug,Patient)).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
