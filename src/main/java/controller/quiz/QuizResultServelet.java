package controller.quiz;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.QuestionDao;
import infrastructure.QuizDao;
import infrastructure.UserAnswerDao;
import infrastructure.UserDao;
import model.Question;
import model.Quiz;
import model.StudentMark;
import model.User;

@WebServlet("/quiz-result")
public class QuizResultServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Instructor")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
			String quiz_id = request.getParameter("id");
			String course_code = request.getParameter("code");
			
			QuizDao quizDao = new QuizDao();
			UserDao userDao = new UserDao();
			QuestionDao questionDao = new QuestionDao();
			UserAnswerDao userAnswerDao = new UserAnswerDao();
			
			List<Question> qlist = questionDao.getAllQuestions(quiz_id);
			
			Quiz q = quizDao.getQuizById(quiz_id);
			
			List<User> allStudents = userDao.getAllUsers("Student");
			
			List<User> inStdlst = new ArrayList<User>();
			List<StudentMark> stdMarkList = new ArrayList<StudentMark>();
			
			float user_mark = 0.0f;
			
			for (User std : allStudents) {
				if(std.getCourseList().contains(course_code)) {
					if(!inStdlst.contains(std)) {
						inStdlst.add(std);
					}
				}
			}
			
			for (User std : inStdlst) {
				for (Question question : qlist) {
					String userAns = userAnswerDao.getUserSelectedOption(std.getId(), question.getId());
					if(userAns != null && userAns.equals(question.getAnswer())) {
						user_mark += question.getMark();					}
					}
				StudentMark studentMark = new StudentMark(std.getId(),std.getUsername(),user_mark);
				stdMarkList.add(studentMark);
				user_mark = 0.0f;
			}
			List<Float> allStdMark = new ArrayList<Float>();
			
			for (StudentMark studentMark : stdMarkList) {
				allStdMark.add(studentMark.getMark());
			}
			System.out.println("allstdmark");
			System.out.println(allStdMark);
			float maximumMark = Collections.max(allStdMark);
			float minimumMark = Collections.min(allStdMark);
			
			float averageMark = 0.0f;
			float sum = 0.0f;
			
			for (StudentMark studentMark : stdMarkList) {
				sum += studentMark.getMark();
				averageMark = sum/stdMarkList.stream().count();
			}
			
			session.setAttribute("cq", q);
			session.setAttribute("minimum", minimumMark);
			session.setAttribute("maximum", maximumMark);
			session.setAttribute("average", averageMark);
			session.setAttribute("stdMarkList", stdMarkList);
			
			request.getRequestDispatcher("quiz-results.jsp").forward(request, response);
		}
	}

}
