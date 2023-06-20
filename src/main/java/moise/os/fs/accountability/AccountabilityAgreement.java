package moise.os.fs.accountability;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import moise.common.MoiseException;
import moise.os.fs.Goal;
import moise.os.fs.Scheme;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;
import jason.asSyntax.ASSyntax;
import jason.asSyntax.Literal;
import jason.asSyntax.LiteralImpl;
import jason.asSyntax.LogicalFormula;
import jason.asSyntax.parser.ParseException;

public class AccountabilityAgreement extends moise.common.MoiseElement implements ToXML, ToProlog {

    private String id;
    

    private Scheme sch;
    
    private Goal target;
    private LogicalFormula requestingCondition;
    private AccountTemplate accountTemplate;
    private List<Goal> contextGoals = new ArrayList<Goal>();
    
    public AccountabilityAgreement(String id, Scheme sch) {
        super();
        this.id = id;
        this.sch = sch;
    }

    public String getId() {
        return id;
    }
    
    public Goal getTarget() {
        return target;
    }

    public LogicalFormula getRequestingCondition() {
        return requestingCondition;
    }

    public AccountTemplate getAccountTemplate() {
        return accountTemplate;
    }

    public List<Goal> getContextGoals() {
        return contextGoals;
    }

    public void setFromDOM(Element ele) throws MoiseException {
        
        setPropertiesFromDOM(ele);
        
        Element targetEle = DOMUtils.getDOMDirectChild(ele, "target");
        target = sch.getGoal(targetEle.getAttribute("id"));
        
        Element condEle = DOMUtils.getDOMDirectChild(ele, "requesting-condition");
        if(condEle != null) {
            try {
                String cond = condEle.getAttribute("value");
                
                if(cond.startsWith("failure")) {
                    cond = cond.substring(8,cond.length()-1);
                    requestingCondition = ASSyntax.parseFormula("scheme_id(S) & failed(S," + cond + ")");
                }
                else if(cond.startsWith("delay")) {
                    cond = cond.substring(6,cond.length()-1);
                    requestingCondition = ASSyntax.parseFormula("scheme_id(S) & unfulfilled(obligation(_,_,done(S," + cond + ",_),_))");
                }
//                else if(cond.equals("warning")) {
//                    condition = ASSyntax.parseFormula("scheme_id(S) & warning(S," + inAgreement.getTarget().getId() + ")");
//                }
                else {
                    requestingCondition = ASSyntax.parseFormula(cond); 
                }
            } catch (ParseException e) {
                throw new MoiseException(e.getMessage());
            }
            for(Element contextGoalEle : DOMUtils.getDOMDirectChilds(condEle, "goal")) {
                
                Goal cg = new Goal(contextGoalEle.getAttribute("id"));
                cg.setFromDOM(contextGoalEle, sch);
                sch.addGoal(cg);
                contextGoals.add(cg);
            }
        }
        else {
            throw new MoiseException("Requesting condition missing in accountability agreement " + id);
        }
        
        Element accEle = DOMUtils.getDOMDirectChild(ele, AccountTemplate.getXMLTag());
        if (accEle != null) {
            accountTemplate = new AccountTemplate(sch, this);
            accountTemplate.setFromDOM(accEle);
        }
        else {
            throw new MoiseException("Account template missing in accountability agreement  " + id);
        }
        
    }

    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        //ele.setAttribute("condition", condition.toString());
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
        }
        Element targetEle = (Element) document.createElement("target");
        targetEle.setAttribute("id", target.getId());
        ele.appendChild(targetEle);
        Element condEle = (Element) document.createElement("requesting-condition");
        condEle.setAttribute("value", requestingCondition.toString());
        ele.appendChild(condEle);
        if (accountTemplate != null) {
            ele.appendChild(accountTemplate.getAsDOM(document));
        }
        return ele;
    }

    public static String getXMLTag() {
        return "accountability-agreement";
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
