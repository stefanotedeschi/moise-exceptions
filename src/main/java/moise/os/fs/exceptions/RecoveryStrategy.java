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
    private NotificationPolicy notificationPolicy;
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
        if(notificationPolicy != null) {
            ele.appendChild(notificationPolicy.getAsDOM(document));
        }
        for(HandlingPolicy hp : handlingPolicies) {
            ele.appendChild(hp.getAsDOM(document));
        }
        return ele;
    }
    
    public void setFromDOM(Element ele) throws MoiseException {
        
        setPropertiesFromDOM(ele);
        
        Element npEle = DOMUtils.getDOMDirectChild(ele, NotificationPolicy.getXMLTag());
        String id = npEle.getAttribute("id");
        LogicalFormula condition;
        try {
            condition = ASSyntax.parseFormula(npEle.getAttribute("condition"));
        } catch (ParseException e) {
            throw new MoiseException(e.getMessage());
        }
        notificationPolicy = new NotificationPolicy(id, condition, this, sch);
        notificationPolicy.setFromDOM(npEle);
        
        for (Element hpEle: DOMUtils.getDOMDirectChilds(ele, HandlingPolicy.getXMLTag())) {
            id = hpEle.getAttribute("id");
            try {
                condition = ASSyntax.parseFormula(hpEle.getAttribute("condition"));
            } catch (ParseException e) {
                throw new MoiseException(e.getMessage());
            }
            HandlingPolicy hp = new HandlingPolicy(id, condition, this, sch);
            hp.setFromDOM(hpEle);
            handlingPolicies.add(hp);
        }
        
    }

    public String getId() {
        return id;
    }

    public NotificationPolicy getNotificationPolicy() {
        return notificationPolicy;
    }

    public Set<HandlingPolicy> getHandlingPolicies() {
        return handlingPolicies;
    }
    
}
