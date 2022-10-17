package controller.quiz;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.CourseDao;
import infrastructure.QuestionDao;
import infrastructure.QuizDao;
import infrastructure.UserAnswerDao;
import model.Question;
import model.Quiz;

@WebServlet("/quiz-view")
public class QuizViewFormServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private QuizDao quizDao;
	private CourseDao courseDao;
	private QuestionDao questionDao;
	private UserAnswerDao userAnswerDao;
	
	@Override
	public void init() {
		quizDao = new QuizDao();
		courseDao = new CourseDao();
		questionDao = new QuestionDao();
		userAnswerDao = new UserAnswerDao();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(session.getAttribute("role").equals("Admin")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else { 
			
//			String quiz = request.getParameter("name");
//			session.setAttribute("quizName", quiz);
//			
////			String totalMark = request.getParameter("totalMark");
////			request.setAttribute("totalMark", totalMark);
//			
//			int quizId = quizDao.getQuizId(quiz.substring(0, 8), quiz.substring(11));
//
//			Quiz specificQuiz = quizDao.getQuizById(quizId+"");
//		
//			//todo total mark by calculating answer from question and ans from user answer from database 
//			int user_id =  (int) session.getAttribute("user_id");
////			Quiz current_quiz = (Quiz) session.getAttribute("current-answer-quiz");
//			int quiz_id = specificQuiz.getId();
//			int question_id = questionDao.getQuestionId(quiz_id);
//			String user_selected_option;
//			float user_mark = 0, user_total_mark = 0;
//			
//			for (int i = 0; i < specificQuiz.getTotal_question(); i++) {
//				
//				user_selected_option = userAnswerDao.getUserSelectedOption(user_id, question_id + i);
//				
//				if(user_selected_option != null) {
//					
//					String answer = questionDao.getAnswerByQuestionID(question_id);
//					
//					if(user_selected_option.equals(answer)) {
//						user_mark = questionDao.getMarkByQuestionID(question_id);
//					}
//				}
//				
//				user_total_mark += user_mark;
//			}
//			
//			session.setAttribute("user_total_mark", user_total_mark);
//			
//			session.setAttribute("current-quiz", specificQuiz);
//			session.setAttribute("id", specificQuiz.getId());
//			session.setAttribute("course_id", specificQuiz.getCourse_id());
//			session.setAttribute("name", specificQuiz.getName());
//			session.setAttribute("date", specificQuiz.getDate());
//			session.setAttribute("start_time", specificQuiz.getStartTime());
//			session.setAttribute("duration", specificQuiz.getDuration());
//			session.setAttribute("total_question", specificQuiz.getTotal_question());
//			session.setAttribute("total_mark", specificQuiz.getTotal_mark());
////			session.setAttribute("published", specificQuiz.isPublished());
//			session.setAttribute("published", specificQuiz.getPublished());
//			
//			String courseName = courseDao.getCourseName((String)session.getAttribute("course_id"));
//			session.setAttribute("course_name", courseName);
			
			String quiz_id = request.getParameter("id");			

			QuestionDao questionDao = new QuestionDao();
			UserAnswerDao userAnswerDao = new UserAnswerDao();
			
			List<Question> qlist = questionDao.getAllQuestions(quiz_id);
			
			Quiz q = quizDao.getQuizById(quiz_id);
			
	
			float user_mark = 0.0f;
			int user_id = Integer.parseInt(request.getParameter("std_id"));
//			
			session.setAttribute("uid", user_id);
			
			
			for (Question question : qlist) {
				String userAns = userAnswerDao.getUserSelectedOption(user_id, question.getId());
				if(userAns != null && userAns.equals(question.getAnswer())) {
					user_mark += question.getMark();					}
			}
			
			session.setAttribute("user_mark", user_mark);
			session.setAttribute("c_quiz", q);
			
			String testDate = q.getDate();
			String startTime1 = q.getStartTime();
			String startTime = startTime1.substring(0, startTime1.length() - 3);
			int duration = q.getDuration();
			
			int durationHr = duration / 60;
			int durationMin = duration % 60;
			
			String sHr = startTime.split(":")[0];
			String sMin = startTime.split(":")[1];
			int sHr1;
			if(!startTime1.substring(0, 2).equals("12")) {
				if(startTime1.charAt(startTime1.length() - 2) == 'P')
					sHr1 = Integer.parseInt(sHr) + 12;
				else 
					sHr1 = Integer.parseInt(sHr);
			}
			else 
				sHr1 = Integer.parseInt(sHr);
			int sMin1 = Integer.parseInt(sMin);
			
			String sHr2 = String.valueOf(sHr1);
			String sMin2 = String.valueOf(sMin1);
			
			int hr = sHr1 + durationHr;
			int min = sMin1 + durationMin;
			String hr1 = String.valueOf(hr);
			String min1 = String.valueOf(min);
			if(hr < 10)
				hr1 = "0" + String.valueOf(hr);
			if(min < 10)
				min1 = "0" + String.valueOf(min);
			
			String endTime = testDate + " " + hr1 + ":" + min1 + ":00";
			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			try {
				Date endTime1 = formatter.parse(endTime);
				String endTime2 = formatter.format(endTime1);
				
				session.setAttribute("testDate", endTime2);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			String testDate_startTime = testDate + " " + sHr2 + ":" + sMin2 + ":00";
			try {
				Date testDate_startTime1 = formatter.parse(testDate_startTime);
				String testDate_startTime2 = formatter.format(testDate_startTime1);
				
				System.out.println("Hello Hello Hi " + testDate_startTime2);
				
				session.setAttribute("testDate_startTime", testDate_startTime2);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			request.getRequestDispatcher("quiz-view-form.jsp").forward(request, response);
		
		}
	}
}