package com.spring.day1130_2.board;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
	private int num;
	private String id;
	private String subject;
	private String content;
	private MultipartFile file; // 파일 업로드를 위한 필드
	private String org_file; // 원본 파일 이름 저장
	private String up_file;  // 업로드된 파일 이름 저장
	private int re_ref;
	private int re_lev;
	private int re_seq;
	private int readcount;
	private Date boarddate;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public String getOrg_file() {
		return org_file;
	}
	public void setOrg_file(String org_file) {
		this.org_file = org_file;
	}
	public String getUp_file() {
		return up_file;
	}
	public void setUp_file(String up_file) {
		this.up_file = up_file;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Date getBoarddate() {
		return boarddate;
	}
	public void setBoarddate(Date boarddate) {
		this.boarddate = boarddate;
	}
}
