package moise.os.fs.exceptions;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.LogicalFormula;

public class RaisingGoal extends ExceptionGoal {

    public RaisingGoal(String goal, LogicalFormula when, ExceptionSpecification inExceptionSpecification) {
        super(goal, when, inExceptionSpecification);
    }

    public static String getXMLTag() {
        return "raising-goal";
    }
    
    @Override
    public Element getAsDOM(Document document) {
        Element ele = super.getAsDOM(document);
        document.renameNode(ele,null,"raising-goal");
        return ele;
    }

}
