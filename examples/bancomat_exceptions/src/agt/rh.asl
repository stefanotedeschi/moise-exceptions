count(1).

+!obtainAmount
     : count(N)
	<- println("Amount obtained!");
	   -count(N);
	   +count(1).
	  
+obligation(Ag,_,done(_,recoverFromNan,Ag),_)
    : .my_name(Ag) &
      count(N) & N < 3
   <- -count(N);
      +count(N+1);
      resetGoal(obtainAmount).
      
+obligation(Ag,_,done(_,recoverFromNan,Ag),_)
    : .my_name(Ag) &
      count(N) & N >= 3
   <- goalFailed(recoverFromNan).
   
+obligation(Ag,_,thrown(_,throwRecoverFromNan),_)
	 : .my_name(Ag)
	<- exceptionThrown(throwRecoverFromNan,amountUnavailable,[]).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
