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

public class Throwing extends Goal implements ToXML, ToProlog {

    private static final long serialVersionUID = 1L;

    protected Goal inGoal = null; // the goal this throwing relates to
    protected List<Exception> exceptions; // the exception that can be thrown by this throwing

    public Throwing(String id) {
        super(id);
        exceptions = new ArrayList<>();
    }

    public Goal getInGoal() {
        return inGoal;
    }

    public List<Exception> getExceptions() {
        return exceptions;
    }

    public void setInGoal(Goal inGoal) {
        this.inGoal = inGoal;
    }

    public void setExceptions(List<Exception> exceptions) {
        this.exceptions = exceptions;
    }

    public static String getXMLTag() {
        return "throwing";
    }

    /** returns a string representing the goal in Prolog syntax, format:
     *     goal(id, type, description, #ags to satisfy,time to fulfill, list of arguments, plan)[location(L)]
     */
    public String getAsProlog() {
        StringBuilder s = new StringBuilder("throwing("+getId()+","+inGoal.getId()+")"); //TODO
        return s.toString();
    }

    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        for(Exception e : exceptions) {
            ele.appendChild(e.getAsDOM(document));
        }
        return ele;
    }

    public void setFromDOM(Element ele, Goal inGoal, Scheme sch) throws MoiseException {
        setPropertiesFromDOM(ele);
        setInGoal(inGoal);
        List<Element> els = DOMUtils.getDOMDirectChilds(ele, Exception.getXMLTag());
        sch.addGoal(this);
        for(Element el : els) {
            if (el != null) {
                Exception e = new Exception(el.getAttribute("id"));
                e.setFromDOM(el, this, sch);
                exceptions.add(e);
            }
        }
    }
}
