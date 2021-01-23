
available(raspberries).
available(chocolate).

+!dealWithMissingIngredients
     : exceptionThrown(_,ingredientsUnavailable,_) &
       exceptionArgument(_,ingredientsUnavailable,missingIngredients(I)) &
       .member(strawberries,I) &
       available(raspberries)
	<- .wait(2000);
	   println("I will use ",raspberries," instead of ",strawberries);
	   goalReleased(provideIngredients).
	   
+!mixIngredients
	<- println("Mixing ingredients...").
	   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
