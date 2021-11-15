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
