
+!provideIngredients
	<- println("Providing ingredients...");
	   println("Some ingredients are missing!");
	   goalFailed(provideIngredients);
	   .fail.
	   
+!notifyIngredientsUnavailability
	<- println("Notifying that strawberries are missing...");
	   throwException(ingredientsUnavailable,[missingIngredients([strawberries])]).
	   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
