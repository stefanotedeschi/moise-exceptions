package moise.os.fs.accountability;

import java.util.ArrayList;
import java.util.List;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.Literal;
import jason.asSyntax.LiteralImpl;
import jason.asSyntax.LogicalFormula;
import jason.asSyntax.VarTerm;
import jason.asSyntax.parser.ParseException;
import moise.common.MoiseException;
import moise.os.fs.Goal;
import moise.os.fs.Scheme;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

public class AccountTemplate extends moise.common.MoiseElement implements ToXML, ToProlog {
    
    Scheme sch;
    
    private AccountabilityAgreement inAgreement;
    
    private List<RequestingGoal> requestingGoals = new ArrayList<>();
    
    private AccountingGoal accountingGoal;
    private List<Literal> accountArguments = new ArrayList<>();
    
    private List<TreatmentGoal> treatmentGoals = new ArrayList<>();
    
    public AccountTemplate(Scheme sch, AccountabilityAgreement inAgreement) {
        super();
        this.sch = sch;
        this.inAgreement = inAgreement;
    }

    public AccountabilityAgreement getInAgreement() {
        return inAgreement;
    }    
    
    public AccountingGoal getAccountingGoal() {
        return accountingGoal;
    }

    public List<Literal> getAccountArguments() {
        return accountArguments;
    }

    public List<RequestingGoal> getRequestingGoals() {
        return requestingGoals;
    }

    public List<TreatmentGoal> getTreatmentGoals() {
        return treatmentGoals;
    }

    public static String getXMLTag() {
        return "account-template";
    }
    
    public void setFromDOM(Element ele) throws MoiseException {
        
        setPropertiesFromDOM(ele);
        
        for(Element ea: DOMUtils.getDOMDirectChilds(ele, "account-argument")) {
            Literal l = new LiteralImpl(ea.getAttribute("id"));
            int nArgs = Integer.parseInt(ea.getAttribute("arity"));
            for(int i = 0; i < nArgs; i++) {
                l.addTerm(new VarTerm("Arg"+i));
            }
            accountArguments.add(l);
        }
        
        for(Element gEle: DOMUtils.getDOMDirectChilds(ele, Goal.getXMLTag())) {
            if(gEle.getAttribute("atype").equals("requesting")) {
                RequestingGoal rg = new RequestingGoal(gEle.getAttribute("id"), this);
                rg.setFromDOM(gEle, sch);
                sch.addGoal(rg);
                requestingGoals.add(rg);
            }
            else if(gEle.getAttribute("atype").equals("treatment")) {
                TreatmentGoal tg = new TreatmentGoal(gEle.getAttribute("id"), this);
                tg.setFromDOM(gEle, sch);
                sch.addGoal(tg);
                treatmentGoals.add(tg);
            }
            else if(gEle.getAttribute("atype").equals("accounting")) {
                if(accountingGoal != null) {
                    throw new MoiseException("Cannot have multiple accounting goals in accountability agreement " + inAgreement.getId());
                }
                accountingGoal = new AccountingGoal(gEle.getAttribute("id"), this);
                accountingGoal.setFromDOM(gEle, sch);
                sch.addGoal(accountingGoal);
            }
        } 
        
        if(accountingGoal == null) {
            throw new MoiseException("Accounting goal missing in account template in agreement " + inAgreement.getId());
        }
        
    }
    
    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
        }   
        for(Literal arg : accountArguments) {
            Element argEle = (Element) document.createElement("account-argument");
            argEle.setAttribute("id", arg.getFunctor());
            argEle.setAttribute("arity", String.valueOf(arg.getArity()));
            ele.appendChild(argEle);
        }
        for(RequestingGoal rg : requestingGoals) {
            ele.appendChild(rg.getAsDOM(document));
        }
        ele.appendChild(accountingGoal.getAsDOM(document));
        for(TreatmentGoal tg : treatmentGoals) {
            ele.appendChild(tg.getAsDOM(document));
        }
        return ele;
    }
   
    @Override
    public String getAsProlog() {
        // TODO Auto-generated method stub
        return null;
    }

}
