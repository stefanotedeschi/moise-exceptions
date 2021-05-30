+obligation(Ag,_,done(am_sch,ask_1st_level_support,Ag),_)
	 : .my_name(Ag) &
	   scheme(am_sch,_,SchId) &
	   group(_,first_level_support_group,GrArtId)
	<- println("Asking support to first level...");
	   createScheme(fls_sch, scheme_1st_level_support, SchArtId);
	   debug(inspector_gui(on))[artifact_id(SchArtId)];
	   addScheme(fls_sch)[artifact_id(GrArtId)].
	   
+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(fls_sch,expf1ls1,Ag)=What &
	   scheme(am_sch,_,AmSchId) &
	   scheme(fls_sch,_,FlsSchId)
	<- println("Failure received from first level support!");
	   goalFailed(ask1ls)[artifact_id(AmSchId)];
	   goalAchieved(expf1ls1)[artifact_id(FlsSchId)].
	   
+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(fls_sch,expf1ls2,Ag)=What &
	   scheme(am_sch,_,AmSchId) &
	   scheme(fls_sch,_,FlsSchId)
	<- println("Failure received from first level support!");
	   goalFailed(ask1ls)[artifact_id(AmSchId)];
	   goalAchieved(expf1ls2)[artifact_id(FlsSchId)].
	   
+obligation(Ag,_,thrown(_,throw_ask1ls),_)
	 : .my_name(Ag) &
	   scheme(am_sch,_,SchId)
	<- println("Explaining failure due to failure in first level support...");
	   exceptionThrown(throw_ask1ls,cancel1lsreq,[motivo(m1),motivo(m2)])[artifact_id(SchId)].
	   
+obligation(Ag,_,done(fls_sch,result_solved,Ag),_)
	 : .my_name(Ag) &
	   result(solved) &
	   scheme(fls_sch,_,SchId)
	<- println("Problem solved!");
	   goalAchieved(result_solved)[artifact_id(SchId)].
	   
+obligation(Ag,_,done(fls_sch,result_2nd_level_issue,Ag),_)
	 : .my_name(Ag) &
	   result(unsolved) &
	   scheme(fls_sch,_,SchId)
	<- println("The problem has not been solved! Second level support needed");
	   goalAchieved(result_2nd_level_issue)[artifact_id(SchId)].

+feedback(F)
	 : group(GroupName,key_account_management_group,_) &
	   play(AMW,key_account_worker_3,GroupName) &
	   scheme(am_sch,_,SchId)
	<- println("Feedback received from first level support!");
	   .send(AMW,tell,feedback(F));
	   goalAchieved(ask_1st_level_support)[artifact_id(SchId)].

+obligation(Ag,_,done(fls_sch,root_1st_level_support,Ag),_)
	 : .my_name(Ag) &
	   scheme(fls_sch,_,SchId)
	<- println("*** SCHEME FIRST LEVEL SUPPORT COMPLETED ***");
	   goalAchieved(root_1st_level_support)[artifact_id(SchId)].

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }