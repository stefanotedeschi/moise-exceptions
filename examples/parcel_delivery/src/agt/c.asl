// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

+!unloadFromTruck
	<- println("Unloading parcel from truck...").
	
+!bringParcelToCustomerDoor
	<- println("Bringing parcel to customer door...").
	
+!collectProofOfDelivery
	<- println("Collecting proof of delivery...").

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
