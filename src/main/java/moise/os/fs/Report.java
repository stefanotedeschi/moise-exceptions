package moise.os.fs;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.Literal;
import moise.xml.DOMUtils;

public class Report {
    
    private String id;
    private Literal condition;
    private Goal goal;
    
    public Report(String id, Literal condition) {
        super();
        this.id = id;
        this.condition = condition;
    }
    public String getId() {
        return id;
    }
    public Literal getCondition() {
        return condition;
    }
    public Goal getGoal() {
        return goal;
    }
    public void setId(String id) {
        this.id = id;
    }
    public void setCondition(Literal condition) {
        this.condition = condition;
    }
    public void setGoal(Goal goal) {
        this.goal = goal;
    }
    
    public static String getXMLTag() {
        return "report";
    }
    
    public void setFromDOM(Element ele, Scheme sch) {
        Element gEle = DOMUtils.getDOMDirectChild(ele, Goal.getXMLTag());
        if(gEle != null) {
            Goal g = sch.getGoal(gEle.getAttribute("id"));
            setGoal(g);
        }
    }
    
    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        ele.setAttribute("when", condition.toString());
        if(goal != null) {
            Element eg = (Element) document.createElement(Goal.getXMLTag());
            eg.setAttribute("id", goal.getId());
            ele.appendChild(eg);
        }
        return ele;
    }
    
    @Override
    public String toString() {
        return id;
    }

}
