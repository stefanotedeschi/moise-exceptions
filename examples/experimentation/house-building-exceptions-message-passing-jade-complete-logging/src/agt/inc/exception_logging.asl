+exception(_,_,_)
    : loggerArtifact(LogArtId)
   <- logMessage[artifact_id(LogArtId)].

+handlerProposal(_,_)
    : loggerArtifact(LogArtId)
   <- logMessage[artifact_id(LogArtId)].

+handlerProposalAccepted(_,_)
    : loggerArtifact(LogArtId)
   <- logMessage[artifact_id(LogArtId)].

+handled(_,_)
    : loggerArtifact(LogArtId)
   <- logMessage[artifact_id(LogArtId)].