package moise.os.fs;

import java.util.HashSet;
import java.util.Set;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.LogicalFormula;
import jason.asSyntax.parser.ParseException;
import moise.common.MoiseException;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

public class RecoveryStrategy extends moise.common.MoiseElement implements ToXML, ToProlog {
    
    private String id;
    private Exception exception = null;
    private Set<Handler> handlers = new HashSet<>();
    
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
        for(Handler h : handlers) {
            ele.appendChild(h.getAsDOM(document));
        }
        return ele;
    }
    
    public void setFromDOM(Element ele) throws MoiseException {
        
        setPropertiesFromDOM(ele);
        
        Element exEle = DOMUtils.getDOMDirectChild(ele, Exception.getXMLTag());
        String id = exEle.getAttribute("id");
        LogicalFormula condition;
        try {
            condition = ASSyntax.parseFormula(exEle.getAttribute("when"));
        } catch (ParseException e) {
            throw new MoiseException(e.getMessage());
        }
        exception = new Exception(id, condition, this, sch);
        exception.setFromDOM(exEle);
        
        for (Element hEle: DOMUtils.getDOMDirectChilds(ele, Handler.getXMLTag())) {
            id = hEle.getAttribute("id");
            Handler h = new Handler(id, this, sch);
            h.setFromDOM(hEle);
            handlers.add(h);
        }
        
        
    }

    public String getId() {
        return id;
    }

    public Exception getException() {
        return exception;
    }

    public Set<Handler> getHandlers() {
        return handlers;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setException(Exception exception) {
        this.exception = exception;
    }

    public void setHandlers(Set<Handler> handlers) {
        this.handlers = handlers;
    }
    
}
