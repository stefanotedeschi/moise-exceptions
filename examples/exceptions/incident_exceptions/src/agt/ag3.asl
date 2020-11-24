+obligation(Ag,_,What,_)
	 : done(am_sch,gd,Ag)=What &
	   .my_name(Ag) &
	   scheme(am_sch,_,SchId) &
	   group(GroupName,key_account_management_group,_) &
	   play(C,customer,GroupName)
	<- println("Getting description...");
	   .send(C,tell,ask_description).

+description(D)
	 : scheme(am_sch,_,SchId) &
	   group(GroupName,key_account_management_group,_) &
	   play(Am,key_account_manager,GroupName)
	<- println("Description received!")
	   .send(Am,tell,description(D));
	   goalAchieved(gd)[artifact_id(SchId)].
	   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }