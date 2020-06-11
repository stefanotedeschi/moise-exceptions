package moise.os.fs;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.Literal;
import jason.asSyntax.LogicalFormula;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

public class Exception extends moise.common.MoiseElement implements ToXML, ToProlog {
    
    private String id;
    private LogicalFormula condition;
    private Goal goal;
    
    public Exception(String id, LogicalFormula condition) {
        super();
        this.id = id;
        this.condition = condition;
    }
    public String getId() {
        return id;
    }
    public LogicalFormula getCondition() {
        return condition;
    }
    public Goal getGoal() {
        return goal;
    }
    public void setId(String id) {
        this.id = id;
    }
    public void setCondition(LogicalFormula condition) {
        this.condition = condition;
    }
    public void setGoal(Goal goal) {
        this.goal = goal;
    }
    
    public static String getXMLTag() {
        return "exception";
    }
    
    public void setFromDOM(Element ele, Scheme sch) {
        Element gEle = DOMUtils.getDOMDirectChild(ele, Goal.getXMLTag());
        if(gEle != null) {
            Goal g = sch.getGoal(gEle.getAttribute("id"));
            setGoal(g);
            g.setInException(this);
            sch.addGoal(g);
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
	@Override
	public String getAsProlog() {
		// TODO Auto-generated method stub
		return null;
	}

}
