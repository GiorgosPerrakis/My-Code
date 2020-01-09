import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class TempServlet extends HttpServlet {

   public void doGet( HttpServletRequest request,        					
                      HttpServletResponse response )
                      throws ServletException, IOException
   {
	   
        String trans = request.getParameter( "Transportation" );   				
		
	    Cookie c = new Cookie( "Transportation", trans );   				
		
	    c.setMaxAge( 120 );  								  				
        response.addCookie( c );  
																																						
        String accom = request.getParameter( "Accommodation" );   				
		
	    Cookie c1 = new Cookie( "Accommodation", accom );   				
		
	    c1.setMaxAge( 120 );  								  				
        response.addCookie( c1 ); 
		
	    response.setContentType( "text/html" );
		
		response.sendRedirect("http://localhost:8080/exercise1/destination");														
   }
}
