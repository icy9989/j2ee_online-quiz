package controller.quiz;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.QuizDao;


@WebServlet("/delete-quiz")
public class QuizDeleteServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private QuizDao quizDAO;

	@Override
	public void init() {
		quizDAO = new QuizDao();
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
		int id = Integer.parseInt(request.getParameter("id"));
		try {
			quizDAO.deleteQuiz(id);
			session.setAttribute("quizActionDoneMsg", "Deleted");
			response.sendRedirect("instructor-dashboard");
		} catch (SQLException e) {
			throw new ServletException(e);
		}
		}
	}
}
