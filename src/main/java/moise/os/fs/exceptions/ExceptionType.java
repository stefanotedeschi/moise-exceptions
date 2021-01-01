package moise.os.fs.exceptions;

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

public class ExceptionType extends moise.common.MoiseElement implements ToXML, ToProlog {
    
    private String id;
    
    private NotificationPolicy inPolicy;
    
    private List<Literal> exceptionArguments = new ArrayList<>();
    
    public ExceptionType(String id, NotificationPolicy inPolicy) {
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
        return "exception-type";
    }
    
    public void setFromDOM(Element ele) throws MoiseException {
        
        setPropertiesFromDOM(ele);
        
        for(Element ea: DOMUtils.getDOMDirectChilds(ele, "exception-argument")) {
        	Literal l = new LiteralImpl(ea.getAttribute("id"));
        	int nArgs = Integer.parseInt(ea.getAttribute("arity"));
        	for(int i = 0; i < nArgs; i++) {
        		l.addTerm(new VarTerm("Arg"+i));
        	}
        	exceptionArguments.add(l);
        }
        
    }
    
    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
        }
        for(Literal arg : exceptionArguments) {
        	Element argEle = (Element) document.createElement("exception-argument");
        	argEle.setAttribute("id", arg.getFunctor());
        	argEle.setAttribute("arity", String.valueOf(arg.getArity()));
        	ele.appendChild(argEle);
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
