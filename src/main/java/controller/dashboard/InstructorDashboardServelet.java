package controller.dashboard;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.CourseDao;
import infrastructure.QuizDao;
import infrastructure.UserDao;
import model.Course;
import model.Quiz;
import model.User;

@WebServlet("/instructor-dashboard")
public class InstructorDashboardServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		CourseDao courseDao = new CourseDao();
		QuizDao quizDao = new QuizDao();
		UserDao userDao = new UserDao();

		User user = (User)session.getAttribute("user");
		
		List<Course> courseList = courseDao.getAllCourses();
	
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Instructor")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
			List<User> allStudents = userDao.getAllUsers("Student");
			List<Course> inCourseList = courseList.stream().filter(e -> user.getCourseList().contains(e.getCode())).toList();
	
			List<User> inStdlst = new ArrayList<User>();
			List<User> inStdlst1 = new ArrayList<User>();
			
			for (int j = 0; j < allStudents.stream().count(); j++) {
				if(allStudents.get(j).getCourseList().contains(inCourseList.get(0).getCode())) {
					if(!inStdlst.contains(allStudents.get(j))) {
						inStdlst.add(allStudents.get(j));
					}
				}
				if (allStudents.get(j).getCourseList().contains(inCourseList.get(1).getCode())) {
					if(!inStdlst1.contains(allStudents.get(j))) {
						inStdlst1.add(allStudents.get(j));
					}
				}
			}
			
			session.setAttribute("stdList" + String.valueOf(0), inStdlst);
			session.setAttribute("stdList" + String.valueOf(1), inStdlst1);
			System.out.println("in course list");
			System.out.println(inCourseList.stream().count());
			for (int i = 0; i < inCourseList.stream().count(); i++) {
				
				List<Quiz> quizList = quizDao.getAllQuizzes(inCourseList.get(i).getCode()).stream().limit(4).collect(Collectors.toList());
				Collections.reverse(quizList);
				session.setAttribute(String.valueOf(i),quizList);
			}
			session.setAttribute("instructor-course-list", inCourseList);
			session.setAttribute("std_count", allStudents.stream().count());
			session.setAttribute("co_count", courseList.stream().count());
			session.setAttribute("course_std_count1", inStdlst.stream().count());
			session.setAttribute("course_std_count2", inStdlst1.stream().count());
			request.getRequestDispatcher("instructor-dashboard.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}

}
