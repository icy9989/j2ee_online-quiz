package controller.quiz;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.QuizDao;
import model.Quiz;

@WebServlet("/quizzes")
public class QuizListServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QuizDao quizDao;

	@Override
	public void init() {
		quizDao = new QuizDao();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Instructor")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
		String current_course = request.getParameter("course_code");
		session.setAttribute("course_code", current_course);
		List<Quiz> quizList = quizDao.getAllQuizzes(current_course);
		request.setAttribute("quizList", quizList);
		request.getRequestDispatcher("quiz-list.jsp").forward(request, response);
		}
	}

}
