package controller.quiz;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.QuestionDao;
import infrastructure.SubmitAttemptDao;
import infrastructure.UserAnswerDao;
import model.Quiz;
import model.Submit_attempt;
import model.User_answer;

@WebServlet("/quiz-answer-submit")
public class QuizAnswerSubmitFormServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserAnswerDao userAnswerDao;
	private QuestionDao questionDao;
	private SubmitAttemptDao submitAttemptDao;

	@Override
	public void init() {
		userAnswerDao = new UserAnswerDao();
		questionDao = new QuestionDao();
		submitAttemptDao = new SubmitAttemptDao();
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();

		if (session.getAttribute("username") == null) {
			response.sendRedirect("login");
		} else if (!session.getAttribute("role").equals("Student")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		} else {

			ArrayList<User_answer> userAnswerList = new ArrayList<User_answer>();
			Quiz quiz = (Quiz) session.getAttribute("current-answer-quiz");
			float total_mark = 0;
			
			int quesId = questionDao.getQuestionId(quiz.getId());
			
			for (int i = 0; i < quiz.getTotal_question(); i++) {

				int q_index = i + 1;
				int mark_index = i + 1;
				int ans_index = i + 1;

				int opt = quesId + i;

				int user_id =  (int) session.getAttribute("user_id");
				System.out.println("dd"+user_id);
				int quiz_id = quiz.getId();
				int question_id = Integer.parseInt(request.getParameter("qId-" + q_index));
				String selected_option = request.getParameter("option-" + opt);
				float mark = 0;
				if(selected_option != null) {
					
					String answer = request.getParameter("ans-" + ans_index);
					
					if(selected_option.equals(answer)) {
						mark = Float.parseFloat(request.getParameter("mark-" + mark_index));
					}
				}
					
				total_mark += mark;
				
				User_answer ua = new User_answer(user_id, quiz_id, question_id, selected_option);
				userAnswerList.add(ua);
				
				try {
					userAnswerDao.createUserAnswer(ua);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			String course = request.getParameter("name");
			request.setAttribute("courseName", course);
//			session.setAttribute("totalMark", total_mark);
			session.setAttribute("user_mark", total_mark);
			session.setAttribute("c_quiz", quiz);
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");  
			LocalDateTime now = LocalDateTime.now();  
			
			int user_id =  (int) session.getAttribute("user_id");
			int quiz_id = quiz.getId();
			String submit_time = now.format(dtf);
			
			Submit_attempt sa = new Submit_attempt(user_id, quiz_id, submit_time);
			
			try {
				submitAttemptDao.createSubmitAttempt(sa);
				
				session.setAttribute("submit_attempt", sa);
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			request.getRequestDispatcher("quiz-view-form.jsp").forward(request, response); 

			
		}
	}


}
