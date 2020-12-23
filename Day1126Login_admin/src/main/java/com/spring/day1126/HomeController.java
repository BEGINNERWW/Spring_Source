package com.spring.day1126;

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
	private MemberService memberService;
	
	@RequestMapping(value = "/login.me")
	public String userCheck(MemberVO memberVO, HttpSession session, HttpServletResponse response) throws Exception {
		int res = memberService.userCheck(memberVO);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		if(res==1) {
			session.setAttribute("id", memberVO.getId());
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
	@RequestMapping(value = "/joinprocess.me")
	public String joinProcess(MemberVO memberVO, HttpServletResponse response) throws Exception {
		int res = memberService.insertMember(memberVO);
		
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
	@RequestMapping(value = "/memberlist.me")
	public String getMemberlist(Model model) throws Exception {
		ArrayList<MemberVO> member_list = memberService.getMemberlist();
		model.addAttribute("member_list", member_list);
		
		return "member_list";
	}
	@RequestMapping(value = "/memberinfo.me")
	public String selectMember(MemberVO memberVO, Model model) throws Exception {
		MemberVO vo = memberService.selectMember(memberVO);
		model.addAttribute("memberVO", vo);
		
		return "member_info";
	}
	@RequestMapping(value = "/memberdelete.me")
	public String deleteMember(MemberVO memberVO, Model model) throws Exception {
		memberService.selectMember(memberVO);
		
		
		return "redirect:/memberlist.me";
	}
	@RequestMapping(value = "/memberupdateform.me")
	public String updateFormMember(MemberVO memberVO, Model model) throws Exception {
		MemberVO vo = memberService.selectMember(memberVO);
		model.addAttribute("memberVO", vo);
		
		return "member_updateForm";
	}
	@RequestMapping(value = "/memberupdate.me")
	public String updateMember(MemberVO memberVO, HttpServletResponse response) throws Exception {
		int result = memberService.updateMember(memberVO);
		
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
}
