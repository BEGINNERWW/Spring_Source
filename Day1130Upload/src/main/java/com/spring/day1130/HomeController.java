package com.spring.day1130;

import java.io.*;
import java.util.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	

	@RequestMapping(value = "/fileUploadForm.bo")
	public String fileUploadForm() {
		
		return "fileUploadForm";
	}
	
	//커맨드 객체(VO, DTO)를 통한 업로드 파일 접금
	//커맨드 클래스에 파라미터와 동일한 이름의 MultipartFile 타입 프로퍼티를 추가해주기만 하면
	//업로드 파일 정보를 커맨드객체를 통해 전달 받을수 있게 된다.
	
	@RequestMapping(value = "/fileUpload1.bo")
	public ModelAndView fileUpload1(HttpServletRequest request, RequestModel model) throws Exception{
		String name = request.getParameter("name");
		String uploadPath = "C:\\Project\\upload\\"; //직접 업로드 위치 지정 _ 외부경로
				
		//뷰 지정
		ModelAndView mav = new ModelAndView();
		mav.setViewName("download");
		
		ArrayList<String> orgfile_list = new ArrayList<String>(); //원본 파일 리스트
		ArrayList<String> storedfile_list = new ArrayList<String>(); //서버에 저장될 파일이름(리스트)
		ArrayList<Long> filesize_list = new ArrayList<Long>();
		for(MultipartFile mf : model.getFile()) {
			String originFileName = mf.getOriginalFilename();// 원본 파일 명
			long fileSize = mf.getSize();//파일 사이즈
			
			System.out.println("originFileName : " + originFileName);
			System.out.println("fileSize : " + fileSize);
			String storedFileName = System.currentTimeMillis() + originFileName;
			System.out.println("storedFileName : " + storedFileName);
			String safeFile = uploadPath + storedFileName;
			
			try {
				if(mf.getSize() !=0 ) {
					mf.transferTo(new File(safeFile)); //업로드에 사용되는 메소드 : transferTo
				}
			}catch(IOException e) {
				System.out.println("업로드 에러!!");
			}
			orgfile_list.add(originFileName);
			storedfile_list.add(storedFileName);
			filesize_list.add(fileSize);
		}
		//뷰에 출력한 데이터 모델에 저장
		mav.addObject("name", name);
		mav.addObject("orgfile_list",orgfile_list);
		mav.addObject("storedfile_list",storedfile_list);
		mav.addObject("filesize_list",filesize_list);
		mav.addObject("uploadPath", uploadPath);
		
		return mav;
	}
	//MultipartHttpServletRequest를 이용한 업로드 파일 접근
	@RequestMapping(value = "/fileUpload2.bo")
	public ModelAndView fileUpload2(MultipartHttpServletRequest request) throws Exception{
		String name = request.getParameter("name");
		List<MultipartFile> fileList = request.getFiles("file");
		
		String uploadPath = "C:\\Project\\upload\\"; //직접 업로드 위치 지정
		
		//뷰 지정
		ModelAndView mav = new ModelAndView();
		mav.setViewName("download");
		
		ArrayList<String> orgfile_list = new ArrayList<String>();
		ArrayList<String> storedfile_list = new ArrayList<String>();
		ArrayList<Long> filesize_list = new ArrayList<Long>();
		for(MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename();// 원본 파일 명
			long fileSize = mf.getSize();//파일 사이즈
			
			System.out.println("originFileName : " + originFileName);
			System.out.println("fileSize : " + fileSize);
			String storedFileName = System.currentTimeMillis() + originFileName;
			System.out.println("storedFileName : " + storedFileName);
			String safeFile = uploadPath + storedFileName;
			
			try {
				if(mf.getSize() !=0 ) {
					mf.transferTo(new File(safeFile));
				}
			}catch(IOException e) {
				System.out.println("업로드 에러!!");
			}
			orgfile_list.add(originFileName);
			storedfile_list.add(storedFileName);
			filesize_list.add(fileSize);
		}
		//뷰에 출력한 데이터 모델에 저장
		mav.addObject("name", name);
		mav.addObject("orgfile_list",orgfile_list);
		mav.addObject("storedfile_list",storedfile_list);
		mav.addObject("filesize_list",filesize_list);
		mav.addObject("uploadPath", uploadPath);
		
		return mav;
	}
	//파일 다운로드 방식
	@RequestMapping(value = "/fileDownload.bo")
	public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setCharacterEncoding("utf-8");
		
		String of = request.getParameter("of"); //서버에 업로드된 변경된 실제 파일명
		String of2 = request.getParameter("of2"); // 오리지널 파일명
		
		/*//웹사이트 루트디렉토리의 실제 디스크상의 경로 알아내기
		 String uploadPath = request.getSession().getServletContext().get
		 String fullPath = uploadPath + "/" + of;
		 */
		String uploadPath = "C:\\Project\\upload\\"; //직접 경로 지정
		String fullPath = uploadPath + of;
		File downloadFile = new File(fullPath);
		
		//파일 다운로드를 위해 컨텐츠 타입을 application/download 설정
		response.setContentType("application/download; charset=UTF-8");
		//파일 사이즈 지정
		response.setContentLength((int)downloadFile.length());
		//다운로드 창을 띄우기 위한 헤더 조장
		response.setHeader("Content-Disposition","attachment;filename="+new String(of2.getBytes(), "ISO8859_1"));
		response.setHeader("Content-Transfer-Encoding", "binary");
		/*
		 * Content-disposition 속성
		 * 1)"Content-disposition : attachment" 브라우저 인식 파일 확장자를 포함하여 모든 확장자 파일들에 대해,
		 * 		다운로드시 무조건 "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성
		 * 2)"Content-disposition : inline" 브라우저 인식 파일확장자를 가진 파일들에 대해서는 웹브라우저 상에서 바로 파일을 열고, 
		 * 		그외의 파일들에 대해서는 "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성
		 */
		 FileInputStream fin = new FileInputStream(downloadFile);
		 ServletOutputStream sout = response.getOutputStream();
		 
		 byte[] buf = new byte[1024];
		 int size = -1;
		 
		 while((size = fin.read(buf,0,buf.length)) != -1) {
			 sout.write(buf, 0, size);
		 }
		 fin.close();
		 sout.close();
	}
}
