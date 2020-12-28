package com.project.samsam.member;

import org.springframework.web.multipart.MultipartFile;

public class RequestModel {

	private String name;
	private MultipartFile file[]; //업로드할 파일 리스트 저장
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public MultipartFile[] getFile() {
		return file;
	}
	public void setFile(MultipartFile[] file) {
		this.file = file;
	}
	
	
}
