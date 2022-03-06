package moise.os.fs.exceptions;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.LogicalFormula;

public class CatchingGoal extends ExceptionGoal {

    public CatchingGoal(String goal, LogicalFormula when, ExceptionSpec inExceptionSpec) {
        super(goal, when, inExceptionSpec);
    }

    public static String getXMLTag() {
        return "catching-goal";
    }
    
    @Override
    public Element getAsDOM(Document document) {
        Element ele = super.getAsDOM(document);
        document.renameNode(ele,null,"catching-goal");
        return ele;
    }

}
