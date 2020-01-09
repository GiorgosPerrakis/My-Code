import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class SummaryServlet extends HttpServlet {

   public void doGet( HttpServletRequest request,        						// reaction to the reception of GET
                      HttpServletResponse response )
                      throws ServletException, IOException
   {
        PrintWriter output;
        Cookie cookies[];
      
        cookies = request.getCookies(); 											// get client's cookies

        response.setContentType( "text/html" ); 
        output = response.getWriter();

		output.println("<html>");
		output.println("");
		output.println("<head> ");
		output.println("<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>");
		output.println("<link href='https://maxcdn.bootstrapcdn.com/bootswatch/4.0.0-beta.3/sketchy/bootstrap.min.css' rel='stylesheet' integrity='sha384-7ELRJF5/u1pkLd0W7K793Y7ZCb1ISE8FjEKiDAwHD3nSDbA2E9Txc423ovuNf1CV' crossorigin='anonymous'>");
		output.println("<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>");
		output.println("");
		output.println("<title>Trip Summary</title> ");
		output.println("");
		output.println("<style>");
		output.println("body {");
		output.println("  background-image: url('193190.jpg');");
		output.println("  background-size: 1370px 700px;");
		output.println("}");
		output.println("");
		output.println("h4 {");
		output.println("	text-align: center;");
		output.println("	font-size: 50px;");
		output.println("	margin-top: 40px;");
		output.println("	color: yellow;");
		output.println("}");
		output.println("h1 {");
		output.println("	font-size: 30px;");
		output.println("	margin-top: 40px;");
		output.println("	color: white;");
		output.println("}");
		output.println("</style>");
		output.println("</head>");
		output.println("");
		output.println("<body>");
		output.println("	<h4>Summary of your preferences</h4>");
		output.println("	<br>");
		output.println("	<div style='margin-left: 220px;'>");
		
        if ( cookies.length != 0 ) {                                             
           for ( int i = 0; i < cookies.length; i++ ) { 

			 if ( cookies[ i ].getName().equals("TypeOfTravel") )
				output.println("<h1>Type of travel: " + cookies[ i ].getValue() + "</h1>" );
			
			 if ( cookies[ i ].getName().equals("Destination") )
				output.println("<h1>Destination: " + cookies[ i ].getValue() + "</h1>" );
			
			 if ( cookies[ i ].getName().equals("TravelPeriod") )
				output.println("<h1>Period of travel: " + cookies[ i ].getValue() + "</h1>" );

			 if ( cookies[ i ].getName().equals("Duration") )
				output.println("<h1>Number of Days: " + cookies[ i ].getValue() + "</h1>" );

			 if ( cookies[ i ].getName().equals("Transportation") )
				output.println("<h1>Transportation: " + cookies[ i ].getValue() + "</h1>" );

			 if ( cookies[ i ].getName().equals("Accommodation") )
				output.println("<h1>Accommodation:  " + cookies[ i ].getValue() + "</h1>" );			
		   }
        }
		
		output.println("	</div>");
		output.println("</body>");
		output.println("");
		output.println("</html>");
        output.close();    													
   }

}
