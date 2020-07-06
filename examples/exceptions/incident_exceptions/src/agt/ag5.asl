+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(am_sch,es1,Ag)=What &
	   scheme(am_sch,_,SchId) &
	   group(GroupName,key_account_management_group,_) &
	   play(C,customer,GroupName)
	<- println("Explaining solution...");
	   .send(C,tell,solution);
	   goalAchieved(es1)[artifact_id(SchId)].

+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(am_sch,es2,Ag)=What &
	   scheme(am_sch,_,SchId) &
	   group(GroupName,key_account_management_group,_) &
	   play(C,customer,GroupName)
	<- println("Explaining solution...");
	   .send(C,tell,solution);
	   goalAchieved(es2)[artifact_id(SchId)]. 

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }