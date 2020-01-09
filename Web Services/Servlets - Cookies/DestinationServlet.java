import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class DestinationServlet extends HttpServlet {
	
   private String types[] = { "Individual trips", "Group trips", "Cruises", "Exotic trips" };
   
   private String destinations[] = { "London", "Sydney",  "New York", "Cairo", "Rio de Janeiro", "Cape Town", 
		"Mediterranean", "Caribbean", "North sea", "Hawaii", "Indonesia", "Maldives" };

   public void doGet( HttpServletRequest request,                  
                       HttpServletResponse response )   throws ServletException, IOException
   {
		PrintWriter output;
		
		response.setContentType( "text/html" );
		output = response.getWriter();  

        Cookie cookies[];
      
        cookies = request.getCookies(); 					// get client's cookies
		
		int counter = 0;
		
		if ( cookies.length != 0 ) {                                              
			for ( int i = 0; i < cookies.length; i++ ) {
				for ( int j = 0; j < types.length; j++ ) {
					if ( types[j].equals( cookies[ i ].getValue() ) )
						counter = j;
				}
			}	
		}			
			
		counter = counter * 3;	
    
        // send HTML page to client
		output.println("<html>");
		output.println("");
		output.println("<head> ");
		output.println("<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>");
		output.println("<link href='https://maxcdn.bootstrapcdn.com/bootswatch/4.0.0-beta.3/sketchy/bootstrap.min.css' rel='stylesheet' integrity='sha384-7ELRJF5/u1pkLd0W7K793Y7ZCb1ISE8FjEKiDAwHD3nSDbA2E9Txc423ovuNf1CV' crossorigin='anonymous'>");
		output.println("<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>");
		output.println("");
		output.println("<title>Select Trip Details</title> ");
		output.println("");
		output.println("<style>");
		output.println("body {");
		output.println("  background-image: url('IMG_37609.jpg');");
		output.println("  background-size: 1370px 700px;");
		output.println("}");
		output.println("");
		output.println("h4 {");
		output.println("	text-align: center;");
		output.println("	font-size: 50px;");
		output.println("	margin-top: 40px;");
		output.println("	color: orange;");
		output.println("}");
		output.println("h1 {");
		output.println("	text-align: center;");
		output.println("	font-size: 30px;");
		output.println("	margin-top: 40px;");
		output.println("	color: white;");
		output.println("}");
		output.println("h2 {");
		output.println("	font-size: 40px;");
		output.println("	margin-top: 0px;");
		output.println("	color: black;");
		output.println("}");
		output.println("</style>");
		output.println("</head>");
		output.println("");
		output.println("<body>");
		output.println("   <h4>Adjust the trip in your preferences</h4>");
		
		String k = "";
		
		if ( cookies.length != 0 ) {                                              
			for ( int i = 0; i < cookies.length; i++ ) {
				if ( cookies[ i ].getName().equals("TypeOfTravel") )
					k = cookies[ i ].getValue();
			}	
		}		
		
		output.println("   <h1>Type of travel you chose: " + k + "</h1>");
		output.println("");
		output.println("   <form action='http://localhost:8080/exercise1/redirect' method='get'>");
		output.println("	<h2 style='margin-left: 70px;'>Recommended Destinations:</h2>	");
		output.println("	<br>");
		output.println("	<div style='margin-left: 100px;'>");
		output.println("		<div class='form-group' style='width: 330px;margin-left: -30px;'>");
		output.println("			<select class='form-control' name='Destination'>");
		output.println("				<option value=''>None</option>			");
		output.println("				<option value='1'>" + destinations[counter] + "</option>");
		output.println("				<option value='2'>" + destinations[counter + 1] + "</option>");
		output.println("				<option value='3'>" + destinations[counter + 2] + "</option>");
		output.println("			</select>");
		output.println("		</div>");
		output.println("	</div>");
		output.println("	<br>");
		output.println("	<h2 style='margin-left: 70px;'>Duration of the trip:</h2>	");
		output.println("	<br>");
		output.println("	<div style='margin-left: 100px;'>");
		output.println("		<div class='form-group' style='width: 330px;margin-left: -30px;'>");
		output.println("			<select class='form-control' name='Duration'>");
		output.println("				<option value=''>None</option>			");
		output.println("				<option value='1-5 days'>1-5 days</option>");
		output.println("				<option value='6-10 days'>6-10 days</option>");
		output.println("				<option value='More than 10 days'>More than 10 days</option>");
		output.println("			</select>");
		output.println("		</div>");
		output.println("	</div>");
		output.println("	<br>");
		output.println("	<button style='margin-left: 160px;width: 80px;' type='submit' class='btn btn-success' value='submit'>Submit</button>");
		output.println("	<button style='margin-left: 10px;width: 80px;' type='reset' class='btn btn-danger' value='reset'>Reset</button>	");
		output.println("   </form>");
		output.println("</body>");
		output.println("");
		output.println("</html>");

        output.close ();    								
   }
}
