import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class RedirectServlet extends HttpServlet {
	
   private String types[] = { "Individual trips", "Group trips", "Cruises", "Exotic trips" };
	
   private String destinations[] = { "London", "Sydney",  "New York", "Cairo", "Rio de Janeiro", "Cape Town", 
		"Mediterranean", "Caribbean", "North sea", "Hawaii", "Indonesia", "Maldives" };

   public void doGet( HttpServletRequest request,        					
                      HttpServletResponse response )
                      throws ServletException, IOException
   {   
        int dest = Integer.parseInt(request.getParameter( "Destination" )); 

		Cookie cookies[];
      
        cookies = request.getCookies(); 					// get client's cookies
		
		String type = "";
		int temp = 0;
		
		if ( cookies.length != 0 ) {                                              
			for ( int i = 0; i < cookies.length; i++ ) {
				if ( cookies[ i ].getName().equals("TypeOfTravel") ) {
					type = cookies[ i ].getValue();
				}
			}

			for ( int j = 0; j < types.length; j++ ) {
				if (type.equals( types[j] ))
					temp = j;
			}
		}
		
	    Cookie c = new Cookie( "Destination", destinations[dest - 1 + temp * 3] );   				
		
	    c.setMaxAge( 120 );  								  				
        response.addCookie( c );  
																																						
        String dur = request.getParameter( "Duration" );   				
		
	    Cookie c1 = new Cookie( "Duration", dur );   				
		
	    c1.setMaxAge( 120 );  								  				
        response.addCookie( c1 ); 
		
	    response.setContentType( "text/html" );
		
		response.sendRedirect("http://localhost:8080/exercise1/summary");														
   }
}
