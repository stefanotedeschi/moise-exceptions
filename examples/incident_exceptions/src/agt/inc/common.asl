
+!join(OrgArtName,GrArtName,RoleName)
   <- !in_ora4mas;
      lookupArtifact(OrgArtName,OrgArtId);
      +orgArt(OrgArtName,OrgArtId);
      focus(OrgArtId);
      lookupArtifact(GrArtName,GrArtId);
      +grArt(GrArtName,GrArtId);
      adoptRole(RoleName)[artifact_id(GrArtId)];
      focus(GrArtId).

+?formationStatus(ok)[artifact_id(G)]
   <- .wait({+formationStatus(ok)[artifact_id(G)]}).
   
+?goalState(Scheme,Goal,X,Y,satisfied)[artifact_id(G)]
   <- .wait({+goalState(Scheme,Goal,X,Y,satisfied)[artifact_id(G)]}).

+!in_ora4mas : in_ora4mas.
+!in_ora4mas : .intend(in_ora4mas)
   <- .wait({+in_ora4mas},100,_);
      !in_ora4mas.
@lin[atomic]
+!in_ora4mas
   <- joinWorkspace("ora4mas",_);
      +in_ora4mas.

// obligation to commit to a mission
+obligation(Ag,Norm,committed(Ag,Mission,Scheme),Deadline)[artifact_id(ArtId),workspace(_,_,W)]
    : .my_name(Ag)
   <- .print("I am obliged to commit to ",Mission," on ",Scheme,"... doing so");
      commitMission(Mission)[artifact_name(Scheme), wid(W)].
      
// an unknown type of obligation was received
//+obligation(Ag,Norm,What,DeadLine)
//   : .my_name(Ag)
//   <- .print("I am obliged to ",What,", but I don't know what to do!").

// drop intentions for obligations that are not active anymore
-obligation(Ag,_,What,_)
   :  .my_name(Ag) & (satisfied(Scheme,Goal)=What | done(Scheme,Goal,Ag)=What) &
      .intend(Goal)
   <- .print("I am not obliged to ",Goal," anymore, dropping the intention.");
      .drop_intention(Goal).