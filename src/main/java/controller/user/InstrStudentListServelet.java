package controller.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.UserDao;
import model.User;

@WebServlet("/instructor-students")
public class InstrStudentListServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDao;

	@Override
	public void init() {
		userDao = new UserDao();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Instructor")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
		String current_course = request.getParameter("course_code");
		session.setAttribute("course_code", current_course);
		List<User> allStudents = userDao.getAllUsers("Student");
		List<User> inStdlst = new ArrayList<User>();
				
		for (int j = 0; j < allStudents.stream().count(); j++) {
			if(allStudents.get(j).getCourseList().contains(current_course)) {
				if(!inStdlst.contains(allStudents.get(j))) {
					inStdlst.add(allStudents.get(j));
				}
			}
		}
		session.setAttribute("stdList", inStdlst);
		request.getRequestDispatcher("instructor-student-list.jsp").forward(request, response);
		}
	}

}
