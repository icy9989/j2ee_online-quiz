package infrastructure;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.SqlDataConnection;
import model.User_answer;

public class UserAnswerDao {
	
	private static final String INSERT_USER_ANSWER_SQL = "INSERT INTO user_answer" + "  (user_id, quiz_id, question_id, user_selected_option) VALUES " + " (?,?,?,?);";
	private static final String GET_USER_SELECTED_OPTION = "select user_selected_option from user_answer where user_id = ? and question_id = ?";
	SqlDataConnection sqlDataConnection = new SqlDataConnection();
	
	public void createUserAnswer(User_answer ua) throws SQLException {

		Connection connection = sqlDataConnection.getConnection();

		PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_ANSWER_SQL);
		
		preparedStatement.setInt(1, ua.getUserId());
		preparedStatement.setInt(2, ua.getQuizId());
		preparedStatement.setInt(3, ua.getQuestionId());
		preparedStatement.setString(4, ua.getUserSelectedOption());
		preparedStatement.executeUpdate();	
	}
	
	public String getUserSelectedOption(int userId, int questionId) {
		
		String option = null;

		try (Connection connection = sqlDataConnection.getConnection();

			PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_SELECTED_OPTION);) {
				preparedStatement.setInt(1, userId);
				preparedStatement.setInt(2, questionId);
				
				ResultSet rs = preparedStatement.executeQuery();
				
				if (rs.next()) {
					option = rs.getString("user_selected_option");
				}
				
			} catch (SQLException e) {
				printSQLException(e);
			}
		
		return option;
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
