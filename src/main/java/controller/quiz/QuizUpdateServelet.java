package controller.quiz;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.QuizDao;
import model.Question;
import model.Quiz;

@WebServlet("/update-quiz")
public class QuizUpdateServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuizDao quizDAO;

	@Override
	public void init() {
		quizDAO = new QuizDao();
	}

	public QuizUpdateServelet() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Instructor")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
			ArrayList<Question> qList = new ArrayList<Question>();
			Quiz quiz = (Quiz) session.getAttribute("current-quiz");
			
			String name = request.getParameter("name");
			String date = request.getParameter("date");
			int duration =Integer.parseInt(request.getParameter("duration"));
			String published = request.getParameter("published");
			String stime = request.getParameter("stime");
			float total_mark = 0;
			
			quiz.setDuration(duration);
			quiz.setDate(date);
			quiz.setStartTime(stime);
			quiz.setName(name);
			quiz.setPublished(published);
								
			for (int i = 0; i < quiz.getTotal_question(); i++) {
				
				int q_index = i + 1;
				int qId_index = i + 1;
				int mark_index = i + 1;
				int ans_index = i + 1;
				
				int opt_1 = i * 4 + 1;
				int opt_2 = i * 4 + 2;
				int opt_3 = i * 4 + 3;
				int opt_4 = i * 4 + 4;
				
				int qId = Integer.parseInt(request.getParameter("qId-"+qId_index));
				String question_description = request.getParameter("q-"+ q_index);
				String option_one = request.getParameter("option-"+ opt_1);
				String option_two = request.getParameter("option-"+ opt_2);
				String option_three = request.getParameter("option-"+ opt_3);
				String option_four = request.getParameter("option-"+ opt_4);
				String answer = request.getParameter("ans-"+ ans_index);
				
				float mark = Float.parseFloat(request.getParameter("mark-"+ mark_index));
				total_mark += mark;
				Question q = new Question(qId, question_description, option_one, option_two, option_three, option_four, answer, mark);
				qList.add(q);
			}
		
		quiz.setTotal_mark(total_mark);
		try {
			quizDAO.updateQuiz(quiz,qList);
			session.setAttribute("quizActionDoneMsg", "Updated");
			response.sendRedirect("instructor-dashboard");
		} catch (SQLException e) {
			session.setAttribute("quizActionFailedMsg", e.getMessage());
			response.sendRedirect("instructor-dashboard");
		}
	}
	}

}
