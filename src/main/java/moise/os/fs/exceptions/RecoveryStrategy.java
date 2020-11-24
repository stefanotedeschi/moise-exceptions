package moise.os.fs.exceptions;

import java.util.HashSet;
import java.util.Set;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.LogicalFormula;
import jason.asSyntax.parser.ParseException;
import moise.common.MoiseException;
import moise.os.fs.Scheme;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

public class RecoveryStrategy extends moise.common.MoiseElement implements ToXML, ToProlog {
    
    private String id;
    private Exception exception = null;
    private Set<HandlingPolicy> handlingPolicies = new HashSet<>();
    
    protected Scheme sch = null;

    public RecoveryStrategy(String id, Scheme sch) {
        super();
        this.id = id;
        this.sch = sch;
    }
    
    public static String getXMLTag() {
        return "recovery-strategy";
    }

    @Override
    public String getAsProlog() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        if(exception != null) {
            ele.appendChild(exception.getAsDOM(document));
        }
        for(HandlingPolicy h : handlingPolicies) {
            ele.appendChild(h.getAsDOM(document));
        }
        return ele;
    }
    
    public void setFromDOM(Element ele, ExceptionType[] et) throws MoiseException {
        
        setPropertiesFromDOM(ele);
        
        Element exEle = DOMUtils.getDOMDirectChild(ele, Exception.getXMLTag());
        String id = exEle.getAttribute("id");
        //LogicalFormula condition;
        //try {
        //    condition = ASSyntax.parseFormula(exEle.getAttribute("when"));
        //} catch (ParseException e) {
        //    throw new MoiseException(e.getMessage());
        //}
        //exception = new Exception(id, condition, this, sch);
        exception = new Exception(id, this, sch);
        exception.setFromDOM(exEle, et);
        
        for (Element hEle: DOMUtils.getDOMDirectChilds(ele, HandlingPolicy.getXMLTag())) {
            id = hEle.getAttribute("id");
            HandlingPolicy h = new HandlingPolicy(id, this, sch);
            h.setFromDOM(hEle);
            handlingPolicies.add(h);
        }
        
        
    }

    public String getId() {
        return id;
    }

    public Exception getException() {
        return exception;
    }

    public Set<HandlingPolicy> getHandlingPolicies() {
        return handlingPolicies;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setException(Exception exception) {
        this.exception = exception;
    }

    public void setHandlingPolicies(Set<HandlingPolicy> handlingPolicies) {
        this.handlingPolicies = handlingPolicies;
    }
    
}
