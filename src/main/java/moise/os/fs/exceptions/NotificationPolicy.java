package moise.os.fs.exceptions;

import java.util.Collection;
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

public class NotificationPolicy extends moise.common.MoiseElement implements ToXML, ToProlog {

    private String id;
    private Goal target;
    private HashMap<String,ExceptionSpec> exceptionSpecs = new HashMap<>();
    private Scheme sch;

//    public NotificationPolicy(String id, LogicalFormula condition, RecoveryStrategy rs, Scheme sch) {
//        super();
//        this.id = id;
//        this.condition = condition;
//        inStrategy = rs;
//        this.sch = sch;
//    }
    
    public NotificationPolicy(String id, String target, Scheme sch) {
        super();
        this.id = id;
        this.target = sch.getGoal(target);
        this.sch = sch;
    }

    public String getId() {
        return id;
    }

    public Goal getTarget() {
        return target;
    }

    public Collection<ExceptionSpec> getExceptionSpecs() {
        return exceptionSpecs.values();
    }
    
    public void addExceptionSpec(ExceptionSpec ex) {
        exceptionSpecs.put(ex.getId(), ex);
    }

    public void setFromDOM(Element ele) throws MoiseException {
        setPropertiesFromDOM(ele);
        for(Element exEle : DOMUtils.getDOMDirectChilds(ele, ExceptionSpec.getXMLTag())) {
            ExceptionSpec ex = new ExceptionSpec(exEle.getAttribute("id"), this, sch);
            ex.setFromDOM(exEle);
            addExceptionSpec(ex);
        }
    }

    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        ele.setAttribute("target", target.getId());
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
        }
        for(ExceptionSpec ex : exceptionSpecs.values()) {
            ele.appendChild(ex.getAsDOM(document));
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
