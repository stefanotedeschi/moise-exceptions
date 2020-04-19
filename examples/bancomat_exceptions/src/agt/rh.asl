count(1).

+!obtainAmount
     : count(N)
	<- println("Amount obtained!");
	   -count(N);
	   +count(1).
	  
//+obligation(Ag,_,done(_,recoverFromNan,Ag),_)
//    : .my_name(Ag) &
//      count(N) & N < 3
//   <- -count(N);
//      +count(N+1);
//      println("Handling exception...").
//      resetGoal(obtainAmount).
      
+obligation(Ag,_,done(_,recoverFromNan,Ag),_)
    : .my_name(Ag) //&
      //count(N) & N >= 3
   <- goalReleased(obtainAmount);
      goalFailed(recoverFromNan).
   
+obligation(Ag,_,done(_,throwAmountUnavailable,Ag),_)
	 : .my_name(Ag)
	<- println("Throwing exception!");
	   throwException(amountUnavailable,[parsificationProblem]);
	   goalAchieved(throwAmountUnavailable).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
