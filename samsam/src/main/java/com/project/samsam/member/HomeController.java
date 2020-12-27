package com.project.samsam.member;

import java.io.IOException;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

	@Autowired
	private MemberSV memberSV;
	@Autowired
	JavaMailSender mailSender; // 메일 서비스를 사용하기 위해 의존성 주입

	@RequestMapping(value = "/pw_find.me", method = RequestMethod.GET)
	public String pw_find() {

		return "pw_find";
	}

	@RequestMapping(value = "/pw_auth.me", method = RequestMethod.POST)
	public ModelAndView pw_auth(HttpServletRequest request, HttpServletResponse response) throws IOException {

		System.out.println("request email : " + request.getParameter("email"));

		MemberVO vo = memberSV.selectMember((String)request.getParameter("email"));
		System.out.println("회원 이메일 :" + vo.getEmail());
		System.out.println("이름 : " + vo.getName());

		Random r = new Random();
		int num = r.nextInt(999999); // 이메일로 받는 인증코드 부분(난수)

		if (vo.getName().equals((String) request.getParameter("name"))) {

			// String setfrom ="지메일 주소"; //gmail 사용시 gmail 주소, 다음시 다음 이메일주소
			String setfrom = "ivedot@naver.com"; // naver 사용시(보내는 사람 이메일 주소)
			String tomail = request.getParameter("email"); // 받는사람 이메일
			String title = "비밀번호변경 인증 이메일 입니다"; // 제목
			String content = System.getProperty("line.separator") + "안녕하세요 회원님" + System.getProperty("line.separator")
					+ "삼삼하개 비밀번호찾기(변경) 인증번호는 " + num + "입니다" + System.getProperty("line.separator")
					+ "받으신 인증번호를 입력해주세요"; // 내용
			System.out.println("보낸사람 : " + setfrom + "받는사람: " + tomail + "제목 : "+ title);
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");

				messageHelper.setFrom(setfrom); // 보내는 사람 생략시 작동 안함
				messageHelper.setTo(tomail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일 제목은 생략 가능
				messageHelper.setText(content); // 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pw_auth");
		mv.addObject("num", num);

		/*
		 * response.setContentType("text/html; charset=utf-8"); PrintWriter writer =
		 * response.getWriter();
		 * writer.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요'); </script>");
		 * writer.flush();
		 * 
		 */
		return mv;
	} //비밀번호 이메일인증
	
	@RequestMapping(value = "/pw_set.me", method = RequestMethod.POST)
	public String pw_set(@RequestParam(value="email_injeung") String email_injeung,
			@RequestParam(value = "num") String num) throws IOException{
		
		if(email_injeung.equals(num)) {
			return "pw_new";
		}
		else {
			return "pw_find";
		}
	}
	
	@RequestMapping(value = "/pw_new.me", method = RequestMethod.POST)
	public String pw_new(MemberVO vo, HttpSession session) throws IOException{
		System.out.println("session email : " + session.getAttribute("email"));
		System.out.println("pw : " + vo.getPw());
		int result = memberSV.pwUpdate_M(vo);
		if(result == 1) {
			return "loginForm";
		}
		else {
			System.out.println("비번변경실패"+ result);
			return "pw_new";
		}
	}
	
	@RequestMapping(value = "/loginForm.me", method = RequestMethod.GET)
	public String login_Form() {

		return "loginForm";
	}
	
	@RequestMapping(value = "/login.me")
	public String userCheck(MemberVO vo, HttpSession session) throws Exception {
		System.out.println("로그인 이메일 "+vo.getEmail());
		System.out.println("로그인 비밀번호 "+vo.getPw());
		
		MemberVO res = memberSV.selectMember(vo.getEmail());
		
		if(res.getPw().equals(vo.getPw())) {
			session.setAttribute("id", res.getEmail());
			session.setAttribute("email", res.getEmail());
			System.out.println("session id :" +session.getAttribute("id"));
			System.out.println("session email :" +session.getAttribute("email"));

			return "redirect:/myinfo_check.me";
		}else {
			return "redirect:/loginForm.me";
		}
	}
	@RequestMapping(value = "/myinfo_check.me", method = RequestMethod.GET)
	public String myinfo_check() {

		return "myinfo_check";
	}

	@RequestMapping(value = "/myinfo_member.me")
	public String myinfo_member(MemberVO vo, HttpSession session, Model model) throws Exception {
		System.out.println("로그인 이메일 "+vo.getEmail());
		System.out.println("로그인 비밀번호 "+vo.getPw());
		
		MemberVO res = memberSV.selectMember(vo.getEmail());
		
		if(res.getPw().equals(vo.getPw())) {
			System.out.println("session id :" +session.getAttribute("id"));
			System.out.println("session email :" +session.getAttribute("email"));

			model.addAttribute("MemberVO", res);
			return "myinfo_member";
		}else {
			return "loginForm";
		}
	}	

	@RequestMapping(value = "/myinfo_update.me", method = RequestMethod.GET)
	public String myinfo_update() {

		return "myinfo_member";
	}
	
}
