package infrastructure;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Question;
import model.SqlDataConnection;

public class QuestionDao {

	private static final String INSERT_QUESTION_SQL = "INSERT INTO question"
			+ "  ( question, option_one, option_two, option_three, option_four, answer, mark, quiz_id) VALUES "
			+ " (?,?,?,?,?,?,?,?);";

	private static final String SELECT_QUESTION_BY_ID = "select * from question where id =?";
	private static final String SELECT_ALL_QUESTIONS = "select * from question where quiz_id=?";
	private static final String DELETE_QUESTION_SQL = "delete from quesition where id = ?;";
	private static final String UPDATE_QUESTION_SQL = "update question set question =?, option_one =?, option_two =?, option_three =?, option_four =?, answer =?, mark=? where id =?;";
	private static final String SELECT_FIRST_QUESTION_ID_OF_QUIZ = "select id from question where quiz_id=?";
	private static final String SELECT_ANSWER_BY_QUESTION_ID = "select answer from question where id=?";
	private static final String SELECT_MARK_BY_QUESTION_ID = "select mark from question where id=?";
	
	SqlDataConnection sqlDataConnection = new SqlDataConnection();

	public QuestionDao() {
	}

	public void createQuestion(Question question,int quiz_id) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();
		PreparedStatement preparedStatement = connection.prepareStatement(INSERT_QUESTION_SQL);
		preparedStatement.setString(1, question.getQuestion_description());
		preparedStatement.setString(2, question.getOption_one());
		preparedStatement.setString(3, question.getOption_two());
		preparedStatement.setString(4, question.getOption_three());
		preparedStatement.setString(5, question.getOption_four());
		preparedStatement.setString(6, question.getAnswer());
		preparedStatement.setFloat(7, question.getMark());
		preparedStatement.setInt(8, quiz_id);
		preparedStatement.executeUpdate();
	}

	public Question selectQuestion(int id) throws SQLException{
		Question question = null;
		Connection connection = sqlDataConnection.getConnection();
	
		PreparedStatement preparedStatement = connection.prepareStatement(SELECT_QUESTION_BY_ID);
		preparedStatement.setInt(1, id);		
		ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				String question_description = rs.getString("question");
				String option_one = rs.getString("option_one");
				String option_two = rs.getString("option_two");
				String option_three = rs.getString("option_three");
				String option_four = rs.getString("option_four");
				String answer = rs.getString("answer");
				float mark = rs.getFloat("mark");

				question = new Question(id, question_description,option_one, option_two, option_three, option_four, answer, mark);
			}
		return question;
	}

	public List<Question> getAllQuestions(String quiz_id) {

		List<Question> questions = new ArrayList<>();

		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_QUESTIONS);) {
			System.out.println(preparedStatement);
			preparedStatement.setString(1, quiz_id);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String question_description = rs.getString("question");
				String option_one = rs.getString("option_one");
				String option_two = rs.getString("option_two");
				String option_three = rs.getString("option_three");
				String option_four = rs.getString("option_four");
				String answer = rs.getString("answer");
				float mark = rs.getFloat("mark");
				questions.add(new Question(id, question_description, option_one, option_two, option_three,
						option_four, answer, mark));

			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return questions;
	}

	public void deleteQuestion(int id) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();
		PreparedStatement statement = connection.prepareStatement(DELETE_QUESTION_SQL);
		statement.setInt(1, id);
	}

	public void updateQuestion(Question question) throws SQLException {
		Connection connection = sqlDataConnection.getConnection();
		PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_QUESTION_SQL);
		preparedStatement.setString(1, question.getQuestion_description());
		preparedStatement.setString(2, question.getOption_one());
		preparedStatement.setString(3, question.getOption_two());
		preparedStatement.setString(4, question.getOption_three());
		preparedStatement.setString(5, question.getOption_four());
		preparedStatement.setString(6, question.getAnswer());
		preparedStatement.setFloat(7, question.getMark());
		preparedStatement.setInt(8, question.getId());
		preparedStatement.executeUpdate();
	}
	
	public int getQuestionId(int quiz_id) {
		
		int id = 0;

		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_FIRST_QUESTION_ID_OF_QUIZ );) {
			System.out.println("AAA 1 " + preparedStatement);
			preparedStatement.setInt(1, quiz_id);
			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				id = rs.getInt("id");

			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		System.out.println("AAA 2 " + id);
		return id;
	}
	
	public String getAnswerByQuestionID(int question_id) {
		
		String answer = null;

		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ANSWER_BY_QUESTION_ID);) {
			preparedStatement.setInt(1, question_id);
			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				answer = rs.getString("answer");

			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return answer;
	}
	
	public float getMarkByQuestionID(int question_id) {
		
		float mark = 0.0f;

		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_MARK_BY_QUESTION_ID);) {
			preparedStatement.setInt(1, question_id);
			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				mark = rs.getFloat("mark");

			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return mark;
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
