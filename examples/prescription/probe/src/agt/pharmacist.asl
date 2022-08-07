+!receivePrescribe : prescription(Treatment,Patient)
	<- .print("Prescription received from doctor for ",Treatment," for ",Patient).

+!receivePrescribe : not prescription(Treatment,Patient)
	<- .wait({+prescription(_,_)});
	   !receivePrescribe.

+!sendFilled : prescription(Treatment,Patient)
	<- .print("Sending treatment to patient...");
	   //.send(Patient,tell,filled(Treatment));
	   .

+!resendFilled : prescription(Treatment,Patient)
	<- .print("*** RESENDING treatment to patient...");
	   .send(Patient,tell,filled(Treatment)).

+!pollPrescribe
	<- .print("*** POLLING again treatment from doctor...");
	   //.send(doctor,tell,poll);
	   .
	   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
