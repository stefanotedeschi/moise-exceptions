+obl(Ag,done(Ag,HG))
   : ...
  <- ...
     // releaseGoal(G,HG);
     resetGoal(G);
     goalAchieved(HG).

     controllo con regimentazione che continueExecution si possa fare solo quando HG è attivo

+obl(Ag,done(Ag,TG))
   : ...
  <- ...
     throwException(TG,E,Args);
     goalAchieved(TG).
