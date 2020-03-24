package moise.os.fs;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import moise.xml.DOMUtils;

public class Handler {

    private String id;
    private Exception exception;
    private Goal goal;
    
    public Handler(String id, Exception exception) {
        super();
        this.id = id;
        this.exception = exception;
    }

    public String getId() {
        return id;
    }

    public Exception getException() {
        return exception;
    }

    public Goal getGoal() {
        return goal;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setException(Exception exception) {
        this.exception = exception;
    }

    public void setGoal(Goal goal) {
        this.goal = goal;
    }
    
    public void setFromDOM(Element ele, Scheme sch) {
        Element gEl = DOMUtils.getDOMDirectChild(ele, Goal.getXMLTag());
        if(gEl != null) {
            Goal g = sch.getGoal(gEl.getAttribute("id"));
            setGoal(g);
            g.setInHandler(this);
        }
    }
    
    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        ele.setAttribute("target", exception.getId());
        if(goal != null) {
            Element eg = (Element) document.createElement(Goal.getXMLTag());
            eg.setAttribute("id", goal.getId());
            ele.appendChild(eg);
        }
        return ele;
    }
    
    public static String getXMLTag() {
        return "handler";
    }
    
    @Override
    public String toString() {
        return id;
    }
    
}
