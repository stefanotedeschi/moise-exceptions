in_stock(raspberries).


+obligation(Ag,_,done(_,dealWithMissingIngredients,Ag),_)
     : exceptionArgument(_,ingredientsUnavailable,strawberries) &
       in_stock(raspberries)
	<- goalReleased(provideIngredients).
	   //goalAchieved(dealWithMissingIngredients).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
