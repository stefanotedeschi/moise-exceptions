+exception(_,_,_)
    : loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      println("************EXCEPTION").

+handlerProposal(_,_)
    : loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      println("************HANDLER PROPOSAL").

+handlerProposalAccepted(_,_)
    : loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      println("************HANDLER PROPOSAL ACCEPTED").

+handled(_,_)
    : loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      println("************HANDLED").