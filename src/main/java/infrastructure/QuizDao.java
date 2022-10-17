package infrastructure;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Question;
import model.Quiz;
import model.SqlDataConnection;

public class QuizDao {

	private static final String INSERT_QUIZ_SQL = "INSERT INTO quiz" + "  (course_id,name,date,start_time,duration,total_question,total_mark,published) VALUES " + " (?,?,?,?,?,?,?,?);";
	private static final String SELECT_QUIZ_BY_ID = "select * from quiz where id =?";
	private static final String SELECT_ALL_QUIZZES = "select * from quiz where course_id=?";
	private static final String DELETE_QUIZ_SQL = "delete from quiz where id = ?;";
	private static final String UPDATE_QUIZ_SQL = "update quiz set name=?,date=?,start_time=?,duration=?,total_question=?,total_mark=?,published=? where id =?;";
	private static final String SELECT_QUIZ_ID = "select id from quiz where name = ?;";
	private static final String GET_QUIZZ_ID = "select id from quiz where course_id=? and name=?";
	private static final String GET_QUIZZ_NAME = "select name from quiz where id=?";
	private static final String GET_COURSE_ID_BY_QUIZZ_ID = "select course_id from quiz where id=?";
	SqlDataConnection sqlDataConnection = new SqlDataConnection();
	QuestionDao questionDao = new QuestionDao();
	
	public QuizDao() {
		
	}

	public void createQuiz(Quiz quiz,ArrayList<Question> qList) throws SQLException {
		QuestionDao questionDao = new QuestionDao();
		Connection connection = sqlDataConnection.getConnection();
	    PreparedStatement preparedStatement1 = connection.prepareStatement(INSERT_QUIZ_SQL);

		preparedStatement1.setString(1, quiz.getCourse_id());
		preparedStatement1.setString(2, quiz.getName());
		preparedStatement1.setString(3, quiz.getDate());
		preparedStatement1.setString(4, quiz.getStartTime());
		preparedStatement1.setInt(5, quiz.getDuration());
		preparedStatement1.setInt(6, quiz.getTotal_question());
		preparedStatement1.setFloat(7, quiz.getTotal_mark());
		preparedStatement1.setString(8, quiz.isPublished());
		
		preparedStatement1.executeUpdate();
		
	    PreparedStatement preparedStatement2 = connection.prepareStatement(SELECT_QUIZ_ID);

		preparedStatement2.setString(1, quiz.getName());

		ResultSet rs = preparedStatement2.executeQuery();
		int quiz_id = -1;
		while(rs.next()) {
			quiz_id = rs.getInt("id");
		}
		
			for (int i = 0; i < qList.stream().count(); i++) {
				
				questionDao.createQuestion(qList.get(i),quiz_id);
			}
	}
	
	public void updateQuiz(Quiz quiz,ArrayList<Question> qList) throws SQLException {

		QuestionDao questionDao = new QuestionDao();
		Connection connection = sqlDataConnection.getConnection();
				PreparedStatement preparedStatement1 = connection.prepareStatement(UPDATE_QUIZ_SQL);
			for (int i = 0; i < qList.stream().count(); i++) {
				questionDao.updateQuestion(qList.get(i));
			}

			preparedStatement1.setString(1, quiz.getName());
			preparedStatement1.setString(2, quiz.getDate());
			preparedStatement1.setString(3, quiz.getStartTime());	
			preparedStatement1.setInt(4, quiz.getDuration());
			preparedStatement1.setInt(5, quiz.getTotal_question());
			preparedStatement1.setFloat(6, quiz.getTotal_mark());
			preparedStatement1.setString(7, quiz.isPublished());
			preparedStatement1.setInt(8, quiz.getId());
			preparedStatement1.executeUpdate();
	}


	public int getQuizId(String courseId, String quizName) {
		
		int id = 0;

		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(GET_QUIZZ_ID);) {
			preparedStatement.setString(1, courseId);
			preparedStatement.setString(2, quizName);
			System.out.println("Hello getQuizId " + preparedStatement);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				 id = rs.getInt("id");
				}
		} catch (SQLException e) {
			printSQLException(e);
		}
		
		System.out.println("Hello getQuizId 1 " + id);
		return id;
	}
	
	public Quiz getQuizById(String quiz_id) {

		Quiz quiz = null;

		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_QUIZ_BY_ID);) {
			
			preparedStatement.setString(1, quiz_id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String course_id = rs.getString("course_id");
				String name = rs.getString("name");
				String date = rs.getString("date");
				String startTime = rs.getString("start_time");
				int duration = rs.getInt("duration");
				int total_question = rs.getInt("total_question");
				int total_mark = rs.getInt("total_mark");
				String published = rs.getString("published");
				quiz = new Quiz(id,name,course_id, date,startTime, duration, total_question, total_mark,published);
			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return quiz;
	}
	
	public void deleteQuiz(int id) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();
		PreparedStatement statement = connection.prepareStatement(DELETE_QUIZ_SQL);
		statement.setInt(1, id);
		statement.executeUpdate();
	}
	
	public List<Question> getAllQuestion(String quiz_id) {
		return questionDao.getAllQuestions(quiz_id);
	}
		
	public List<Quiz> getAllQuizzes(String courseId) {

		List<Quiz> quizzes = new ArrayList<>();

		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_QUIZZES);) {
			preparedStatement.setString(1, courseId);
			System.out.println("Hello 3 " + preparedStatement);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String course_id = rs.getString("course_id");
				String name = rs.getString("name");
				String date = rs.getString("date");
				String startTime = rs.getString("start_time");
				int duration = rs.getInt("duration");
				int total_question = rs.getInt("total_question");
				int total_mark = rs.getInt("total_mark");
				String published = rs.getString("published");
				
				quizzes.add(new Quiz(id,name,course_id, date,startTime, duration, total_question, total_mark,published));
			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		System.out.println("Hello 4 " + quizzes);
		return quizzes;
	}
	
	public String getQuizName(int quizId) {
		
		String name = "";

		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(GET_QUIZZ_NAME);) {
			preparedStatement.setInt(1, quizId);
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				 name = rs.getString("name");
				}
		} catch (SQLException e) {
			printSQLException(e);
		}
		
		return name;
	}
	
	public String getCourseIdByQuizId(int quizId) {
		
		String name = "";

		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(GET_COURSE_ID_BY_QUIZZ_ID);) {
			preparedStatement.setInt(1, quizId);
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				 name = rs.getString("course_id");
				}
		} catch (SQLException e) {
			printSQLException(e);
		}
		
		return name;
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
