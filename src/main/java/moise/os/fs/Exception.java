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

/**
 Represents a Goal (in the specification).

 @composed - plan-to-achieve - Plan
 @navassoc - type - GoalType

 @author Jomi Fred Hubner
*/
public class Exception extends MoiseElement implements ToXML, ToProlog {

    private static final long serialVersionUID = 1L;

    protected Throwing throwing = null; //the goal this exception belongs to

    public Exception(String exception) {
        setId(exception);
    }

    public void setThrowing(Throwing throwing) {
        this.throwing = throwing;
    }
    public Throwing getThrowing() {
        return throwing;
    }

    public static String getXMLTag() {
        return "exception";
    }

    /** returns a string representing the goal in Prolog syntax, format:
     *     goal(id, type, description, #ags to satisfy,time to fulfill, list of arguments, plan)[location(L)]
     */
    public String getAsProlog() {
        StringBuilder s = new StringBuilder("exception("+getId()+","+throwing.getId()+")");
        return s.toString();
    }

    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        return ele;
    }

    public void setFromDOM(Element ele, Throwing t, Scheme sch) throws MoiseException {
        setPropertiesFromDOM(ele);
        setThrowing(t);
        sch.addException(this);
    }
}
