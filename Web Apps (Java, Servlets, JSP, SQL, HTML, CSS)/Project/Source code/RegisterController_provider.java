import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import user_package.*;

public class RegisterController_provider extends HttpServlet {

     public void doPost(HttpServletRequest request, HttpServletResponse response)
         throws IOException, ServletException {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = new PrintWriter(response.getWriter(), true);

		RequestDispatcher register_provider_form = request.getRequestDispatcher("/provider-signupform.jsp");
		RequestDispatcher success = request.getRequestDispatcher("/index.jsp");			
		
		HttpSession session = request.getSession(true);

         String company = request.getParameter("company");
         String afm = request.getParameter("afm");
         String phone = request.getParameter("phone");			 
         String name = request.getParameter("name");
         String surname = request.getParameter("surname");
         String email = request.getParameter("email");
         String username = request.getParameter("username");		 
         String password = request.getParameter("password");
         String confirm = request.getParameter("confirm");

         try {		
			if(company != null) {
				company = new String(company.getBytes("ISO-8859-1"), "UTF-8");
			}			

			if(name != null) {
				name = new String(name.getBytes("ISO-8859-1"), "UTF-8");
			}

			if(surname != null) {
				surname = new String(surname.getBytes("ISO-8859-1"), "UTF-8");
			}

			UserDAO userdao = new UserDAO();

			Organizer organizer = userdao.findOrganizer(username);
			
			int temp = 0;
			int temp1 = 0;
			int temp2 = 0;
			int temp3 = 0;	
			int temp4 = 0;
			int temp5 = 0;
			int temp6 = 0;
			int temp7 = 0;
			int temp8 = 0;
			int temp9 = 0;			

            if (!(company.length() >= 5) || (!(afm.length() == 9)) || (!(phone.length() == 10)) || !(name.length() >= 3) || !(surname.length() >= 3) || !(username.length() >= 5) || !(password.length() >= 5) || !(password.equals(confirm)) || organizer != null)
			{
			  temp = 1;	
			  request.setAttribute("temp", temp);

		      if (!(company.length() >= 5)) {
              	temp1 = 1;
				request.setAttribute("temp1", temp1);
			  }
			  
		      if (!(afm.length() == 9)) {
              	temp2 = 1;
				request.setAttribute("temp2", temp2);
			  }

		      if (!(phone.length() == 10)) {
              	temp3 = 1;
				request.setAttribute("temp3", temp3);
			  }			  
				
		      if (!(name.length() >= 3)) {
              	temp4 = 1;
				request.setAttribute("temp4", temp4);
			  }

		      if (!(surname.length() >= 3)) {
				temp5 = 1;
				request.setAttribute("temp5", temp5);
			  }

			  if(organizer != null){
				temp6 = 1;
				request.setAttribute("temp6", temp6);
			  }

		      if (!(username.length() >= 5)) {
				temp7 = 1;
				request.setAttribute("temp7", temp7);
			  }

		      if (!(password.length() >= 5)) {
				temp8 = 1;
				request.setAttribute("temp8", temp8);
			  }

		      if (!(password.equals(confirm))) {
   				temp9 = 1;
				request.setAttribute("temp9", temp9);
			  }	
			  register_provider_form.forward(request, response);			  

              return;
            }
			else {
			  Organizer organizer_to_register = new Organizer(company, afm, email, phone, name, surname, username, password);
			  userdao.registerOrganizer(organizer_to_register);
			  
			  session.setAttribute("organizer-object", organizer_to_register);
			  success.forward(request, response);
			}

          } catch (Exception ex) {
            out.println("Exception: " + ex.getMessage());

          }
      }

      public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
            response.sendRedirect("/signupform.jsp");
      	}
}
