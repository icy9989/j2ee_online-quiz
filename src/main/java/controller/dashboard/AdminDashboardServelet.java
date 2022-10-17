package controller.dashboard;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.CourseDao;
import infrastructure.UserDao;
import model.Course;
import model.User;

@WebServlet("/admin-dashboard")
public class AdminDashboardServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Admin")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
			UserDao userDao = new UserDao();
			CourseDao courseDao = new CourseDao();
			List<User> studentList = userDao.getAllUsers("Student");
			session.setAttribute("std_count", studentList.stream().count());
			List<User> instructorList = userDao.getAllUsers("Instructor");
			session.setAttribute("instr_count", instructorList.stream().count());
			List<Course> courseList = courseDao.getAllCourses();
			session.setAttribute("co_count", courseList.stream().count());
			request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}

}
