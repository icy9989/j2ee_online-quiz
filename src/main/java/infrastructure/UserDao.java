package infrastructure;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Course;
import model.SqlDataConnection;
import model.User;

public class UserDao {

	private static final String INSERT_STUDENT_SQL = "INSERT INTO user" + "  (username,email,password,role,course_one,course_two,course_three,course_four,course_five,course_six) VALUES " + " (?,?,?,?,?,?,?,?,?,?);";
	private static final String INSERT_INSTRUCTOR_SQL = "INSERT INTO user" + "  (username,email,password,role,course_one,course_two) VALUES " + " (?,?,?,?,?,?);";
	
	private static final String UPDATE_STUDENT_SQL = "update user set username=?,email=?,password=?,role=?,course_one=?,course_two=?,course_three=?,course_four=?,course_five=?,course_six=? where id =?;";
	private static final String UPDATE_INSTRUCTOR_SQL = "update user set username=?,email=?,password=?,role=?,course_one=?,course_two=? where id =?;";
	
	private static final String UPDATE_PASSWORD_SQL = "update user set password=? where id =?;";
	private static final String SELECT_USER_BY_ID = "select * from user where id =?";
	private static final String SELECT_USER_BY_EMAIL = "select * from user where email =?  and password =?";
	private static final String SELECT_ALL_USERS = "select * from user where role = ?";

	private static final String SELECT_STUDENTS_BY_COURSE = "select id,username from user where role = ?";

	private static final String DELETE_USER_SQL = "delete from user where id = ?;";
	
	SqlDataConnection sqlDataConnection = new SqlDataConnection();

	public UserDao() {
	}

	public void createStudent(User user) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();

		PreparedStatement preparedStatement = connection.prepareStatement(INSERT_STUDENT_SQL);			
		preparedStatement.setString(1, user.getUsername());
		preparedStatement.setString(2, user.getEmail());
		preparedStatement.setString(3, user.getPassword());
		preparedStatement.setString(4, user.getRole());
		preparedStatement.setString(5, user.getCourseList().get(0));
		preparedStatement.setString(6, user.getCourseList().get(1));
		preparedStatement.setString(7, user.getCourseList().get(2));
		preparedStatement.setString(8, user.getCourseList().get(3));
		preparedStatement.setString(9, user.getCourseList().get(4));
		preparedStatement.setString(10, user.getCourseList().get(5));
	
		preparedStatement.executeUpdate();
	}
	
	public void createInstructor(User user) throws SQLException {
		
		Connection connection = sqlDataConnection.getConnection();

		PreparedStatement preparedStatement = connection.prepareStatement(INSERT_INSTRUCTOR_SQL);

		preparedStatement.setString(1, user.getUsername());
		preparedStatement.setString(2, user.getEmail());
		preparedStatement.setString(3, user.getPassword());
		preparedStatement.setString(4, user.getRole());
		preparedStatement.setString(5, user.getCourseList().get(0));
		preparedStatement.setString(6, user.getCourseList().get(1));

		preparedStatement.executeUpdate();
	}

	public User selectUser(int id)throws SQLException {
		User user = null;
		ArrayList<String> courseList = new ArrayList<String>();

		Connection connection = sqlDataConnection.getConnection();

		PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID);
		preparedStatement.setInt(1, id);

		ResultSet rs = preparedStatement.executeQuery();

		while (rs.next()) {

			String userName = rs.getString("username");
			String email = rs.getString("email");
			String password = rs.getString("password");
			String role = rs.getString("role");
			String	course_one = rs.getString("course_one");
			String	course_two = rs.getString("course_two");
			String	course_three = rs.getString("course_three");
			String	course_four = rs.getString("course_four");
			String 	course_five = rs.getString("course_five");
			String	course_six = rs.getString("course_six");
				
			if(role.equals("Student")) {
				courseList.add(course_one);
				courseList.add(course_two);
				courseList.add(course_three);
				courseList.add(course_four);
				courseList.add(course_five);
				courseList.add(course_six);
			}
			else {
				courseList.add(course_one);
				courseList.add(course_two);
			}
				user = new User(id, userName, email, password, role, courseList);
			}
		
		return user;
	}
	
	public User selectUserByEmailAndPw(String mail,String pw) {
		User user = null;
		ArrayList<String> courseList = new ArrayList<String>();

		try(Connection connection = sqlDataConnection.getConnection();

		PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_EMAIL);){
		preparedStatement.setString(1, mail);
		preparedStatement.setString(2, pw);
		ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String userName = rs.getString("username");
				String email = rs.getString("email");
				String password = rs.getString("password");
				String role = rs.getString("role");
				String	course_one = rs.getString("course_one");
				String	course_two = rs.getString("course_two");
				String	course_three = rs.getString("course_three");
				String	course_four = rs.getString("course_four");
				String 	course_five = rs.getString("course_five");
				String	course_six = rs.getString("course_six");
				
				if(role.equals("Student")) {
					courseList.add(course_one);
					courseList.add(course_two);
					courseList.add(course_three);
					courseList.add(course_four);
					courseList.add(course_five);
					courseList.add(course_six);
				}
				else {
					courseList.add(course_one);
					courseList.add(course_two);
				}
				user = new User(id, userName, email, password, role, courseList);
			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return user;
	}
	
	public List<User> getAllUsers(String role) {

		ArrayList<User> users = new ArrayList<User>();
		ArrayList<String> courseList =  new ArrayList<String>();
		CourseDao courseDAO = new CourseDao();
		List<Course> courses = courseDAO.getAllCourses();
		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS);) {
	
			preparedStatement.setString(1, role);
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String userName = rs.getString("username");
				String email = rs.getString("email");
				String password = rs.getString("password");
				String	course_one = rs.getString("course_one");
				String	course_two = rs.getString("course_two");
				String	course_three = rs.getString("course_three");
				String	course_four = rs.getString("course_four");
				String 	course_five = rs.getString("course_five");
				String	course_six = rs.getString("course_six");
				if(role.equals("Student")) {
					courseList.add(course_one);
					courseList.add(course_two);
					courseList.add(course_three);
					courseList.add(course_four);
					courseList.add(course_five);
					courseList.add(course_six);
				}
				else {
					courseList.add(course_one);
					courseList.add(course_two);
				}
				ArrayList<String> cList = new ArrayList<String>();
				cList.addAll(courseList);
				
				List<String> tmpUserCourseList = courses.stream().filter(e -> cList.contains(e.getCode())).map(e->e.getCode()).toList();
				ArrayList<String> userCourseList = new ArrayList<String>();
				for (int i = 0; i < tmpUserCourseList.stream().count(); i++) {
					userCourseList.add(tmpUserCourseList.get(i));
				}
				users.add(new User(id, userName, email, password, role, userCourseList));
				courseList.clear();
			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return users;
	}

	public void deleteUser(int id) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();
		PreparedStatement statement = connection.prepareStatement(DELETE_USER_SQL);
		statement.setInt(1, id);
		statement.executeUpdate();
		
	}

	public void updateStudent(User user) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();
		PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_STUDENT_SQL);
			
		preparedStatement.setString(1, user.getUsername());
		preparedStatement.setString(2, user.getPassword());
		preparedStatement.setString(3, user.getRole());
		preparedStatement.setString(4, user.getCourseList().get(0));
		preparedStatement.setString(5, user.getCourseList().get(1));
		preparedStatement.setString(6, user.getCourseList().get(2));
		preparedStatement.setString(7, user.getCourseList().get(3));
		preparedStatement.setString(8, user.getCourseList().get(4));
		preparedStatement.setString(9, user.getCourseList().get(5));
		preparedStatement.setInt(10, user.getId());
		preparedStatement.executeUpdate();
	}

	public void updateInstructor(User user) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();
		PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_INSTRUCTOR_SQL);

		preparedStatement.setString(1, user.getUsername());
		preparedStatement.setString(2, user.getPassword());
		preparedStatement.setString(3, user.getRole());
		preparedStatement.setString(4, user.getCourseList().get(0));
		preparedStatement.setString(5, user.getCourseList().get(1));
		preparedStatement.setInt(6, user.getId());
		preparedStatement.executeUpdate();
	}
	
	public void updatePassword(int id,String pw) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();
		PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PASSWORD_SQL);

		preparedStatement.setString(1, pw);
		preparedStatement.setInt(2, id);
		preparedStatement.executeUpdate();
	}
	private void printSQLException(SQLException ex) {
		for (Throwable e : ex) {
			if (e instanceof SQLException) {
				e.printStackTrace(System.err);
				System.err.println("SQLState: " + ((SQLException) e).getSQLState());
				System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
				System.err.println("Message: " + e.getMessage());
				Throwable t = ex.getCause();
				while (t != null) {
					System.out.println("Cause: " + t);
					t = t.getCause();
				}
			}
		}
	}

}
