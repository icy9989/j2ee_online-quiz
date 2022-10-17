package controller.dashboard;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.CourseDao;
import model.Course;
import model.User;

@WebServlet("/student-dashboard")
public class StudentDashboardServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		CourseDao courseDao = new CourseDao();
		
		User user = (User)session.getAttribute("user");
		
		List<Course> courseList = courseDao.getAllCourses();
		
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Student")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
			
			List<Course> inCourseList = courseList.stream().filter(e -> user.getCourseList().contains(e.getCode())).toList();
	
			List<Course> inCourselst = new ArrayList<Course>();
			
			for (int i = 0; i < inCourseList.stream().count(); i++) {
				
				if(user.getCourseList().contains(inCourseList.get(i).getCode())) { 
					  if(!inCourselst.contains(inCourseList.get(i))) {
						  inCourselst.add(inCourseList.get(i)); 
					  }
					  
				  } 
				
				session.setAttribute(String.valueOf(i), inCourselst);
			}
			
			session.setAttribute("student-course-list", inCourseList);
			
			request.getRequestDispatcher("student-dashboard.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}

}
