package controller.user;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.UserDao;
import model.User;


@WebServlet("/insert-user")
public class UserInsertServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDAO;

	@Override
	public void init() {
		userDAO = new UserDao();
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
			String userName = request.getParameter("username");
			String password = request.getParameter("password");
			String role = request.getParameter("role");
			String course_one = request.getParameter("course1");
			String course_two = request.getParameter("course2");
			String course_three = request.getParameter("course3");
			String course_four = request.getParameter("course4");
			String course_five = request.getParameter("course5");
			String course_six = request.getParameter("course6");
			String email = request.getParameter("email");
			ArrayList<String> courseList = new ArrayList<String>();
			courseList.add(course_one);
			courseList.add(course_two);
			courseList.add(course_three);
			courseList.add(course_four);
			courseList.add(course_five);
			courseList.add(course_six);
			User user = new User(userName, email, password, role, courseList);
			String serveletName = role.toLowerCase();
			try {
				if(user.getRole().equals("Student")) {
					userDAO.createStudent(user);
				}
				else {
					userDAO.createInstructor(user);
				}
				session.setAttribute("userActionDoneMsg", "Added");
				response.sendRedirect(serveletName);
			} catch (SQLException e) {
//				String referer = request.getHeader("Referer");
//				System.out.println(referer);
//				response.sendRedirect(referer);
				session.setAttribute("userActionFailedMsg", e.getMessage());
				response.sendRedirect(serveletName);
			}
		}
	}
}