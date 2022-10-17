package controller.quiz;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Quiz;

@WebServlet("/question-form")
public class QuestionFormServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Instructor")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
			
		String name = request.getParameter("name");
		String course_id = (String) session.getAttribute("current_course");
		String date = request.getParameter("date");
		String startTime = request.getParameter("stime");
		int duration = Integer.parseInt(request.getParameter("duration"));
		int total_question = Integer.parseInt(request.getParameter("questions"));
		int total_mark = 0;
		String published = request.getParameter("published");

		Quiz currentQuiz = new Quiz(name, course_id, date, startTime, duration, total_question, total_mark, published);
		
		int[] data = new int[currentQuiz.getTotal_question()];
		
		for(int i = 0; i < data.length; i++) {
	            data[i] = i*10;
	        }
		session.setAttribute("current_quiz", currentQuiz);
		request.setAttribute("total_question", data);
		System.out.println(currentQuiz.getTotal_question());
		request.getRequestDispatcher("question-form.jsp").forward(request, response);
		}
	}

}
