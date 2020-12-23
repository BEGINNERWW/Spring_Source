package com.project.samsam.member;

import java.io.IOException;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
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
	
	@RequestMapping(value = "/pw_new.me", method = RequestMethod.POST)
	public String pw_new(@RequestParam(value="email_injeung") String email_injeung,
			@RequestParam(value = "num") String num) throws IOException{
		
		if(email_injeung.equals(num)) {
			return "pw_new";
		}
		else {
			return "pw_find";
		}
	}
	
}
