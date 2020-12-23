package com.spring.day1127;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	private SungjukService service;
	
	@RequestMapping(value = "/login.me")
	public String userCheck(MemberVO memberVO, HttpSession session, HttpServletResponse response) throws Exception {
		int res = service.userCheck(memberVO);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		if(res==1) {
			session.setAttribute("hakbun", memberVO.getHakbun());
			writer.write("<script>alert('로그인 성공!!');" + "location.href='./main.me';</script>");
			//return "redirect:/main.me";
		}else {
			writer.write("<script>alert('로그인 실패!!');"+ "location.href='./loginform.me'; </script>");
			//return "redirect:/loginform.me";
		}
		return null;
	}
	@RequestMapping(value = "/main.me")
	public String mainPage() throws Exception {
		
		return "main";
	}
	@RequestMapping(value = "/loginform.me")
	public String loginForm() throws Exception {
		
		return "loginForm";
	}
	@RequestMapping(value = "/joinform.me")
	public String joinForm() throws Exception {
		
		return "joinForm";
	}
	@RequestMapping(value = "/sungjukform.me")
	public String sungjukForm() throws Exception {
		
		return "sungjukForm";
	}
	
	@RequestMapping(value = "/joinprocess.me")
	public String joinProcess(MemberVO memberVO, HttpServletResponse response) throws Exception {
		int res = service.insertMember(memberVO);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		if(res != 0) {
			writer.write("<script>alert('회원 가입 성공!!');" + "location.href='./loginform.me';</script>");
		}else {
			writer.write("<script>alert('회원 가입 실패!!');" + "location.href='./joinform.me';</script>");
		}
		return null;
	}
	@RequestMapping(value = "/sungjukprocess.me")
	public String sungjukProcess(SungjukProcessVO sVO, HttpServletResponse response) throws Exception {
		sVO.process();
		int res = service.insertSungjuk(sVO);

		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		if(res != 0) {
			writer.write("<script>alert('성적 입력 성공!!');" + "location.href='./sungjuklist.me';</script>");
		}else {
			writer.write("<script>alert('성적 입력 실패!!');" + "location.href='./sungjukform.me';</script>");
		}
		return null;
	}
	@RequestMapping(value = "/memberlist.me")
	public String getMemberlist(Model model) throws Exception {
		ArrayList<MemberVO> member_list = service.getMemberlist();
		model.addAttribute("member_list", member_list);
		
		return "member_list";
	}
	@RequestMapping(value = "/sungjuklist.me")
	public String getSungjuklist(Model model, HttpServletResponse response) throws Exception {
		ArrayList<SungjukProcessVO> sungjuk_list = service.getSungjuklist();
		model.addAttribute("sungjuk_list", sungjuk_list);

		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		if(sungjuk_list.isEmpty()) {
			writer.write("<script>alert('입력된 성적 정보가 없습니다!!');" + "location.href='./sungjukform.me';</script>");
		}
		
		return "sungjuk_list";
	}
	@RequestMapping(value = "/memberinfo.me")
	public String selectInfo(MemberVO memberVO, SungjukProcessVO sungjukVO, Model model, HttpServletResponse response) throws Exception {
		MemberVO mVO = service.selectMember(memberVO);
		SungjukProcessVO sVO = service.selectSungjuk(sungjukVO);
	
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		if(sVO==null) {
			writer.write("<script>alert('입력된 성적 정보가 없습니다!!');</script>");
		}
		model.addAttribute("memberInfo", mVO);
		model.addAttribute("sungjukInfo", sVO);
		
		return "member_info";
	}
	@RequestMapping(value = "/memberdelete.me")
	public String deleteMember(MemberVO memberVO, Model model) throws Exception {
		service.deleteMember(memberVO);
		
		return "redirect:/memberlist.me";
	}
	@RequestMapping(value = "/sungjukdelete.me")
	public String deleteSungjuk(SungjukProcessVO sVO, Model model) throws Exception {
		service.deleteSungjuk(sVO);
		
		return "redirect:/sungjuklist.me";
	}
	@RequestMapping(value = "/memberupdateform.me")
	public String updateFormMember(MemberVO memberVO, Model model) throws Exception {
		MemberVO vo = service.selectMember(memberVO);
		model.addAttribute("memberVO", vo);
		
		return "member_updateForm";
	}
	@RequestMapping(value = "/memberupdate.me")
	public String updateMember(MemberVO memberVO, HttpServletResponse response) throws Exception {
		int result = service.updateMember(memberVO);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		if(result!=0){
			writer.write("<script>"); 
			writer.write("alert('수정 성공!!!');" + "location.href='memberlist.me';</script>" );
		
		}else{
			writer.write("<script>");
			writer.write("alert('수정 실패!!!');" + "location.href='memberupdateform.me'; </script>" );
		}
		
		return null;
	}
	
	@RequestMapping(value = "/sungjukupdateform.me")
	public String updateFormSungjuk(SungjukProcessVO sVO, Model model) throws Exception {
		SungjukProcessVO vo = service.selectSungjuk(sVO);
		model.addAttribute("sungjukVO", vo);
		
		return "sungjuk_updateForm";
	}
	@RequestMapping(value = "/sungjukupdate.me")
	public String updateSungjuk(SungjukProcessVO sVO, HttpServletResponse response) throws Exception {
		sVO.process();
		int result = service.updateSungjuk(sVO);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		if(result!=0){
			writer.write("<script>"); 
			writer.write("alert('수정 성공!!!');" + "location.href='memberlist.me';</script>" );
		
		}else{
			writer.write("<script>");
			writer.write("alert('수정 실패!!!');" + "location.href='sungjukupdateform.me'; </script>" );
		}
		
		return null;
	}
}
