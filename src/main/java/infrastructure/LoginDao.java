package infrastructure;

import model.User;

public class LoginDao {
	public User validate(String email, String password) {

		UserDao userDAO = new UserDao();
		
		return userDAO.selectUserByEmailAndPw(email, password);
		
		
	}
}
