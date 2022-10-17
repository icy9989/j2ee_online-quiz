package model;

public class Quiz {
	private int id;
	private String name;
	private String course_id;
	private String date;
	private String startTime;
	private int duration;
	private int total_question;
	private float total_mark;
	private String published;
	
	public Quiz(int id, String name, String course_id, String date, String startTime, int duration, int total_question,
			float total_mark, String published) {
		super();
		this.id = id;
		this.name = name;
		this.course_id = course_id;
		this.date = date;
		this.startTime = startTime;
		this.duration = duration;
		this.total_question = total_question;
		this.total_mark = total_mark;
		this.published = published;
	}
	public Quiz(String name, String course_id, String date, String startTime, int duration, int total_question,
			float total_mark, String published) {
		super();
		this.name = name;
		this.course_id = course_id;
		this.date = date;
		this.startTime = startTime;
		this.duration = duration;
		this.total_question = total_question;
		this.total_mark = total_mark;
		this.published = published;
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
	public String getCourse_id() {
		return course_id;
	}
	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public int getTotal_question() {
		return total_question;
	}
	public void setTotal_question(int total_question) {
		this.total_question = total_question;
	}
	public float getTotal_mark() {
		return total_mark;
	}
	public void setTotal_mark(float total_mark) {
		this.total_mark = total_mark;
	}
	public String isPublished() {
		return published;
	}
	public void setPublished(String published) {
		this.published = published;
	}
	public String getPublished() {
		return published;
	}
	
}
