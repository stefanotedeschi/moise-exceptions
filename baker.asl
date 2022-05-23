+obl(dealWithMissingIngredients)
   : exceptionArgument(ingredientsUnavailable,strawberries) &
     in_stock(raspberries)
  <- // use raspberries instead of strawberries
     goalReleased(provideIngredients).

+obl(dealWithMissingIngredients)
   : exceptionArgument(ingredientsUnavailable,strawberries) &
     not in_stock(raspberries) &
     not alreadyRetried
  <- // wait for a while, maybe strawberries will be available again
     .wait(5000);
     resetGoal(provideIngredients).

+obl(dealWithMissingIngredients)
  <- // otherwise escalate
     goalFailed(workspaceSetup).

+obl(checkOven) <- !fixOven.
+!fixOven
  <- // try to fix oven
     goalReleased(switchOnOven).
-!fixOven
  <- goalFailed(workspaceSetup).

+obl(notifyWorkspaceSetupFailure)
   : exceptionRaised(_,ingredientsUnavailable,_) &
     exceptionArgument(ingredientsUnavailable,strawberries)
  <- raiseException(workspaceSetupFailure,[missingIngredient(strawberries)]).

+obl(notifyWorkspaceSetupFailure)
   : exceptionRaised(_,ovenBroken,_) &
  <- raiseException(workspaceSetupFailure,[toolBroken(oven)]).

...
