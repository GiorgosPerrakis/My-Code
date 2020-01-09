import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import user_package.*;

public class RegisterController extends HttpServlet {

     public void doPost(HttpServletRequest request, HttpServletResponse response)
         throws IOException, ServletException {

		 response.setContentType("text/html; charset=UTF-8");
		 PrintWriter out = new PrintWriter(response.getWriter(), true);

		 RequestDispatcher register_form = request.getRequestDispatcher("/signupform.jsp");
		 RequestDispatcher success = request.getRequestDispatcher("/index.jsp");		 
		
	     HttpSession session = request.getSession(true);

         String name = request.getParameter("name");
         String surname = request.getParameter("surname");
         String email = request.getParameter("email");
         String username = request.getParameter("username");
         String password = request.getParameter("password");
         String confirm = request.getParameter("confirm");

         try {
			if(name != null) {
				name = new String(name.getBytes("ISO-8859-1"), "UTF-8");
			}

			if(surname != null) {
				surname = new String(surname.getBytes("ISO-8859-1"), "UTF-8");
			}

			UserDAO userdao = new UserDAO();

			User user = userdao.findUser(username);

			int temp = 0;
			int temp1 = 0;
			int temp2 = 0;
			int temp3 = 0;	
			int temp4 = 0;
			int temp5 = 0;
			int temp6 = 0;			

			if (!(name.length() >= 3) || !(surname.length() >= 3) || !(username.length() >= 5) || !(password.length() >= 5) || !(password.equals(confirm)) || user != null)
			{
			  temp = 1;	
			  request.setAttribute("temp", temp);
				
		      if (!(name.length() >= 3)) {
              	temp1 = 1;
				request.setAttribute("temp1", temp1);
			  }

		      if (!(surname.length() >= 3)) {
				temp2 = 2;
				request.setAttribute("temp2", temp2);
			  }

			  if(user != null){
				temp3 = 3;
				request.setAttribute("temp3", temp3);
			  }

		      if (!(username.length() >= 5)) {
				temp4 = 4;
				request.setAttribute("temp4", temp4);
			  }

		      if (!(password.length() >= 5)) {
				temp5 = 5;
				request.setAttribute("temp5", temp5);
			  }

		      if (!(password.equals(confirm))) {
   				temp6 = 6;
				request.setAttribute("temp6", temp6);
			  }	
			  register_form.forward(request, response);			  

              return;
            }

			else {
			  User user_to_register = new User(name, surname, email, username, password);
			  userdao.registerUser(user_to_register);
			  
			  session.setAttribute("user-object", user_to_register);
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
