package com.spring.day1127;

public class SungjukProcessVO {

	private String hakbun, name;
	private String grade=null;
	private int kor, eng, math, tot;
	private double avg;
	
	public void process() {
		tot = kor + eng + math;
		avg = tot/3.;
		
		switch((int)(avg/10)){
		case 10:
		case 9:
			grade = "수";
			return;
		case 8:
			grade = "우";
			return;
		case 7:
			grade = "미";
			return;
		case 6:
			grade = "양";
			return;
		default:
			grade = "가";
			return;
		}
	}//프로세스
	public String getHakbun() {
		return hakbun;
	}
	public void setHakbun(String hakbun) {
		this.hakbun = hakbun;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public int getKor() {
		return kor;
	}
	public void setKor(int kor) {
		this.kor = kor;
	}
	public int getEng() {
		return eng;
	}
	public void setEng(int eng) {
		this.eng = eng;
	}
	public int getMath() {
		return math;
	}
	public void setMath(int math) {
		this.math = math;
	}
	public int getTot() {
		return tot;
	}
	public void setTot(int tot) {
		this.tot = tot;
	}
	public double getAvg() {
		return avg;
	}
	public void setAvg(double avg) {
		this.avg = avg;
	}
	
	
}
