/**
 * 
 */
package model;


/**
 * @author K
 *
 */
public class Question {
	private int id;
	private String question_description;
	private String option_one;
	private String option_two;
	private String option_three;
	private String option_four;
	private String answer;
	private float  mark;
	
	
	public Question(int id, String question_description, String option_one, String option_two,
			String option_three, String option_four, String answer, float mark) {
		super();
		this.id = id;
		this.question_description = question_description;
		this.option_one = option_one;
		this.option_two = option_two;
		this.option_three = option_three;
		this.option_four = option_four;
		this.answer = answer;
		this.mark = mark;
	}


	public Question(String question_description, String option_one, String option_two,
			String option_three, String option_four, String answer, float mark) {
		super();
		this.question_description = question_description;
		this.option_one = option_one;
		this.option_two = option_two;
		this.option_three = option_three;
		this.option_four = option_four;
		this.answer = answer;
		this.mark = mark;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getQuestion_description() {
		return question_description;
	}


	public void setQuestion_description(String question_description) {
		this.question_description = question_description;
	}

	public String getOption_one() {
		return option_one;
	}


	public void setOption_one(String option_one) {
		this.option_one = option_one;
	}


	public String getOption_two() {
		return option_two;
	}


	public void setOption_two(String option_two) {
		this.option_two = option_two;
	}


	public String getOption_three() {
		return option_three;
	}


	public void setOption_three(String option_three) {
		this.option_three = option_three;
	}


	public String getOption_four() {
		return option_four;
	}


	public void setOption_four(String option_four) {
		this.option_four = option_four;
	}


	public String getAnswer() {
		return answer;
	}


	public void setAnswer(String answer) {
		this.answer = answer;
	}


	public float getMark() {
		return mark;
	}


	public void setMark(float mark) {
		this.mark = mark;
	}

	
	
	}
