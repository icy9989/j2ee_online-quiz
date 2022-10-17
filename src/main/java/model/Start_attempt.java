package model;

public class Start_attempt {
	
	private int id;
	private int userId;
	private int quizId;
	private String startTime;
	
	public Start_attempt(int userId, int quizId, String startTime) {
		super();
		this.userId = userId;
		this.quizId = quizId;
		this.startTime = startTime;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getQuizId() {
		return quizId;
	}
	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

}
