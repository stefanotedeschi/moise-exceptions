+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(fls_sch,ask2ls,Ag)=What &
	   scheme(fls_sch,_,SchId) &
	   group(_,developer_group,GrArtId)
	<- println("Asking support to second level...");
	   createScheme(dev_sch, scheme_dev, SchArtId);
	   debug(inspector_gui(on))[artifact_id(SchArtId)];
	   addScheme(dev_sch)[artifact_id(GrArtId)];
	   //goalAchieved(ask1ls)[artifact_id(SchId)].
	   .
	   
+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(dev_sch,expfdev,Ag)=What &
	   scheme(fls_sch,_,FlsSchId) &
	   scheme(dev_sch,_,DevSchId)
	<- println("Failure received from dev!");
	   goalFailed(ask2ls)[artifact_id(FlsSchId)];
	   goalAchieved(expfdev)[artifact_id(DevSchId)].
	   
+obligation(Ag,_,thrown(_,throw_ask2ls),_)
	 : .my_name(Ag) &
	   scheme(fls_sch,_,SchId)
	<- println("Explaining failure due to failure in dev...");
	   exceptionThrown(throw_ask2ls,cancel2lsreq)[artifact_id(SchId)].

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }