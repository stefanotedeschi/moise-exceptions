+obligation(Ag,_,What,_)
	 : done(fls_sch,h1li,Ag)=What &
	   .my_name(Ag) &
	   scheme(fls_sch,_,SchId) &
	   group(GroupName,first_level_support_group,_) &
	   play(Flm,first_level_manager,GroupName) &
	   result(R)
	<- println("Handling first level issues...");
	   .send(Flm,tell,result(R));
	   goalAchieved(h1li)[artifact_id(SchId)].
	   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }