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

import infrastructure.QuizDao;
import infrastructure.UserAnswerDao;
import model.Question;
import model.Quiz;
import model.StudentMark;
import model.StudentQuiz;


@WebServlet("/student-quiz-list")
public class StdQuizListServlet extends HttpServlet {
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
			int user_id =Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			String course_code = request.getParameter("code");
			
			QuizDao quizDao = new QuizDao();
			
			UserAnswerDao userAnswerDao = new UserAnswerDao();
			
			float user_mark = 0.0f;
			StudentMark studentMark = null;
			
			List<Quiz> quizList = quizDao.getAllQuizzes(course_code);
			List<StudentQuiz> sqList = new ArrayList<StudentQuiz>();
			
			for (Quiz quiz : quizList) {
				List<Question> qlist = quizDao.getAllQuestion(String.valueOf(quiz.getId()));
				for (Question question : qlist) {
					String userAns = userAnswerDao.getUserSelectedOption(user_id, question.getId());
					if(userAns != null && userAns.equals(question.getAnswer())) {
						user_mark += question.getMark();
					}
					studentMark = new StudentMark(user_id, name, user_mark);
				}
				user_mark = 0.0f;
				StudentQuiz studentQuiz = new StudentQuiz(quiz.getId(), quiz.getName(), quiz.getDate(),quiz.getTotal_mark(),studentMark);
				sqList.add(studentQuiz);
			}
			session.setAttribute("sqlist", sqList);
			request.getRequestDispatcher("student-quiz.jsp").forward(request, response);

	}

	}

}
