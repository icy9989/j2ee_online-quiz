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

public class CourseDao {

	private static final String INSERT_COURSE_SQL = "INSERT INTO course" + "  (code,course_name) VALUES " + " (?,?);";
	private static final String SELECT_COURSE_BY_ID = "select id,code,course_name from course where id =?";
	private static final String SELECT_ALL_COURSES = "select * from course";
	private static final String DELETE_COURSE_SQL = "delete from course where id = ?;";
	private static final String UPDATE_COURSE_SQL = "update course set code =?,course_name=? where id =?;";
	private static final String SELECT_STUDENT_COURSE = "select course.course_name from course inner join user on course.code=?;";
	private static final String GET_COURSE_CODE = "select code from course where course_name=?;";
	private static final String GET_COURSE_NAME = "select course_name from course where code=?;";

	
	SqlDataConnection sqlDataConnection = new SqlDataConnection();

	public CourseDao() {
	}

	public void createCourse(Course course) throws SQLException {

		Connection connection = sqlDataConnection.getConnection();

		PreparedStatement preparedStatement = connection.prepareStatement(INSERT_COURSE_SQL);

		preparedStatement.setString(1, course.getCode());
		preparedStatement.setString(2, course.getCourseName());
		preparedStatement.executeUpdate();	
	}

	public Course selectCourse(int id) throws SQLException {
		Course course = null;

		Connection connection = sqlDataConnection.getConnection();

		PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COURSE_BY_ID);
		preparedStatement.setInt(1, id);
		ResultSet rs = preparedStatement.executeQuery();

		while (rs.next()) {
			String code = rs.getString("code");
			String courseName = rs.getString("course_name");

			course = new Course(id,code, courseName);
			}
		
		return course;
	}

	public List<Course> getAllCourses(){

		List<Course> courses = new ArrayList<>();
		Connection connection = sqlDataConnection.getConnection();
			
		ResultSet rs;
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_COURSES);

			rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				int id = rs.getInt("id");
				String code = rs.getString("code");
				String courseName = rs.getString("course_name");
				courses.add(new Course(id, code, courseName));
			}
			
		} catch (SQLException e) {
			printSQLException(e);
		}

		return courses;
	}

	public ArrayList<String> getStudentCourse(User std) {

		ArrayList<String> courses = new ArrayList<>();
		try (Connection connection = sqlDataConnection.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENT_COURSE);) {
			int stdCourseLength = std.getCourseList().size();
			for (int i = 0; i < stdCourseLength ; i++) {
				preparedStatement.setString(1, std.getCourseList().get(i));
				System.out.println(preparedStatement);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					String courseName = rs.getString("course_name");
					System.out.println(courseName);
					if(!courses.contains(courseName)) {
						courses.add(courseName);
					}
				}
			}
			
		} catch (SQLException e) {
				printSQLException(e);
			}
		return courses;		
	}
	
	public void deleteCourse(int id) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();
		PreparedStatement statement = connection.prepareStatement(DELETE_COURSE_SQL);
		statement.setInt(1, id);
		statement.executeUpdate();

	}

	public void updateCourse(Course course) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();
		PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_COURSE_SQL);

		preparedStatement.setString(1, course.getCode());
		preparedStatement.setString(2, course.getCourseName());
		preparedStatement.setInt(3, course.getId());
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
	
	public String getCourseCode(String courseName) {

		String code = "";
		
		try (Connection connection = sqlDataConnection.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(GET_COURSE_CODE);) {
			preparedStatement.setString(1, courseName);
			System.out.println("Hello 1 " + preparedStatement);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				code = rs.getString("code");
				System.out.println("Hello 2 " + code);	
			}
			
		} catch (SQLException e) {
				printSQLException(e);
		}
		
		return code;		
	}
	
	public String getCourseName(String courseId) {

		String name = "";
		
		try (Connection connection = sqlDataConnection.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(GET_COURSE_NAME);) {
			preparedStatement.setString(1, courseId);
			System.out.println("Hello 1 " + preparedStatement);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				name = rs.getString("course_name");
				System.out.println("Hello 2 " + name);	
			}
			
		} catch (SQLException e) {
				printSQLException(e);
		}
		
		return name;		
	}

}
