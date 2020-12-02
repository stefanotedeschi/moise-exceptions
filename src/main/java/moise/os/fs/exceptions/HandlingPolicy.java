package moise.os.fs.exceptions;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.LogicalFormula;
import moise.common.MoiseException;
import moise.os.fs.Goal;
import moise.os.fs.Scheme;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

public class HandlingPolicy extends moise.common.MoiseElement implements ToXML, ToProlog  {

    private String id;
    private LogicalFormula condition;
    private RecoveryStrategy inStrategy;
    private Goal goal;
    private Scheme sch;
    
    public HandlingPolicy(String id, LogicalFormula condition, RecoveryStrategy rs, Scheme sch) {
        super();
        this.id = id;
        this.condition = condition;
        inStrategy = rs;
        this.sch = sch;
    }

    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public Goal getGoal() {
        return goal;
    }

    public void setGoal(Goal goal) {
        this.goal = goal;
    }
    
    public LogicalFormula getCondition() {
		return condition;
	}

	public RecoveryStrategy getInStrategy() {
		return inStrategy;
	}

	public void setCondition(LogicalFormula condition) {
		this.condition = condition;
	}

	public void setInStrategy(RecoveryStrategy inStrategy) {
		this.inStrategy = inStrategy;
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
        ele.setAttribute("condition", condition.toString());
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
        }
        if(goal != null) {
            ele.appendChild(goal.getAsDOM(document));
        }
        return ele;
    }
    
    public static String getXMLTag() {
        return "handling-policy";
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
