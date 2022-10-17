package model;

public class StudentMark {
	private int id;
	private String name;
	private float mark;
	public StudentMark(int id, String name, float mark) {
		super();
		this.id = id;
		this.name = name;
		this.mark = mark;
	}
	public StudentMark(String name, float mark) {
		super();
		this.name = name;
		this.mark = mark;
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
	public float getMark() {
		return mark;
	}
	public void setMark(float mark) {
		this.mark = mark;
	}
	
	
	
}
