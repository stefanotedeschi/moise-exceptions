
+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(dev_sch,ep,Ag)=What &
	   scheme(dev_sch,_,SchId)
	<- println("Examining problem...");
	   goalAchieved(ep)[artifact_id(SchId)].

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }