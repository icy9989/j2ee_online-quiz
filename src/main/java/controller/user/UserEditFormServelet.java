package controller.user;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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

@WebServlet("/user-edit-form")
public class UserEditFormServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private UserDao userDAO;
	private CourseDao courseDAO;
	@Override
	public void init() {
		userDAO = new UserDao();
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
		int id = Integer.parseInt(request.getParameter("id"));
		
		User currentUser;
		try {
			currentUser = userDAO.selectUser(id);
			List<Course> courses = courseDAO.getAllCourses();
			List<String> tmpUserCourseList = courses.stream().filter(e -> currentUser.getCourseList().contains(e.getCode())).map(e->e.getCourseName()).toList();
			ArrayList<String> userCourseList = new ArrayList<String>();
			for (int i = 0; i < tmpUserCourseList.stream().count(); i++) {
				userCourseList.add(tmpUserCourseList.get(i));
			}
			currentUser.setCourseList(userCourseList);
			request.setAttribute("currentuser", currentUser);
			
			session.setAttribute("courses",	courses);
			
			request.getRequestDispatcher("user-form.jsp").forward(request, response);
		} catch (SQLException e) {
			session.setAttribute("userActionFailedMsg", e.getMessage());
			response.sendRedirect("currentUserType");
		}
	}
	}
}
