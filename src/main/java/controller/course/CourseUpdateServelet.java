package controller.course;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.CourseDao;
import model.Course;

/**
 * Servlet implementation class CourseEditServelet
 */
@WebServlet("/update-course")
public class CourseUpdateServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseDao courseDAO;

	@Override
	public void init() {
		courseDAO = new CourseDao();
	}

	public CourseUpdateServelet() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Admin")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
		int id = Integer.parseInt(request.getParameter("id"));
		String code = request.getParameter("code");
		String courseName = request.getParameter("courseName");
		Course course = new Course(id, code, courseName);
		try {
			courseDAO.updateCourse(course);
			session.setAttribute("courseActionDoneMsg", "Updated");
			response.sendRedirect("courses");
		} catch (SQLException e) {
			session.setAttribute("courseActionFailedMsg", e.getMessage());
			response.sendRedirect("courses");
		}
	}
	}

}
