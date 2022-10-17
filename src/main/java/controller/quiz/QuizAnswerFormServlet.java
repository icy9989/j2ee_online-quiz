package controller.quiz;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.QuizDao;
import infrastructure.StartAttemptDao;
import model.Question;
import model.Quiz;
import model.Start_attempt;

@WebServlet("/quiz-answer")
public class QuizAnswerFormServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private QuizDao quizDao;
	private StartAttemptDao startAttemptDao;
	
	@Override
	public void init() {
		quizDao = new QuizDao();
		startAttemptDao = new StartAttemptDao();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
//		CourseDao courseDao = new CourseDao();
//		QuizDao quizDao = new QuizDao();
//		
//		Course course1 = (Course)session.getAttribute("inCourseList");
		
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Student")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else { 
			
			String id = request.getParameter("id");
			String courseId = quizDao.getCourseIdByQuizId(Integer.parseInt(id));
			String testName = quizDao.getQuizName(Integer.parseInt(id));
			request.setAttribute("courseId", courseId);
			request.setAttribute("testName", testName);
			
			List<Question> questionList = quizDao.getAllQuestion(id+"");
//			Collections.shuffle(questionList);
			request.setAttribute("questionList", questionList);
			
			Quiz q = quizDao.getQuizById(id+"");
			session.setAttribute("current-answer-quiz", q);
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");  
			LocalDateTime now = LocalDateTime.now();  
			
			int user_id =  (int) session.getAttribute("user_id");
			int quiz_id = Integer.parseInt(id);
			String start_time = now.format(dtf);
			
			Start_attempt sa = new Start_attempt(user_id, quiz_id, start_time);
			
			try {
				startAttemptDao.createStartAttempt(sa);
				
				session.setAttribute("start_attempt", sa);
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			request.getRequestDispatcher("quiz-answer-form.jsp").forward(request, response);
			
		}
	}
	

	
}
