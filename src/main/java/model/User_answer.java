package model;

public class User_answer {
	
	private int id;
	private int userId;
	private int quizId;
	private int questionId;
	private String userSelectedOption;
	
	public User_answer(int userId, int quizId, int questionId, String userSelectedOption) {
		super();
		this.userId = userId;
		this.quizId = quizId;
		this.questionId = questionId;
		this.userSelectedOption = userSelectedOption;
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
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public String getUserSelectedOption() {
		return userSelectedOption;
	}
	public void setUserSelectedOption(String userSelectedOption) {
		this.userSelectedOption = userSelectedOption;
	}
	
	

}
