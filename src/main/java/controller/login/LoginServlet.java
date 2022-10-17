package controller.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.LoginDao;
import model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		LoginDao loginDao = new LoginDao();
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		User user = loginDao.validate(email, password);
		
	
		if (user != null) {
			
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			session.setAttribute("user_id", user.getId());
			session.setAttribute("username", user.getUsername());
			session.setAttribute("password", user.getPassword());
			session.setAttribute("role",user.getRole());
			session.setAttribute("user-course-list",user.getCourseList());
			
			System.out.println( session.getAttribute("user_id"));
			if(user.getRole().equals("Admin")) {
				response.sendRedirect("admin-dashboard");
			}
			else if(user.getRole().equals("Instructor")) {
				
				response.sendRedirect("instructor-dashboard");
			}
			else {
				response.sendRedirect("student-dashboard");
			}
		} else {
			request.setAttribute("errorMessage", "Invalid username or password.");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
	}

}

