package controller.quiz;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.QuestionDao;
import infrastructure.QuizDao;
import infrastructure.StartAttemptDao;
import infrastructure.SubmitAttemptDao;
import infrastructure.UserAnswerDao;
import model.Question;
import model.Quiz;

@WebServlet("/quiz-review")
public class QuizReviewFormServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private QuizDao quizDao;
	private UserAnswerDao userAnswerDao;
	private QuestionDao questionDao;
	private SubmitAttemptDao submitAttemptDao;
	private StartAttemptDao startAttemptDao;

	@Override
	public void init() {
		quizDao = new QuizDao();
		userAnswerDao = new UserAnswerDao();
		questionDao = new QuestionDao();
		submitAttemptDao = new SubmitAttemptDao();
		startAttemptDao = new StartAttemptDao();
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
			
			String id = request.getParameter("id");
			String courseId = quizDao.getCourseIdByQuizId(Integer.parseInt(id));
			String testName = quizDao.getQuizName(Integer.parseInt(id));
			request.setAttribute("courseId", courseId);
			request.setAttribute("testName", testName);
			float user_mark = 0.0f;
			List<Question> questionList = quizDao.getAllQuestion(id+"");
			request.setAttribute("questionList", questionList);
			
			
			
			
			Quiz q = quizDao.getQuizById(id+"");
			
			session.setAttribute("current-answer-quiz", q);
			session.setAttribute("total_mark", q.getTotal_mark());
			
			int user_id =  Integer.parseInt(request.getParameter("uid"));
			int quiz_id = Integer.parseInt(id);
			int question_id = questionDao.getQuestionId(quiz_id);
			
			for (Question question : questionList) {
				String userAns = userAnswerDao.getUserSelectedOption(user_id, question.getId());
				if(userAns != null && userAns.equals(question.getAnswer())) {
					user_mark += question.getMark();					}
			}
			session.setAttribute("user_mark", user_mark);
			
			
			String user_selected_option;
			String[] arr_user_selected_option = new String[questionList.size()];
			
			for(int i = 0; i < questionList.size(); i++) {
				user_selected_option = userAnswerDao.getUserSelectedOption(user_id, question_id + i);
				if(user_selected_option != null)
					arr_user_selected_option[i] = user_selected_option;
				else
					arr_user_selected_option[i] = null;
			}
			
			request.setAttribute("user_selected_option", arr_user_selected_option);
			
			String submit_time = submitAttemptDao.getSubmitTime(user_id, quiz_id);
			session.setAttribute("submit_time", submit_time);
			
			String start_time = startAttemptDao.getStartTime(user_id, quiz_id);
			System.out.println("start");
			System.out.println(start_time);
			session.setAttribute("start_time", start_time);
			
			request.getRequestDispatcher("quiz-review-form.jsp").forward(request, response);
			
		}
		
	}

	
	
	

}
