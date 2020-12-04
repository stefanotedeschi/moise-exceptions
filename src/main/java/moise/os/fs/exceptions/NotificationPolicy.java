package moise.os.fs.exceptions;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.LogicalFormula;
import moise.common.MoiseException;
import moise.os.fs.Goal;
import moise.os.fs.Scheme;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

public class NotificationPolicy extends moise.common.MoiseElement implements ToXML, ToProlog {
    
    private String id;
    private LogicalFormula condition;
    private Exception exception;
    private RecoveryStrategy inStrategy;
    private ThrowingGoal goal;
    private Scheme sch;
    
    public NotificationPolicy(String id, LogicalFormula condition, RecoveryStrategy rs, Scheme sch) {
        super();
        this.id = id;
        this.condition = condition;
        inStrategy = rs;
        this.sch = sch;
    }

    public String getId() {
        return id;
    }
    
    public LogicalFormula getCondition() {
        return condition;
    }
    
    public Exception getException() {
        return exception;
    }

    public RecoveryStrategy getInStrategy() {
        return inStrategy;
    }
    
    public ThrowingGoal getGoal() {
        return goal;
    }

    public void setFromDOM(Element ele) throws MoiseException {
        setPropertiesFromDOM(ele);
        Element gEle = DOMUtils.getDOMDirectChild(ele, Goal.getXMLTag());
        if(gEle != null) {
            goal = new ThrowingGoal(gEle.getAttribute("id"), this);
            goal.setFromDOM(gEle, sch);
            sch.addGoal(goal);
        }
        Element exEle = DOMUtils.getDOMDirectChild(ele, Exception.getXMLTag());
        if(exEle != null) {
            exception = new Exception(exEle.getAttribute("id"), this);
            exception.setFromDOM(exEle);
        }
    }

    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        ele.setAttribute("condition", condition.toString());
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
        }
        if(exception != null) {
            ele.appendChild(exception.getAsDOM(document));
        }
        if(goal != null) {
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
