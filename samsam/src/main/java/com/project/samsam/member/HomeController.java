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
	JavaMailSender mailSender; // ���� ���񽺸� ����ϱ� ���� ������ ����

	@RequestMapping(value = "/pw_find.me", method = RequestMethod.GET)
	public String pw_find() {

		return "pw_find";
	}

	@RequestMapping(value = "/pw_auth.me", method = RequestMethod.POST)
	public ModelAndView pw_auth(HttpServletRequest request, HttpServletResponse response) throws IOException {

		System.out.println("request email : " + request.getParameter("email"));

		MemberVO vo = memberSV.selectMember((String)request.getParameter("email"));
		System.out.println("ȸ�� �̸��� :" + vo.getEmail());
		System.out.println("�̸� : " + vo.getName());

		Random r = new Random();
		int num = r.nextInt(999999); // �̸��Ϸ� �޴� �����ڵ� �κ�(����)

		if (vo.getName().equals((String) request.getParameter("name"))) {

			// String setfrom ="������ �ּ�"; //gmail ���� gmail �ּ�, ������ ���� �̸����ּ�
			String setfrom = "ivedot@naver.com"; // naver ����(������ ��� �̸��� �ּ�)
			String tomail = request.getParameter("email"); // �޴»�� �̸���
			String title = "��й�ȣ���� ���� �̸��� �Դϴ�"; // ����
			String content = System.getProperty("line.separator") + "�ȳ��ϼ��� ȸ����" + System.getProperty("line.separator")
					+ "����ϰ� ��й�ȣã��(����) ������ȣ�� " + num + "�Դϴ�" + System.getProperty("line.separator")
					+ "������ ������ȣ�� �Է����ּ���"; // ����
			System.out.println("������� : " + setfrom + "�޴»��: " + tomail + "���� : "+ title);
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");

				messageHelper.setFrom(setfrom); // ������ ��� ������ �۵� ����
				messageHelper.setTo(tomail); // �޴»�� �̸���
				messageHelper.setSubject(title); // ���� ������ ���� ����
				messageHelper.setText(content); // ����

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
		 * writer.println("<script>alert('�̸����� �߼۵Ǿ����ϴ�. ������ȣ�� �Է����ּ���'); </script>");
		 * writer.flush();
		 * 
		 */
		return mv;
	} //��й�ȣ �̸�������
	
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
			System.out.println("����������"+ result);
			return "pw_new";
		}
	}
	
	@RequestMapping(value = "/loginForm.me", method = RequestMethod.GET)
	public String login_Form() {

		return "loginForm";
	}
	
	@RequestMapping(value = "/login.me")
	public String userCheck(MemberVO vo, HttpSession session) throws Exception {
		System.out.println("�α��� �̸��� "+vo.getEmail());
		System.out.println("�α��� ��й�ȣ "+vo.getPw());
		
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
		System.out.println("�α��� �̸��� "+vo.getEmail());
		System.out.println("�α��� ��й�ȣ "+vo.getPw());
		
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
