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
