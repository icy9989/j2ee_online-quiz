package controller.user;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.UserDao;

@WebServlet("/delete-user")
public class UserDeleteServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDAO;

	@Override
	public void init() {
		userDAO = new UserDao();
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
		
		int id = Integer.parseInt(request.getParameter("id"));
		String role = request.getParameter("role");
		String serveletName = role.toLowerCase();
		try {
			userDAO.deleteUser(id);
			session.setAttribute("userActionDoneMsg", "Deleted");
			response.sendRedirect(serveletName);
		} catch (SQLException e) {
			session.setAttribute("userActionFailedMsg", e.getMessage());
			response.sendRedirect(serveletName);
		}
	}
	}
}
