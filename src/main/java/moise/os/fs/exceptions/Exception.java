package moise.os.fs.exceptions;

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

public class Exception extends moise.common.MoiseElement implements ToXML, ToProlog {
    
    private String id;
    
    private NotificationPolicy inPolicy;
    
    public Exception(String id, NotificationPolicy inPolicy) {
        super();
        this.id = id;
        this.inPolicy = inPolicy;
    }
    
    public String getId() {
        return id;
    }

    public NotificationPolicy getInPolicy() {
        return inPolicy;
    }
    
    public static String getXMLTag() {
        return "exception";
    }
    
    public void setFromDOM(Element ele) throws MoiseException {
        
        setPropertiesFromDOM(ele);
        
//        String type = (String) getProperty("type");
//        boolean found = false;
//        int i = 0;
//        ExceptionType et = null;
//        while(!found && i < exceptionTypes.length) {
//            if(exceptionTypes[i].getType().equals(type)) {
//                et = exceptionTypes[i];
//                found = true;
//            }
//            i++;
//        }
//        if(!found) {
//            throw new MoiseException("Exception type " + type + " in exception " + id + " undefined!");
//        }
//        String[] arguments = et.getArguments();
//        String cond = et.getFaultState();
//        for(String arg : arguments) {
//            String argValue = (String) getProperty(arg);
//            if(argValue == null) {
//                throw new MoiseException("Missing argument " + arg + "in exception " + id);
//            }
//            cond = cond.replace("$" + arg, argValue);
//        }
//        
//        try {
//            condition = ASSyntax.parseFormula(cond);
//        } catch (ParseException e) {
//            throw new MoiseException(e.getMessage());
//        }
//        
//        
//        Element gEle = DOMUtils.getDOMDirectChild(ele, Goal.getXMLTag());
//        if(gEle != null) {
//            goal = new Goal(gEle.getAttribute("id"));
//            goal.setFromDOM(gEle, sch);
//            sch.addGoal(goal);
//        }
        
    }
    
    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
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
