package model;

public class Submit_attempt {
	
	private int id;
	private int userId;
	private int quizId;
	private String submitTime;
	
	public Submit_attempt(int userId, int quizId, String submitTime) {
		super();
		this.userId = userId;
		this.quizId = quizId;
		this.submitTime = submitTime;
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
	public String getSubmitTime() {
		return submitTime;
	}
	public void setSubmitTime(String submitTime) {
		this.submitTime = submitTime;
	}
	
	

}
