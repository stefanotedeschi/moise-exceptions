count(0).

+obligation(Ag,_,done(_,payOrder,Ag),_)
	 : .my_name(Ag) &
	   group(gcc,credit_card_group,GrArtId) &
	   count(C)
	<- println("Sending credit card information...");
	   sendCreditCardInfo(123456789,000);
	   .concat(ccsch,C,Scheme);
	   -count(C);
	   +count(C+1);
	   createScheme(Scheme, credit_card_sch, SchArtId);
	   addScheme(Scheme)[artifact_id(GrArtId)].
	   
+result(ok,Sch)
	<- println("Payment completed!");
	   -result(ok,Sch);
	   goalAchieved(payOrder).
   
+result(ko,Sch)
	<- println("Payment failed!");
	   -result(ko,Sch);
	   goalFailed(payOrder).
	   
+result(R)
	<- println("======",R,"======").
	   
+obligation(Ag,_,done(_,raisePaymentRefused,Ag),_)[artifact_id(ArtId)]
     : .my_name(Ag)
	<- println("Throwing exception for pay order...");
	   getBalance(B);
	   throwException(paymentRefused,[balance(B)])[artifact_id(ArtId)];
	   goalAchieved(raisePaymentRefused).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
