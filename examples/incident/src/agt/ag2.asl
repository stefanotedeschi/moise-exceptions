+problem
	 : group(_,key_account_management_group,GrArtId)
	<- println("Customer has a problem! Starting Key Account Management process...");
	   createScheme(am_sch, scheme_account_manager, SchArtId);
	   debug(inspector_gui(on))[artifact_id(SchArtId)];
	   addScheme(am_sch)[artifact_id(GrArtId)].

+obligation(Ag,_,done(am_sch,can_handle,Ag),_)
	 : .my_name(Ag) &
	   description(easy_problem) &
	   scheme(am_sch,_,SchId)
	<- println("The problem can be handled at this level!");
	   goalAchieved(can_handle)[artifact_id(SchId)].
	   
+obligation(Ag,_,done(am_sch,cannot_handle,Ag),_)
	 : .my_name(Ag) &
	   description(hard_problem) &
	   scheme(am_sch,_,SchId)
	<- println("The problem cannot be handled at this level! First level support needed");
	   goalAchieved(cannot_handle)[artifact_id(SchId)].
	   
+obligation(Ag,_,done(am_sch,root_account_manager,Ag),_)
	 : .my_name(Ag) &
	   scheme(am_sch,_,SchId)
	<- println("*** SCHEME KEY ACCOUNT MANAGER COMPLETED ***");
	   goalAchieved(root_account_manager)[artifact_id(SchId)].
	   
+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(am_sch,cpr,Ag)=What &
	   scheme(am_sch,_,SchId) &
	   group(GroupName,key_account_management_group,_) &
	   play(C,customer,GroupName)
	<- println("Canceling problem request...");
	   .send(C,tell,cancel_request);
	   goalAchieved(cpr)[artifact_id(SchId)].

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }