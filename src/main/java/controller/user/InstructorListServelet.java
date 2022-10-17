package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.UserDao;
import model.User;

@WebServlet("/instructor")
public class InstructorListServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDAO;


	@Override
	public void init() {
		userDAO = new UserDao();
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
		else if(!session.getAttribute("role").equals("Admin")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
			List<User> userList = userDAO.getAllUsers("Instructor");

			request.setAttribute("userList", userList);
			session.removeAttribute("currentUserType");
			session.setAttribute("currentUserType", "Instructor");
			request.getRequestDispatcher("user-list.jsp").forward(request, response);
		}
		
	}

}
