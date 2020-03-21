package moise.os.fs;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import moise.common.MoiseElement;
import moise.common.MoiseException;
import moise.os.fs.Plan.PlanOpType;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class Handler extends MoiseElement implements ToXML, ToProlog {

    private static final long serialVersionUID = 1L;

    protected Goal inGoal = null; // the goal this handler belongs to
    protected Exception exception = null; // the exception related to this handler
    protected Goal goal = null; // the goal to be executed to handle the exception

    public Handler(String handler) {
        setId(handler);
    }

    public Goal getInGoal() {
        return inGoal;
    }

    public Exception getException() {
        return exception;
    }

    public Goal getGoal() {
        return goal;
    }

    public void setInGoal(Goal inGoal) {
        this.inGoal = inGoal;
    }

    public void setException(Exception exception) {
        this.exception = exception;
    }

    public void setGoal(Goal goal) {
        this.goal = goal;
    }

    public static String getXMLTag() {
        return "handler";
    }

    /** returns a string representing the goal in Prolog syntax, format:
     *     goal(id, type, description, #ags to satisfy,time to fulfill, list of arguments, plan)[location(L)]
     */
    public String getAsProlog() {
        StringBuilder s = new StringBuilder("handler("+getId()+","+goal.getId()+")"); //TODO
        return s.toString();
    }

    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        ele.setAttribute("target", exception.getId());
        ele.appendChild(getGoal().getAsDOM(document));
        return ele;
    }

    public void setFromDOM(Element ele, Goal inGoal, Scheme sch) throws MoiseException {
        setPropertiesFromDOM(ele);
        setInGoal(inGoal);
        exception = sch.getException(ele.getAttribute("target"));
        Element eg = DOMUtils.getDOMDirectChild(ele, Goal.getXMLTag());
        if (eg != null) {
            Goal g = new Goal(eg.getAttribute("id"));
            sch.addGoal(g);
            g.setFromDOM(eg, sch);
            g.setInHandler(this);
            goal = g;
        }
    }
}
