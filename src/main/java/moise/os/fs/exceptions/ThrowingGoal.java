package moise.os.fs.exceptions;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.LogicalFormula;

public class ThrowingGoal extends ExceptionGoal {

    public ThrowingGoal(String goal, LogicalFormula when, ExceptionSpec inExceptionSpec) {
        super(goal, when, inExceptionSpec);
    }

    public static String getXMLTag() {
        return "throwing-goal";
    }
    
    @Override
    public Element getAsDOM(Document document) {
        Element ele = super.getAsDOM(document);
        document.renameNode(ele,null,"throwing-goal");
        return ele;
    }

}
