import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import user_package.*;

import java.util.ArrayList;
import java.util.List;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


public class CreateEventController extends HttpServlet {

     public void doPost(HttpServletRequest request, HttpServletResponse response)
         throws IOException, ServletException {

		 response.setContentType("text/html; charset=UTF-8");
		 PrintWriter out = new PrintWriter(response.getWriter(), true);

		 RequestDispatcher create_event = request.getRequestDispatcher("/createevent.jsp");
		 RequestDispatcher success = request.getRequestDispatcher("/index.jsp");		 
		
	     HttpSession session = request.getSession(true);

         String event_name = null;
         String type1 = null;
         String type2 = null;
         String address = null;
         String age = null;
         String sex = null;
		 String price = null;
		 String tickets = null;
		 String short_description = null;
		 String description = null;
         String date = null;

         try {	 	

			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);	
			
			String image = "";
			
			String root = "C:/Program Files/Apache Software Foundation/Tomcat 6.0/webapps/ismgroup21/images/";	
								
			List items = upload.parseRequest(request);
			Iterator iterator = items.iterator();
		   
			while (iterator.hasNext()) {
				FileItem item = (FileItem) iterator.next();

				if (!item.isFormField()) {
					image = item.getName();
				
					item.write(new File(root + image));	
					
				} else {
					
					if(item.getFieldName().equals("event_name"))
					{   
						event_name = item.getString();
					}

					if(item.getFieldName().equals("type1"))
					{   
						 type1 = item.getString();
					}

					if(item.getFieldName().equals("type2"))
					{   
						 type2 = item.getString();
					}	

					if(item.getFieldName().equals("address"))
					{   
						 address = item.getString();
					}

					if(item.getFieldName().equals("age"))
					{   
						 age = item.getString();
					}

					if(item.getFieldName().equals("sex"))
					{   
						 sex = item.getString();
					}

					if(item.getFieldName().equals("price"))
					{   
						 price = item.getString();
					}

					if(item.getFieldName().equals("tickets"))
					{   
						 tickets = item.getString();
					}

					if(item.getFieldName().equals("short_description"))
					{   
						 short_description = item.getString();
					}

					if(item.getFieldName().equals("description"))
					{   
						 description = item.getString();
					}

					if(item.getFieldName().equals("date"))
					{   
						 date = item.getString();
					}					
				}					
			}	 
			 
			if(event_name != null) {
				event_name = new String(event_name.getBytes("ISO-8859-1"), "UTF-8");
			}
			
			if(type1 != null) {
				type1 = new String(type1.getBytes("ISO-8859-1"), "UTF-8");
			}

			if(type2!= null) {
				type2 = new String(type2.getBytes("ISO-8859-1"), "UTF-8");
			}			
			
			if(address != null) {
				address = new String(address.getBytes("ISO-8859-1"), "UTF-8");
			}
			
			if(age != null) {
				age = new String(age.getBytes("ISO-8859-1"), "UTF-8");
			}

			if(sex != null) {
				sex = new String(sex.getBytes("ISO-8859-1"), "UTF-8");
			}			
			
			if(date != null) {
				date = new String(date.getBytes("ISO-8859-1"), "UTF-8");
			}			

			if(short_description != null) {
				short_description = new String(short_description.getBytes("ISO-8859-1"), "UTF-8");
			}

			if(description != null) {
				description = new String(description.getBytes("ISO-8859-1"), "UTF-8");
			}		

			int temp = 0;
			int temp1 = 0;
			int temp2 = 0;
			int temp3 = 0;			

            if (!(event_name.length() >= 5) || !(short_description.length() < 400) || !(description.length() < 600))
			{
			  temp = 1;	
			  request.setAttribute("temp", temp);

		      if (!(event_name.length() >= 5)) {
              	temp1 = 1;
				request.setAttribute("temp1", temp1);
			  }

		      if (!(short_description.length() < 400)) {
              	temp2 = 1;
				request.setAttribute("temp2", temp2);
			  }			  
				
		      if (!(description.length() < 600)) {
              	temp3 = 1;
				request.setAttribute("temp3", temp3);
			  }
	
			  create_event.forward(request, response);			  

              return;
            }
			else {	
			
				UserDAO userdao = new UserDAO();
				
				image = "/ismgroup21/images/" + image;
			
				Event event_to_create = new Event(event_name, type1, type2, address, age, sex, price, tickets, short_description, description, date, image, 1);
				userdao.createEvent(event_to_create);
			  
				session.setAttribute("event-object", event_to_create);
				success.forward(request, response);
						
			}   

            } catch (Exception ex) {
					
            }
		}		 

}