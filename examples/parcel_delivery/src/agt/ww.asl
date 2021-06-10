// Agent sample_agent in project parseInt

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

+!takeGoodsFromWarehouse
	<- println("Taking goods from warehouse...").
	
+!packUpGoods
	<- println("Packing up goods...").
	
+!loadOnTruck
	<- println("Loading parcel on truck...").

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
