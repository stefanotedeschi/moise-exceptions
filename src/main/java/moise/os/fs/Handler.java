package moise.os.fs;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import moise.common.MoiseException;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

public class Handler extends moise.common.MoiseElement implements ToXML, ToProlog  {

    private String id;
    private Goal goal;
    
    RecoveryStrategy inStrategy;
    
    private Scheme sch;
    
    public Handler(String id, RecoveryStrategy rs, Scheme sch) {
        super();
        this.id = id;
        inStrategy = rs;
        this.sch = sch;
    }

    public String getId() {
        return id;
    }

    public Goal getGoal() {
        return goal;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setGoal(Goal goal) {
        this.goal = goal;
    }
    
    public void setFromDOM(Element ele) throws MoiseException {
        setPropertiesFromDOM(ele);
        Element gEle = DOMUtils.getDOMDirectChild(ele, Goal.getXMLTag());
        if(gEle != null) {
            goal = new Goal(gEle.getAttribute("id"));
            goal.setFromDOM(gEle, sch);
            sch.addGoal(goal);
        }
    }
    
    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
        }
        if(goal != null) {
            ele.appendChild(goal.getAsDOM(document));
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

    @Override
    public String getAsProlog() {
        // TODO Auto-generated method stub
        return null;
    }
    
}
