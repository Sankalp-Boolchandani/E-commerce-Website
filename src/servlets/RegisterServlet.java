package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Transaction;

import org.hibernate.Session;

import entities.User;
import helper.FactoryProvider;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	private void regis(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out=response.getWriter();
			String name= request.getParameter("username");
			String email= request.getParameter("useremail");
			String pass= request.getParameter("user_pass");
			String phone= request.getParameter("user_phone");
			String address= request.getParameter("user_add");
			
			//user object
			
			User user=new User(name, email, pass, phone, "default.jpg", address, "normal");
			Session hibernateSession =FactoryProvider.getFactory().openSession();
			Transaction tx= hibernateSession.beginTransaction();
			int id=(int)hibernateSession.save(user);
			tx.commit();
			hibernateSession.close();
			
			HttpSession httpSession=request.getSession();
			httpSession.setAttribute("message", "Registration Successfull! Id = "+id);
			response.sendRedirect("register.jsp");
			return;
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		regis(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		regis(request, response);
	}

}
