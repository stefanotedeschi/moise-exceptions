
available(raspberries).
available(chocolate).

+!dealWithMissingIngredients
     : exceptionRaised(_,ingredientsUnavailable,_) &
       exceptionArgument(_,ingredientsUnavailable,missingIngredients(I)) &
       .member(strawberries,I) &
       available(raspberries)
	<- .print("I will use ",raspberries," instead of ",strawberries);
	   goalReleased(provideIngredients).
	   
+!mixIngredients
	<- .print("Mixing ingredients...").
	   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
