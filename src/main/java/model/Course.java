package model;

import java.io.Serializable;
import java.util.ArrayList;

public class Course implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String code;
	private String courseName;
	private ArrayList<String> quizList;

	public Course(int id, String code, String courseName, ArrayList<String> quizList) {
		super();
		this.id = id;
		this.code = code;
		this.courseName = courseName;
		this.quizList = quizList;
	}

	public Course(int id, String code, String courseName) {
		super();
		this.id = id;
		this.code = code;
		this.courseName = courseName;
	}

	public Course(String code, String courseName) {
		super();
		this.code = code;
		this.courseName = courseName;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public ArrayList<String> getQuizList() {
		return quizList;
	}

	public void setQuizList(ArrayList<String> quizList) {
		this.quizList = quizList;
	}

	
}
