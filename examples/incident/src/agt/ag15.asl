+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(dev_sch,pff2ls,Ag)=What &
	   scheme(dev_sch,_,SchId) &
	   result(solved)
	<- .print("Providing feedback to second level support...");
	   goalAchieved(pff2ls)[artifact_id(SchId)].
	   
+obligation(Ag,_,What,_)
	 : .my_name(Ag) &
	   done(dev_sch,pff2ls,Ag)=What &
	   scheme(dev_sch,_,SchId) &
	   not result(solved)
	<- .print("Failure in providing feedback to second level support!");
	   goalFailed(pff2ls)[artifact_id(SchId)].

+obligation(Ag,_,raised(_,raise_pff2ls),_)
	 : .my_name(Ag)
	<- .print("Raising exception explaining failure...");
	   exceptionRaised(raise_pff2ls,fail_dev).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }