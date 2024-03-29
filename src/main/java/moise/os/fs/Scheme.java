package moise.os.fs;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.google.gson.FieldNamingPolicy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.stream.JsonReader;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.LogicalFormula;
import jason.asSyntax.parser.ParseException;
import moise.common.MoiseConsistencyException;
import moise.common.MoiseElement;
import moise.common.MoiseException;
import moise.os.Cardinality;
import moise.os.CardinalitySet;
import moise.os.fs.exceptions.ExceptionSpecification;
import moise.os.fs.exceptions.NotificationPolicy;
import moise.os.fs.exceptions.PolicyConditionTemplate;
import moise.os.fs.exceptions.RaisingGoal;
import moise.prolog.ToProlog;
import moise.xml.DOMUtils;
import moise.xml.ToXML;

/**
 Represents a Scheme specification.

 @composed - missions * Mission
 @navassoc - goal - Goal

 @author Jomi Fred Hubner
*/
public class Scheme extends MoiseElement implements ToXML, ToProlog {

    private static final long serialVersionUID = 1L;

    protected CardinalitySet<Mission>  missions = new CardinalitySet<Mission>();
    protected Set<Plan>                plans    = new HashSet<Plan>();
    protected Map<String,Goal>         goals    = new HashMap<String,Goal>();
    protected Goal                     root     = null;
    //protected String                   monitoring  = null;
    protected FS                       fs       = null;

    protected Map<String, NotificationPolicy> notificationPolicies = new HashMap<>();
    
    protected PolicyConditionTemplate[] policyConditionTemplates;

    public Scheme(String id, FS fs) {
        super(id);
        this.fs = fs;
        
        // get policy types from configuration file
        InputStream is = getClass().getResourceAsStream("/json/policy-conditions-templates.json");
        JsonReader reader = new JsonReader(new BufferedReader(new InputStreamReader(is)));
        Gson gson = new GsonBuilder().setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_DASHES).create();
        policyConditionTemplates = gson.fromJson(reader, PolicyConditionTemplate[].class);
    }


    public void setRoot(Goal g) {
        root = g;
        if (getGoal(g.getId()) == null)
            addGoal(g);
    }

    public Goal getRoot() {
        return root;
    }

    public FS getFS() {
        return fs;
    }

    /*
    public void setMonitoringSch(String schId) {
        monitoring = schId;
    }
    public String getMonitoringSch() {
        return monitoring;
    }
    public boolean isMonitorSch() {
        // search in groups
        for (Group g: getFS().getOS().getSS().getRootGrSpec().getAllSubGroupsTree())
            if (g.getMonitoringSch() != null && g.getMonitoringSch().equals( this.getId()) )
                return true;

        // search in schemes
        for (Scheme s: getFS().getSchemes())
            if (s.getMonitoringSch() != null && s.getMonitoringSch().equals( this.getId()) )
                return true;
        return false;
    }*/

    public PolicyConditionTemplate[] getPolicyConditionTemplates() {
        return policyConditionTemplates;
    }

    //
    // Plan methods
    //
    public void addPlan(Plan p) {
        plans.add(p);
    }

    // TODO: compute from goal tree
    public Collection<Plan> getPlans() {
        return plans;
    }

    //
    // Mission methods
    //
    public void addMission(Mission m) {
        missions.add(m);
    }

    public boolean removeMission(Mission m) {
        return missions.remove(m);
    }

    public void setMissionCardinality(String missionId, Cardinality c) throws MoiseConsistencyException {
        Mission m = getMission(missionId);
        if (m == null) {
            throw new MoiseConsistencyException("Failed to register the cardinality for the mission "+missionId+", it was not defined!");
        }
        setMissionCardinality(m, c);
    }

    public void setMissionCardinality(Mission m, Cardinality c) {
        missions.setCardinality(m, c);
    }

    public Cardinality getMissionCardinality(String missionId) {
        return getMissionCardinality(getMission(missionId));
    }

    public Cardinality getMissionCardinality(Mission m) {
        return missions.getCardinality(m);
    }


    /** gets the scheme missions ordered by the preference relation */
    @SuppressWarnings("unchecked")
    public Collection<Mission> getMissions() {
        List<Mission> l = new ArrayList<Mission>( missions.getAll() );
        Collections.sort( l );
        return l;
    }

    public Mission getMission(String id) {
        if (MoiseElement.getPrefix(id) == null) {
            id = getId() + "." + id;
        }
        return missions.get(id);
    }


    //
    // Goal methods
    //
    public void addGoal(Goal g) {
        goals.put(g.getId(), g);
    }

    /**
     * returns an iterator for GoalSpec objects of this SCH
     */
    public Collection<Goal> getGoals() {
        return goals.values();
    }

    public Goal getGoal(String id) {
        return goals.get(id);
    }

    /** 
     * returns the missions where goal g is
     */
    public Set<String> getGoalMissionsId(Goal g) {
        Set<String> ms = new HashSet<String>();
        for (Mission m: missions)
            if (m.getGoals().contains(g))
                ms.add(m.getId());
        return ms;
    }

    //
    // Notification policies methods
    public void addNotificationPolicy(NotificationPolicy np) {
        notificationPolicies.put(np.getId(), np);
    }

    public Collection<NotificationPolicy> getNotificationPolicies() {
        return notificationPolicies.values();
    }

    public ExceptionSpecification getExceptionSpecification(String id) throws MoiseException {
        for (NotificationPolicy np : notificationPolicies.values()) {
            for(ExceptionSpecification ex : np.getExceptionSpecifications()) {
                if (ex.getId().equals(id)) {
                    return ex;
                }
            }
        }
        throw new MoiseException("Exception spec " + id + " undefined in scheme " + this.getId());
    }

    /** returns a string representing the goal in Prolog syntax, format:
     *     scheme_specification(id, goals tree starting by root goal, missions, properties)
     */
    public String getAsProlog() {
        StringBuilder s = new StringBuilder("scheme_specification("+getId()+",");

        // goals
        s.append(getRoot().getAsProlog());

        // missions
        s.append(",[");
        String v="";
        for (Mission m: getMissions()) {
            s.append(v+m.getAsProlog());
            v=",";
        }
        s.append("],");

        // properties
        s.append(getPropertiesAsProlog());
        s.append(")");

        return s.toString();
    }

    public static String getXMLTag() {
        return "scheme";
    }

    public Element getAsDOM(Document document) {
        Element ele = (Element) document.createElement(getXMLTag());
        ele.setAttribute("id", getId());
        //if (getMonitoringSch() != null)
        //    ele.setAttribute("monitoring-scheme", getMonitoringSch());

        // properties
        if (getProperties().size() > 0) {
            ele.appendChild(getPropertiesAsDOM(document));
        }

        // goals
        ele.appendChild(getRoot().getAsDOM(document));

        // notification policies
        for (NotificationPolicy np : getNotificationPolicies()) {
            ele.appendChild(np.getAsDOM(document));
        }

        // missions
        for (Mission m: getMissions()) {
            ele.appendChild(m.getAsDOM(document));
        }

        return ele;
    }

    public void setFromDOM(Element ele) throws MoiseException {
        setPropertiesFromDOM(ele);

        // monitoring-scheme
        //if (ele.getAttribute("monitoring-scheme").length() > 0)
        //    setMonitoringSch(ele.getAttribute("monitoring-scheme"));

        // root goal
        Element grEle = DOMUtils.getDOMDirectChild(ele, Goal.getXMLTag());
        Goal rootG = new Goal(grEle.getAttribute("id"));
        rootG.setFromDOM(grEle, this);
        addGoal(rootG);
        setRoot(rootG);

//        // get exception types from configuration file
//        InputStream is = getClass().getResourceAsStream("/json/exceptions-conf.json");
//        JsonReader reader = new JsonReader(new BufferedReader(new InputStreamReader(is)));
//        Gson gson = new GsonBuilder().setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_DASHES).create();
//        policyConditionTemplates = gson.fromJson(reader, PolicyConditionTemplate[].class);

        // notification policies
        for (Element npEle : DOMUtils.getDOMDirectChilds(ele, NotificationPolicy.getXMLTag())) {
            try {
                LogicalFormula conditionFormula = ASSyntax.parseFormula("true");
                String condition = npEle.getAttribute("condition");
                if(condition != null) {
                    conditionFormula = ASSyntax.parseFormula(condition);
                }
                NotificationPolicy np = new NotificationPolicy(npEle.getAttribute("id"), npEle.getAttribute("target"), conditionFormula, this);
                np.setFromDOM(npEle);
                addNotificationPolicy(np);
            }
            catch(ParseException e) {
                throw new MoiseException(e.getMessage());
            }
        }

        // missions
        for (Element mEle: DOMUtils.getDOMDirectChilds(ele, Mission.getXMLTag())) {
            Mission m = new Mission(mEle.getAttribute("id"), this);
            m.setFromDOM(mEle);
            addMission(m);
        }

        // for goal without missions, set the minToSatisfy as 0
        for (Goal g: getGoals()) {
            if (g.getMinAgToSatisfy() != -1) // ignore goals with explicit cardinality
                continue;
            boolean hasg = false;
            for (Mission m: getMissions()) {
                if (m.getGoals().contains(g)) {
                    hasg = true;
                    break;
                }
            }
            if (!hasg) {
                g.setMinAgToSatisfy(0);
            }
        }
    }
}
