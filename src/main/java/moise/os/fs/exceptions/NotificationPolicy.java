package moise.os.fs.exceptions;

import java.util.HashMap;
import java.util.Map;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.LogicalFormula;
import jason.asSyntax.parser.ParseException;
import moise.common.MoiseException;
import moise.os.fs.Goal;
import moise.os.fs.Scheme;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

public class NotificationPolicy extends moise.common.MoiseElement implements ToXML, ToProlog, Policy {

    private String id;
    private PolicyCondition condition;
    private ExceptionType exceptionType;
    private RecoveryStrategy inStrategy;
    private ThrowingGoal goal;
    private Scheme sch;

//    public NotificationPolicy(String id, LogicalFormula condition, RecoveryStrategy rs, Scheme sch) {
//        super();
//        this.id = id;
//        this.condition = condition;
//        inStrategy = rs;
//        this.sch = sch;
//    }
    
    public NotificationPolicy(String id, RecoveryStrategy rs, Scheme sch) {
        super();
        this.id = id;
        inStrategy = rs;
        this.sch = sch;
    }

    public String getId() {
        return id;
    }

    public PolicyCondition getCondition() {
        return condition;
    }

    public ExceptionType getExceptionType() {
        return exceptionType;
    }

    public RecoveryStrategy getInStrategy() {
        return inStrategy;
    }

    public ThrowingGoal getGoal() {
        return goal;
    }

    public void setFromDOM(Element ele) throws MoiseException {
        setPropertiesFromDOM(ele);
        
        Element condEle = DOMUtils.getDOMDirectChild(ele, "condition");
        if(condEle != null) {
        	condition = new PolicyCondition(condEle.getAttribute("id"), sch, this);
        	condition.setFromDOM(condEle);
        }
        else {
            throw new MoiseException("Condition missing in notification policy " + id);
        }
        
        
        Element exEle = DOMUtils.getDOMDirectChild(ele, ExceptionType.getXMLTag());
        if (exEle != null) {
            exceptionType = new ExceptionType(exEle.getAttribute("id"), this);
            exceptionType.setFromDOM(exEle);
        }
        else {
            throw new MoiseException("Exception type missing in notification policy " + id);
        }

        Element gEle = DOMUtils.getDOMDirectChild(ele, Goal.getXMLTag());
        if (gEle != null) {
            goal = new ThrowingGoal(gEle.getAttribute("id"), this);
            goal.setFromDOM(gEle, sch);
            sch.addGoal(goal);
        }
        else {
            throw new MoiseException("Throwing goal missing in notification policy " + id);
        }
        
    }

    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        //ele.setAttribute("condition", condition.toString());
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
        }
        if(condition != null) {
        	ele.appendChild(condition.getAsDOM(document));
        }
        if (exceptionType != null) {
            ele.appendChild(exceptionType.getAsDOM(document));
        }
        if (goal != null) {
            ele.appendChild(goal.getAsDOM(document));
        }
        return ele;
    }

    public static String getXMLTag() {
        return "notification-policy";
    }

    @Override
    public String toString() {
        return id;
    }

    @Override
    public String getAsProlog() {
        // TODO Auto-generated method stub
        return null;
    }

}
