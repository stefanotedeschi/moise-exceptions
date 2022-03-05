// plan to execute organisational goals

+!site_prepared      // the goal (introduced by the organisational obligation)
   <- .print("Preparing site...");
      prepareSite;
      .print("Done!").

+!floors_laid                   <- .print("Laying floors...");layFloors;.print("Done!").
+!walls_built                   <- .print("Building walls...");buildWalls;.print("Done!").
+!roof_built                    <- .print("Building roof...");buildRoof;.print("Done!").
//+!windows_fitted                <- .print("Fitting windows...");.wait(2000);fitWindows;.print("Done!").
+!doors_fitted                  <- .print("Fitting doors...");fitDoors;.print("Done!").
+!electrical_system_installed   <- .print("Installing electrical system...");installElectricalSystem;.print("Done!").
+!plumbing_installed            <- .print("Installing plumbing...");installPlumbing;.print("Done!").
+!exterior_painted              <- .print("Painting exterior...");paintExterior;.print("Done!").
+!interior_painted              <- .print("Painting interior...");paintInterior;.print("Done!").

+!handle_windows_fitting_delay
    : exceptionThrown(bhsch,windows_delay_exception,Company) &
      exceptionArgument(bhsch,windows_delay_exception,weeksOfDelay(D)) &
      not .my_name(Company)
   <- .print("There is a delay in windows fitting by ",Company, " of ",D," weeks! I can reschedule my tasks");
      // Do something to handle the delay
      .

+!handle_windows_fitting_delay
    : exceptionThrown(bhsch,windows_delay_exception,Company) &
      exceptionArgument(bhsch,windows_delay_exception,weeksOfDelay(D)) &
      .my_name(Company)
   <- .print("There is a delay in windows fitting but I already know it... It's my fault");
      // Do something to handle the delay
      .