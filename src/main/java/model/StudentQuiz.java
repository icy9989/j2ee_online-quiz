package model;

public class StudentQuiz {
	private int id;
	private String name;
	private String date;
	private float total_mark;
	private StudentMark studentMark;
	public StudentQuiz(int id, String name, String date, float total_mark, StudentMark studentMark) {
		super();
		this.id = id;
		this.name = name;
		this.date = date;
		this.total_mark = total_mark;
		this.studentMark = studentMark;
	}
	public StudentQuiz(String name, String date, float total_mark, StudentMark studentMark) {
		super();
		this.name = name;
		this.date = date;
		this.total_mark = total_mark;
		this.studentMark = studentMark;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public float getTotal_mark() {
		return total_mark;
	}
	public void setTotal_mark(float total_mark) {
		this.total_mark = total_mark;
	}
	public StudentMark getStudentMark() {
		return studentMark;
	}
	public void setStudentMark(StudentMark studentMark) {
		this.studentMark = studentMark;
	}
	
}
