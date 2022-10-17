package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.CourseDao;
import model.Course;

@WebServlet("/user-form")
public class UserFormServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseDao courseDAO;
	
	@Override
	public void init() {
		courseDAO = new CourseDao();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Admin")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
		List<Course> courses = courseDAO.getAllCourses();
		session.setAttribute("courses",	courses );
		request.getRequestDispatcher("user-form.jsp").forward(request, response);
		}
	}

}
