package controller.common;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.UserDao;
import model.User;

@WebServlet("/ChangePassword")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDao;

	@Override
	public void init() {
		userDao = new UserDao();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String old_pw = request.getParameter("old_pw");
		String new_pw = request.getParameter("new_pw");
		String id = request.getParameter("user_id");
		String role = request.getParameter("role");

		String serveletName = role.toLowerCase()+"-dashboard";
		int user_id = Integer.parseInt(id);
		try {
			User user = userDao.selectUser(user_id);
			 if(user.getPassword().equals(old_pw)) {
		      	userDao.updatePassword(user_id, new_pw);
		        session.setAttribute("passwordChangeDoneMsg", "Password Changed Successfully.");
		     }
		     else {
		        session.setAttribute("passwordChangeFailedMsg", "Old password is not correct.");
		     }
		}catch (SQLException e) {
			session.setAttribute("passwordChangeFailedMsg", e.getMessage());
		}
    	response.sendRedirect(serveletName);
	}

}
