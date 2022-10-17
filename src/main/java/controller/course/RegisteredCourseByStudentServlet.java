package controller.course;

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
import infrastructure.QuizDao;
import model.Course;
import model.Quiz;

@WebServlet("/registered-course")
public class RegisteredCourseByStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		CourseDao courseDao = new CourseDao();
		QuizDao quizDao = new QuizDao();
		
		List<Course> course1 = (List<Course>) session.getAttribute("student-course-list");
		
		
		System.out.println("HiHiHi " + session.getAttribute("student-course-list"));
		
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Student")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else { 
		
			String course = request.getParameter("name");
			session.setAttribute("courseName", course);

			List<Quiz> quizList = quizDao.getAllQuizzes(courseDao.getCourseCode(course.substring(11)));

			List<Quiz> inQuizlst = new ArrayList<Quiz>();
			
			for (int i = 0; i < quizList.stream().count(); i++) {
				
				if(!inQuizlst.contains(quizList.get(i))) {
					  inQuizlst.add(quizList.get(i)); 
				  }
				
				session.setAttribute(String.valueOf(i), inQuizlst);
			}
			
			session.setAttribute("quiz-list", quizList);
			
			request.getRequestDispatcher("registered-course.jsp").forward(request, response); 
		}
		 
	}

}