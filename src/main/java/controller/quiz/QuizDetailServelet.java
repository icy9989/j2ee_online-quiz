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
import model.Question;
import model.Quiz;

@WebServlet("/quiz-detail")
public class QuizDetailServelet extends HttpServlet {
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
		
		String qCode = request.getParameter("id");
		List<Question> qList = quizDao.getAllQuestion(qCode);
		Quiz q = quizDao.getQuizById(qCode);
		System.out.println(q);
		session.setAttribute("current-quiz", q);
		request.setAttribute("id", q.getId());
		request.setAttribute("name", q.getName());
		request.setAttribute("date", q.getDate());
		request.setAttribute("start_time", q.getStartTime());
		request.setAttribute("duration", q.getDuration());
		request.setAttribute("total_question", q.getTotal_question());
		request.setAttribute("total_mark", q.getTotal_mark());
		session.setAttribute("published", q.isPublished());
		System.out.println("HelloHi " + request.getAttribute("published"));
		request.setAttribute("qList", qList);
		
		request.getRequestDispatcher("quiz-detail.jsp").forward(request, response);
		}
	}

}
