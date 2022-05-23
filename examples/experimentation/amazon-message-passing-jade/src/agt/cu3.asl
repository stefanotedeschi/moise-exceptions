count(0).

+obligation(Ag,_,done(_,payOrder,Ag),_)[artifact_id(ArtId)]
	 : .my_name(Ag)
	<- +cu_scheme_id(ArtId);
		!pay;
	   .
	   
+result(ok,Sch) : cu_scheme_id(ArtId)
	<- .print("Payment completed!");
	   -result(ok,Sch);
	   goalAchieved(payOrder)[artifact_id(ArtId)].
   
+result(ko,Sch) : play(Receiver,customerCheckoutManager,gcu)
	<- .print("Payment failed!");
	   -result(ko,Sch);
	   getBalance(B);
	   .send(Receiver,tell,exception(paymentRefused,[balance(B)]));
	   .

+retry <- .print("I have to try another time");
          !pay.

+!pay
	 : count(C) & group(gcc,credit_card_group,GrArtId)
	<- .print("Sending credit card information...");
	   sendCreditCardInfo(123456789,000);
	   .concat(ccsch,C,Scheme);
	   -count(C);
	   +count(C+1);
	   createScheme(Scheme, credit_card_sch, SchArtId);
	   addSchemeWhenFormationOk(Scheme)[artifact_id(GrArtId)].

+result(R)
	<- .print("======",R,"======").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
