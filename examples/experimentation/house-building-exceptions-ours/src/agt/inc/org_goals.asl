// plan to execute organisational goals

+!site_prepared      // the goal (introduced by the organisational obligation)
   <- println("Preparing site...");
      prepareSite;
      println("Done!").

+!floors_laid                   <- println("Laying floors...");layFloors;println("Done!").
+!walls_built                   <- println("Building walls...");buildWalls;println("Done!").
+!roof_built                    <- println("Building roof...");buildRoof;println("Done!").
//+!windows_fitted                <- println("Fitting windows...");.wait(2000);fitWindows;println("Done!").
+!doors_fitted                  <- println("Fitting doors...");fitDoors;println("Done!").
+!electrical_system_installed   <- println("Installing electrical system...");installElectricalSystem;println("Done!").
+!plumbing_installed            <- println("Installing plumbing...");installPlumbing;println("Done!").
+!exterior_painted              <- println("Painting exterior...");paintExterior;println("Done!").
+!interior_painted              <- println("Painting interior...");paintInterior;println("Done!").

+!handle_windows_fitting_delay
    : exceptionThrown(bhsch,windows_delay_exception,Company) &
      exceptionArgument(bhsch,windows_delay_exception,weeksOfDelay(D)) &
      not .my_name(Company)
   <- println("There is a delay in windows fitting by ",Company, " of ",D," weeks! I can reschedule my tasks");
      // Do something to handle the delay
      .

+!handle_windows_fitting_delay
    : exceptionThrown(bhsch,windows_delay_exception,Company) &
      exceptionArgument(bhsch,windows_delay_exception,weeksOfDelay(D)) &
      .my_name(Company)
   <- println("There is a delay in windows fitting but I already know it... It's my fault");
      // Do something to handle the delay
      .