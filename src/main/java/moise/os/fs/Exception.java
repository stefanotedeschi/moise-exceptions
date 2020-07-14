package moise.os.fs;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.LogicalFormula;
import jason.asSyntax.parser.ParseException;
import moise.common.MoiseException;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

public class Exception extends moise.common.MoiseElement implements ToXML, ToProlog {
    
    private String id;
    private LogicalFormula condition;
    private Goal goal;
    
    private RecoveryStrategy inStrategy;
    
    public RecoveryStrategy getInStrategy() {
        return inStrategy;
    }

    public void setInStrategy(RecoveryStrategy inStrategy) {
        this.inStrategy = inStrategy;
    }

    private Scheme sch;
    
    public Exception(String id, LogicalFormula condition, RecoveryStrategy rs, Scheme sch) {
        super();
        this.id = id;
        this.condition = condition;
        inStrategy = rs;
        this.sch = sch;
    }
    
    public Exception(String id, RecoveryStrategy rs, Scheme sch) {
        super();
        this.id = id;
        inStrategy = rs;
        this.sch = sch;
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
    
    public void setFromDOM(Element ele, ExceptionType[] exceptionTypes) throws MoiseException {
        
        setPropertiesFromDOM(ele);
        
        String type = (String) getProperty("type");
        boolean found = false;
        int i = 0;
        ExceptionType et = null;
        while(!found && i < exceptionTypes.length) {
            if(exceptionTypes[i].getType().equals(type)) {
                et = exceptionTypes[i];
                found = true;
            }
            i++;
        }
        if(!found) {
            throw new MoiseException("Exception type " + type + " in exception " + id + " undefined!");
        }
        String[] arguments = et.getArguments();
        String cond = et.getFaultState();
        for(String arg : arguments) {
            String argValue = (String) getProperty(arg);
            if(argValue == null) {
                throw new MoiseException("Missing argument " + arg + "in exception " + id);
            }
            cond = cond.replace("$" + arg, argValue);
        }
        
        try {
            condition = ASSyntax.parseFormula(cond);
        } catch (ParseException e) {
            throw new MoiseException(e.getMessage());
        }
        
        
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
        //ele.setAttribute("when", condition.toString());
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
        }
        if(goal != null) {
            ele.appendChild(goal.getAsDOM(document));
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
