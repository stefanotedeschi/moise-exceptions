package moise.os.fs.accountability;

import java.util.Map;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import java.util.HashMap;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.LogicalFormula;
import jason.asSyntax.parser.ParseException;
import moise.common.MoiseException;
import moise.os.fs.Scheme;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

public class Condition implements ToXML {
    
    private Scheme sch;
    
    private String type;
    private Map<String,String> conditionArguments = new HashMap<>();
    private LogicalFormula conditionFormula;
    
    public Condition(String type, Scheme scheme) {
        this.type = type;
        sch = scheme;
    }
    
    public String getType() {
        return type;
    }

    public void addArgument(String id, String value) {
        conditionArguments.put(id, value);
    }
    
    public void buildConditionFormula() throws MoiseException {
        AgreementConditionTemplate[] conditionTemplates = sch.getAgreementConditionTemplates();
        boolean found = false;
        int i = 0;
        AgreementConditionTemplate ct = null;
        while (!found && i < conditionTemplates.length) {
            if (conditionTemplates[i].getType().equals(type)) {
                ct = conditionTemplates[i];
                found = true;
            }
            i++;
        }
        if (!found) {
            throw new MoiseException("Condition " + type + "undefined");
        }
        String[] argumentNames = ct.getArgumentNames();
        String cond = ct.getConditionFormula();
        for (String arg : argumentNames) {
            String argValue = conditionArguments.get(arg);
            if (argValue == null) {
                throw new MoiseException("Missing argument " + arg);
            }
            cond = cond.replace("$" + arg, argValue);
        }

        try {
            conditionFormula = ASSyntax.parseFormula(cond);
        } catch (ParseException e) {
            throw new MoiseException(e.getMessage());
        }       
    }
    
    public LogicalFormula getConditionFormula() {
        return conditionFormula;
    }

    public void setFromDOM(Element ele) throws MoiseException {
        for(Element ca: DOMUtils.getDOMDirectChilds(ele, "condition-argument")) {
            addArgument(ca.getAttribute("id"), ca.getAttribute("value"));
        }
        buildConditionFormula();
    }
    
    @Override
    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("type", getType());
        for(String arg : conditionArguments.keySet()) {
            Element argEle = (Element) document.createElement("condition-argument");
            argEle.setAttribute("id", arg);
            argEle.setAttribute("value", conditionArguments.get(arg));
            ele.appendChild(argEle);
        }
        return ele;
    }
    
    public static String getXMLTag() {
        return "condition";
    }

}
