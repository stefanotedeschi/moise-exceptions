package ora4mas;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.junit.jupiter.api.Test;
import org.w3c.dom.Document;

import moise.os.OS;
import moise.xml.DOMUtils;
import npl.parser.ParseException;
import ora4mas.nopl.tools.os2nopl;

/** JUnit test case for syntax package */
public class TranslationTest {
    
    @Test
    public void testExceptions() throws ParseException, TransformerFactoryConfigurationError, TransformerException, IOException, jason.asSyntax.parser.ParseException {
        
        // ATM
        OS os = OS.loadOSFromURI("atm-os-exception.xml");
        
        Document d = DOMUtils.getAsXmlDocument(os);
        Transformer transformer = TransformerFactory.newInstance().newTransformer();
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
        Result output = new StreamResult(new File("atm-os-exception-output.xml"));
        Source input = new DOMSource(d);
        transformer.transform(input, output);
        
        String np = os2nopl.transform(os);
        BufferedWriter out = new BufferedWriter(new FileWriter("atm-os-exception.npl"));
        out.write(np);
        out.close();
        
        // Cake
        os = OS.loadOSFromURI("cake-os-exception.xml");
        d = DOMUtils.getAsXmlDocument(os);
        output = new StreamResult(new File("cake-os-exception-output.xml"));
        input = new DOMSource(d);
        transformer.transform(input, output);
        
        np = os2nopl.transform(os);
        out = new BufferedWriter(new FileWriter("cake-os-exception.npl"));
        out.write(np);
        out.close();
        
    }

}
