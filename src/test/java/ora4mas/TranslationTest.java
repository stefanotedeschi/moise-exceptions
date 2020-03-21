package ora4mas;

import static org.junit.Assert.assertEquals;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringReader;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.junit.Test;
import org.w3c.dom.Document;

import cartago.new_array;
import jason.asSyntax.ASSyntax;
import moise.os.OS;
import moise.os.fs.Goal;
import moise.os.fs.Scheme;
import moise.xml.DOMUtils;
import npl.NormativeProgram;
import npl.parser.ParseException;
import npl.parser.nplp;
import ora4mas.nopl.tools.os2nopl;

/** JUnit test case for syntax package */
public class TranslationTest {

    @Test
    public void testWP() throws ParseException, Exception {
        OS os = OS.loadOSFromURI("examples/writePaper/wp-os.xml");

        String np = os2nopl.transform(os);
        System.out.println(np);
        BufferedWriter out = new BufferedWriter(new FileWriter("examples/writePaper/wp-gen.npl"));
        out.write(np);
        out.close();
        NormativeProgram p = new NormativeProgram();
        new nplp(new StringReader(np)).program(p, null);
        assertEquals(7, p.getRoot().getScope(ASSyntax.parseLiteral("scheme(writePaperSch)")).getNorms().size());
    }

    @Test
    public void testGgroupWithoutRole() throws ParseException, Exception {
        OS os = OS.loadOSFromURI("src/test/jcm/groupwithoutrole.xml");

        String np = os2nopl.transform(os);
        //System.out.println(np);
        BufferedWriter out = new BufferedWriter(new FileWriter("src/test/jcm/groupwithoutrole.npl"));
        out.write(np);
        out.close();
        NormativeProgram p = new NormativeProgram();
        new nplp(new StringReader(np)).program(p, null);
    }
    
    @Test
    public void testExceptions() throws ParseException, TransformerFactoryConfigurationError, TransformerException, IOException {
        OS os = OS.loadOSFromURI("bancomat-os-exception.xml");
        
        Document d = DOMUtils.getAsXmlDocument(os);
        Transformer transformer = TransformerFactory.newInstance().newTransformer();
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
        Result output = new StreamResult(new File("output.xml"));
        Source input = new DOMSource(d);
        transformer.transform(input, output);
        
        String np = os2nopl.transform(os);
        BufferedWriter out = new BufferedWriter(new FileWriter("bancomat-os-exception-gen.npl"));
        out.write(np);
        out.close();
        
    }

}
