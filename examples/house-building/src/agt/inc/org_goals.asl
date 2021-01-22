// plan to execute organisational goals

+!site_prepared      // the goal (introduced by the organisational obligation)
   <- println("Preparing site...");
      .wait(2000);
      prepareSite;
      println("Done!").

+!floors_laid                   <- println("Laying floors...");.wait(2000);layFloors;println("Done!").
+!walls_built                   <- println("Building walls...");.wait(2000);buildWalls;println("Done!").
+!roof_built                    <- println("Building roof...");.wait(2000);buildRoof;println("Done!").
+!windows_fitted                <- println("Fitting windows...");.wait(2000);fitWindows;println("Done!").
+!doors_fitted                  <- println("Fitting doors...");.wait(2000);fitDoors;println("Done!").
+!electrical_system_installed   <- println("Installing electrical system...");.wait(2000);installElectricalSystem;println("Done!").
+!plumbing_installed            <- println("Installing plumbing...");.wait(2000);installPlumbing;println("Done!").
+!exterior_painted              <- println("Painting exterior...");.wait(2000);paintExterior;println("Done!").
+!interior_painted              <- println("Painting interior...");.wait(2000);paintInterior;println("Done!").
