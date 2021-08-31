package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.SessionFactory;

import dao.UserDao;
import entities.User;
import helper.FactoryProvider;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	private void logOn(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html");
		try {
			PrintWriter out=response.getWriter();
			String email=request.getParameter("email");
			String password=request.getParameter("password");
			
			//authentication
			UserDao userDao=new UserDao(FactoryProvider.getFactory());
			User user=userDao.getUserByEmailAndPassword(email, password);
			
			HttpSession httpSession=request.getSession();
			
			if (user==null) {
				httpSession.setAttribute("message", "Invaid Details, try with another one");
				response.sendRedirect("login.jsp");
				return;
			} else {
							
				//login
				httpSession.setAttribute("current_user", user);
				if (user.getUserType().equals("admin")) {
					response.sendRedirect("admin.jsp");
				} else if (user.getUserType().equals("normal")) {
					response.sendRedirect("normal.jsp");
				} else {
					out.println("Sorry, we cannot identify you");
				}
			}
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		logOn(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		logOn(request, response);
	}

}
