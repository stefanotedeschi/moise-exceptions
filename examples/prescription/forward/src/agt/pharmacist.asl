+!receivePrescribePharmacist : prescription(Treatment,Patient)
	<- .print("Prescription received from doctor for ",Treatment," for ",Patient).

+!sendFilled : prescription(Treatment,Patient)
	<- .print("Sending treatment to patient...");
	   .send(Patient,tell,filled(Treatment)).

+!receiveForwardedPrescribe : prescription(Treatment,Patient)
	<- .print("*** FORWARDED prescription received from patient for ",Treatment);
	   goalAchieved(receivePrescribePharmacist).

	   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
