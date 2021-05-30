+obligation(Ag,_,done(dev_sch,provide_feedback_for_2nd_level_support,Ag),_)
	 : .my_name(Ag) &
	   scheme(dev_sch,_,DevSchId) &
	   result(R) &
	   (R=solved | R=next_release) & 
	   group(GroupName,developer_group,_) &
	   play(DM,developer_manager,GroupName)
	<- println("Providing feedback to second level support...");
	   .send(DM,tell,result(R))
	   goalAchieved(provide_feedback_for_2nd_level_support)[artifact_id(DevSchId)].
	   
+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(dev_sch,pff2ls,Ag)=What &
	   scheme(dev_sch,_,SchId) &
	   not (result(R) & (R=solved | R=next_release))
	<- println("Failure in providing feedback to second level support!");
	   goalFailed(provide_feedback_for_2nd_level_support)[artifact_id(SchId)].

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }