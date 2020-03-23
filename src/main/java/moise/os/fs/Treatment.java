package moise.os.fs;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import moise.xml.DOMUtils;

public class Treatment {

    private String id;
    private Report report;
    private Goal goal;
    
    public Treatment(String id, Report report) {
        super();
        this.id = id;
        this.report = report;
    }

    public String getId() {
        return id;
    }

    public Report getReport() {
        return report;
    }

    public Goal getGoal() {
        return goal;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setReport(Report report) {
        this.report = report;
    }

    public void setGoal(Goal goal) {
        this.goal = goal;
    }
    
    public void setFromDOM(Element ele, Scheme sch) {
        Element gEl = DOMUtils.getDOMDirectChild(ele, Goal.getXMLTag());
        if(gEl != null) {
            Goal g = sch.getGoal(gEl.getAttribute("id"));
            setGoal(g);
        }
    }
    
    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        ele.setAttribute("reporting", report.getId());
        if(goal != null) {
            Element eg = (Element) document.createElement(Goal.getXMLTag());
            eg.setAttribute("id", goal.getId());
            ele.appendChild(eg);
        }
        return ele;
    }
    
    public static String getXMLTag() {
        return "treatment";
    }
    
}
