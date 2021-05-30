+obligation(Ag,_,done(dev_sch,examine_problem,Ag),_)
	 : .my_name(Ag) &
	   scheme(dev_sch,_,SchId)
	<- println("Examining problem...");
	   //goalAchieved(examine_problem)[artifact_id(SchId)].
	   goalFailed(examine_problem)[artifact_id(SchId)].
	   
+obligation(Ag,_,done(dev_sch,raise_developer_exception,Ag),_)
	 : .my_name(Ag) &
	   scheme(dev_sch,_,SchId)
	<- println("Cannot examine problem, the product is out of warranty");
	   //goalAchieved(examine_problem)[artifact_id(SchId)].
	   throwException(developer_exception,[warrantyStatus(no)])[artifact_id(SchId)];
	   goalAchieved(raise_developer_exception)[artifact_id(SchId)].
	   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }