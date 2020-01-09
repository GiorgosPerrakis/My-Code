import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import user_package.*;
import java.util.ArrayList;
import java.util.List;

public class FiltersController extends HttpServlet {

     public void doPost(HttpServletRequest request, HttpServletResponse response)
         throws IOException, ServletException {

		 response.setContentType("text/html; charset=UTF-8");
		 PrintWriter out = new PrintWriter(response.getWriter(), true);

		 RequestDispatcher success = request.getRequestDispatcher("/results.jsp");		 
		
	     HttpSession session = request.getSession(true);

         String type = request.getParameter("type");		 
         String age = request.getParameter("age");		 	 
         String sex = request.getParameter("sex");		 		 
         String reset = request.getParameter("reset_button");		 

         try {
			
			if(type != null) {
				type = new String(type.getBytes("ISO-8859-1"), "UTF-8");
			}

			if(age != null) {
				age = new String(age.getBytes("ISO-8859-1"), "UTF-8");
			}

			if(sex != null) {
				sex = new String(sex.getBytes("ISO-8859-1"), "UTF-8");
			}		
			
			UserDAO userdao = new UserDAO();		
			
			List<Event> list_events, searchbar;
			
			if(reset != null) {
				list_events = null;
				searchbar = null;
				session.setAttribute("filter-object", list_events);
				session.setAttribute("search-object", searchbar);
				success.forward(request, response);
			}
				
			list_events = userdao.getEventByFilters(type, age, sex);
		  
			session.setAttribute("filter-object", list_events);
			success.forward(request, response);

          } catch (Exception ex) {
            out.println("Exception: " + ex.getMessage());
          }
      }
}
