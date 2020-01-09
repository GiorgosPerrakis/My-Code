import java.io.*;
import javax.xml.transform.stream.*;
import javax.xml.transform.*;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
import org.xml.sax.*;
// for servlet:
import javax.servlet.*;
import javax.servlet.http.*;

import org.w3c.dom.*;  // for DOM (Java DOM)
import javax.xml.parsers.*;  

import javax.xml.transform.dom.*;// for transformations

public class XMLTransformerAskhsh extends HttpServlet {
	ServletContext ctx;
	String absPath;          //absolute path to our files - see below
	SAXSource xsltDoc; TransformerFactory tF;
	Transformer myTransformer;// will be built at init, will be used by doGet
	Document doc;

	public void init(ServletConfig config) throws UnavailableException {
		System.out.println("Init start");
		try {
			ctx = config.getServletContext();   // we will use the 'contex' below
			absPath = ctx.getRealPath("/WEB-INF/CarPresentor2.xsl");
			xsltDoc = new SAXSource(new InputSource(absPath));
			tF = TransformerFactory.newInstance();
			DocumentBuilderFactory fact = DocumentBuilderFactory.newInstance();
			// absolutely important, to understand the meaning of prefix 'xslt' !!!!
			fact.setNamespaceAware(true);
			DocumentBuilder builder = fact.newDocumentBuilder();
			doc = builder.parse(absPath);
			System.out.println("Name of document element is " +  doc.getDocumentElement().getNodeName()); 
		      } catch (Exception e) {	e.printStackTrace(); }
		System.out.println("Init end");
	}
	private void changeDomByColor(Document doc, String color) {
		NodeList nl = doc.getElementsByTagName("h1");
		Attr a = doc.createAttribute("style");
		a.setValue("background-color: "+color);
		nl.item(0).getAttributes().setNamedItem(a);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("dopost start");
		System.out.println("Name of document element (at the post) is " + doc.getDocumentElement().getNodeName()); 		
		String color = request.getParameter("color");
		System.out.println("You selected the color "  + color);
		System.out.println(doc.getElementsByTagName("h1").item(0).getAttributes().getNamedItem("style").getNodeValue());		
		changeDomByColor(doc, color);
		System.out.println(doc.getElementsByTagName("h1").item(0).getAttributes().getNamedItem("style").getNodeValue());		
		PrintWriter pwr = response.getWriter();
		try {
			DOMSource ds = new DOMSource(doc) ; 
	       		System.out.println( ((Document)ds.getNode()).getDocumentElement().getNodeName() +" " +((Document)ds.getNode()).getDocumentElement().getNodeValue() ) ;
//			myTransformer = tF.newTransformer(new DOMSource(doc)); 
//			myTransformer = tF.newTransformer(xsltDoc); 
			myTransformer = tF.newTransformer(ds);

			StreamSource xmlSource = new StreamSource(ctx.getResourceAsStream("/WEB-INF/Cars.xml"));
			System.out.println("Sending back the xml tranformed into html");
			response.setContentType("text/html"); //in order to put in http body
			myTransformer.transform(xmlSource, new StreamResult(pwr));
			pwr.println("The response sent back as a page!");
			pwr.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		System.out.println("dopost stop");
	}
	
}
