
+obligation(Ag,_,done(_,provideIngredients,Ag),_)
	<- goalFailed(provideIngredients).
	   //goalAchieved(provideIngredients).
	
+obligation(Ag,_,done(_,notifyIngredientsUnavailability,Ag),_)
	<- throwException(ingredientsUnavailable,[strawberries]);
	   goalAchieved(notifyIngredientsUnavailability).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
