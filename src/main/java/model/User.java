package model;

import java.util.ArrayList;

public class User {
	private int id;
	private String username;
	private String email;
	private String password;
	private String role;
	private ArrayList<String> courseList;
	public User(int id, String username, String email, String password, String role, ArrayList<String> courseList) {
		super();
		this.id = id;
		this.username = username;
		this.email = email;
		this.password = password;
		this.role = role;
		this.courseList = courseList;
	}
	public User(String username, String email, String password, String role, ArrayList<String> courseList) {
		super();
		this.username = username;
		this.email = email;
		this.password = password;
		this.role = role;
		this.courseList = courseList;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public ArrayList<String> getCourseList() {
		return courseList;
	}
	public void setCourseList(ArrayList<String> courseList) {
		this.courseList = courseList;
	}
	
	
}
