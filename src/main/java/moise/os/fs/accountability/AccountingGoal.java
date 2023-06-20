package moise.os.fs.accountability;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class AccountingGoal extends AgreementGoal {
    
    public AccountingGoal(String goal, AccountTemplate inAccountTemplate) {
        super(goal, inAccountTemplate);
    }

    @Override
    public Element getAsDOM(Document document) {
        Element ele = super.getAsDOM(document);
        ele.setAttribute("atype","accounting");
        return ele;
    }

}
