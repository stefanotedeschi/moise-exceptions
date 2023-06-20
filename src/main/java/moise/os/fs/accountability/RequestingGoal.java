package moise.os.fs.accountability;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class RequestingGoal extends AgreementGoal {
    
    public RequestingGoal(String goal, AccountTemplate inAccountTemplate) {
        super(goal, inAccountTemplate);
    }

    @Override
    public Element getAsDOM(Document document) {
        Element ele = super.getAsDOM(document);
        ele.setAttribute("atype","requesting");
        return ele;
    }

}
