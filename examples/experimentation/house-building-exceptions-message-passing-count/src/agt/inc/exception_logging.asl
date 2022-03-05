+exception(_,_,_)
    : loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      .print("************EXCEPTION").

+handlerProposal(_,_)
    : loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      .print("************HANDLER PROPOSAL").

+handlerProposalAccepted(_,_)
    : loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      .print("************HANDLER PROPOSAL ACCEPTED").

+handled(_,_)
    : loggerArtifact(LogArtId)
   <- logInc[artifact_id(LogArtId)];
      .print("************HANDLED").