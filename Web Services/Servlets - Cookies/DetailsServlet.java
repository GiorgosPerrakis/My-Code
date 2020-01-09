import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class DetailsServlet extends HttpServlet {


   public void doGet( HttpServletRequest request,        						// reaction to the reception of GET
                      HttpServletResponse response )
                      throws ServletException, IOException
   {
        PrintWriter output;
	  
        String type = request.getParameter( "TypeOfTravel" );   				// choice made will be sent back to client
		
	    Cookie c = new Cookie( "TypeOfTravel", type );   				// to be stored there as a cookie
		
	    c.setMaxAge( 120 );  								  					// seconds until cookie removed
        response.addCookie( c );  
																				// must preceede getWriter
        String period = request.getParameter( "TravelPeriod" );   				// choice made will be sent back to client
		
	    Cookie c1 = new Cookie( "TravelPeriod", period );   								// to be stored there as a cookie
		
	    c1.setMaxAge( 120 );  								  					// seconds until cookie removed
        response.addCookie( c1 );																				
		
	    response.setContentType( "text/html" );
	    output = response.getWriter(); 

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
		output.println("  background-image: url('IMG_37544.jpg');");
		output.println("  background-size: 1370px 700px;");
		output.println("}");
		output.println("");
		output.println("h4 {");
		output.println("	text-align: center;");
		output.println("	font-size: 50px;");
		output.println("	margin-top: 40px;");
		output.println("	color: MediumSeaGreen;");
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
		output.println("	color: red;");
		output.println("}");
		output.println("</style>");
		output.println("</head>");
		output.println("");
		output.println("<body>");
		output.println("	<h4>Adjust the trip in your preferences</h4>");
		output.println("	<h1>Period of travel you chose: " + period + "</h1>");
		output.println("");
		output.println("   <form action='http://localhost:8080/exercise1/temp' method='get'>");
		output.println("    <br>");
		output.println("    <br>	");
		output.println("	<div style='margin-left: 110px;margin-top: 10px'>");
		output.println("		<h2>Transportation:</h2>");
		output.println("		<br>");
		output.println("		<div class='form-group' style='width: 330px;'>");
		output.println("			<select class='form-control' name='Transportation'>");
		output.println("				<option value=''>None</option>			");
		output.println("				<option value='Airplane'>Airplane</option>");
		output.println("				<option value='Ship'>Ship</option>");
		output.println("				<option value='Bus'>Bus</option>");
		output.println("				<option value='Train'>Train</option>");
		output.println("			</select>");
		output.println("		</div>");
		output.println("	</div>");
		output.println("	<br>	");
		output.println("	<br>");
		output.println("	<div style='margin-top: -190px'>");
		output.println("		<h2 style='margin-left: 890px;'>Accommodation:</h2>");
		output.println("		<br>");
		output.println("		<div class='form-group' style='width: 330px;margin-left: 890px;'>");
		output.println("			<select class='form-control' name='Accommodation'>");
		output.println("				<option value=''>None</option>			");
		output.println("				<option value='One star'>One star</option>");
		output.println("				<option value='Two stars'>Two stars</option>");
		output.println("				<option value='Three stars'>Three stars</option>");
		output.println("				<option value='Four stars'>Four stars</option>");
		output.println("				<option value='Five stars'>Five stars</option>");
		output.println("			</select>");
		output.println("		</div>");
		output.println("	</div>	");
		output.println("	<br>");
		output.println("	<br>");
		output.println("	<br>");
		output.println("	<br>");
		output.println("	<br>");
		output.println("	<button style='margin-left: 575px;width: 100px;' type='submit' class='btn btn-secondary' value='submit'>Submit</button>");
		output.println("	<button style='margin-left: 10px;width: 100px;' type='reset' class='btn btn-danger' value='reset'>Reset</button>	");
		output.println("   </form>");
		output.println("</body>");
		output.println("");
		output.println("</html>");
        output.close();    																	// close stream
   }
}
