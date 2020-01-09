import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import user_package.*;
import java.util.ArrayList;
import java.util.List;

public class SearchController extends HttpServlet {

     public void doPost(HttpServletRequest request, HttpServletResponse response)
         throws IOException, ServletException {

		 response.setContentType("text/html; charset=UTF-8");
		 PrintWriter out = new PrintWriter(response.getWriter(), true);

		 RequestDispatcher success = request.getRequestDispatcher("/results.jsp");		 
		
	     HttpSession session = request.getSession(true);
		 
         String search = request.getParameter("search_bar");		 		 

         try {		

			if(search != null) {
				search = new String(search.getBytes("ISO-8859-1"), "UTF-8");
			}
			
			UserDAO userdao = new UserDAO();		

			List<Event> searchbar_events = null;
	
			searchbar_events = userdao.getEventsBySearchBar(search);
			
			session.setAttribute("search-object", searchbar_events);
			success.forward(request, response);

          } catch (Exception ex) {
            out.println("Exception: " + ex.getMessage());
          }
      }
}
