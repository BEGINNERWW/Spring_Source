package com.project.samsam.board;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.sql.Date;

public class JJABoardVO {
	private String startDate;
	private String endDate;
	private String kind;
	private String category;
	private String keyword;
	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	
	public String getCategory() {
		return category;
	}
	public void setKategorie(String category) {
		this.category = category;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}

	
	
	

}
