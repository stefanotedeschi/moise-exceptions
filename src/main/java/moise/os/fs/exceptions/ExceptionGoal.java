package moise.os.fs.exceptions;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.LogicalFormula;
import moise.os.fs.Goal;

public class ExceptionGoal extends Goal {

    private ExceptionSpecification inExceptionSpecification;
    private LogicalFormula when;
    
    public ExceptionGoal(String goal, LogicalFormula when, ExceptionSpecification inExceptionSpecification) {
        super(goal);
        this.inExceptionSpecification = inExceptionSpecification;
        this.when = when;
    }
    
    public LogicalFormula getWhenCondition() {
        return when;
    }



    @Override
    public Element getAsDOM(Document document) {
        Element ele = super.getAsDOM(document);
        if(!when.toString().equals("true")) {
            ele.setAttribute("when", when.toString());
        }
        return ele;
    }
    
}
