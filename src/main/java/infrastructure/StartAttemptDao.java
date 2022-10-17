package infrastructure;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.SqlDataConnection;
import model.Start_attempt;

public class StartAttemptDao {

	private static final String INSERT_START_ATTEMPT_SQL = "INSERT INTO start_attempt" + "  (user_id, quiz_id, start_time) VALUES " + " (?,?,?);";
	private static final String SELECT_START_TIME_BY_USER_ID_AND_QUIZ_ID = "select start_time from start_attempt where user_id = ? and quiz_id = ?";
	SqlDataConnection sqlDataConnection = new SqlDataConnection();
	
	public void createStartAttempt(Start_attempt sa) throws SQLException {

		Connection connection = sqlDataConnection.getConnection();

		PreparedStatement preparedStatement = connection.prepareStatement(INSERT_START_ATTEMPT_SQL);
		
		preparedStatement.setInt(1, sa.getUserId());
		preparedStatement.setInt(2, sa.getQuizId());
		preparedStatement.setString(3, sa.getStartTime());
		preparedStatement.executeUpdate();	
	}
	
	public String getStartTime(int user_id, int quiz_id) {
		
		String start_time = "";

		try (Connection connection = sqlDataConnection.getConnection();

				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_START_TIME_BY_USER_ID_AND_QUIZ_ID);) {
			preparedStatement.setInt(1, user_id);
			preparedStatement.setInt(2, quiz_id);
			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				start_time = rs.getString("start_time");

			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return start_time;
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
