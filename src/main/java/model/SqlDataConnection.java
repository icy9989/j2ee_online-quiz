package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SqlDataConnection {
//	private String jdbcURL = "jdbc:mysql://db4free.net:3306/oqs123456?useSSL=FALSE";
	private String jdbcURL = "jdbc:mysql://localhost:3306/oqs123456";
	
	private String jdbcUsername = "root";
	private String jdbcPassword = "";

	public Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
			System.out.println("fsdfsfggfhfghfkgh");
			System.out.println(connection.getCatalog());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	}
}
