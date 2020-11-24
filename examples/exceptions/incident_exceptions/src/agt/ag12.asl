+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(dev_sch,pff2ls,Ag)=What &
	   scheme(dev_sch,_,SchId) &
	   result(solved)
	<- println("Providing feedback to second level support...");
	   goalAchieved(pff2ls)[artifact_id(SchId)].
	   
+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(dev_sch,pff2ls,Ag)=What &
	   scheme(dev_sch,_,SchId) &
	   not result(solved)
	<- println("Failure in providing feedback to second level support!");
	   goalFailed(pff2ls)[artifact_id(SchId)].

+obligation(Ag,_,thrown(_,throw_pff2ls),_)
	 : .my_name(Ag)
	<- println("Throwing exception explaining failure...");
	   exceptionThrown(throw_pff2ls,fail_dev).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("common.asl") }