package com.project.samsam.member;

import java.io.File;
import java.io.IOException;
import java.util.Random;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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

	@RequestMapping(value = "/pw_auth.me")
	public ModelAndView pw_auth(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String email = (String)request.getParameter("email");
		String name = (String)request.getParameter("name");
		System.out.println("request email : " + email);
		System.out.println("request name : " + name);

		MemberVO vo = memberSV.selectMember(email);
		System.out.println("ȸ�� �̸��� :" + vo.getEmail());
		System.out.println("�̸� : " + vo.getName());

		Random r = new Random();
		int num = r.nextInt(999999); // �̸��Ϸ� �޴� �����ڵ� �κ�(����)

		if (vo.getName().equals(name)) {
			session.setAttribute("email", vo.getEmail());

			System.out.println("���Ϲ߼� to :" + (String)session.getAttribute("id") );
			// String setfrom ="������ �ּ�"; //gmail ���� gmail �ּ�, ������ ���� �̸����ּ�
			String setfrom = "ivedot@naver.com"; // naver ����(������ ��� �̸��� �ּ�)
			String tomail = email; // �޴»�� �̸���
			String title = "��й�ȣ���� ���� �̸��� �Դϴ�"; // ����
			String content = System.getProperty("line.separator") + "�ȳ��ϼ��� ȸ����" + System.getProperty("line.separator")
					+ "����ϰ� ��й�ȣã��(����) ������ȣ�� " + num + "�Դϴ�" + System.getProperty("line.separator")
					+ "������ ������ȣ�� �Է����ּ���"; // ����
		//	System.out.println("������� : " + setfrom + "�޴»��: " + tomail + "���� : "+ title);

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

			ModelAndView mv = new ModelAndView();
			mv.setViewName("pw_auth");
			mv.addObject("num", num);
			return mv;
		}else {
			ModelAndView mv = new ModelAndView();
			mv.setViewName("pw_find");
			return mv;
		}

		/*
		 * response.setContentType("text/html; charset=utf-8"); PrintWriter writer =
		 * response.getWriter();
		 * writer.println("<script>alert('�̸����� �߼۵Ǿ����ϴ�. ������ȣ�� �Է����ּ���'); </script>");
		 * writer.flush();
		 * 
		 */

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
	
	@RequestMapping(value = "/loginForm.me")
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
	@RequestMapping(value = "/myinfo_check.me")
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
			System.out.println("res.getPhone :" + res.getPhone());

			model.addAttribute("MemberVO", res);
			return "myinfo_member";
		}else {
			return "loginForm";
		}
	}	
	
	@RequestMapping(value = "/myinfo_update.do" , produces="application/json; charset=UTF-8")
	@ResponseBody
		public Map<String, String> myinfo_update(MemberVO vo) {
		Map<String, String> result = new HashMap<String, String>();
	
		try {
			memberSV.updateMember(vo);
			result.put("res", "OK");
		}catch(Exception e) {
			System.out.println("update ���� : " + e.getMessage());
			result.put("res", "FAIL");
			result.put("message", "Failure");
		}
		
		return result;
	}
	@RequestMapping(value = "/myinfo_auth.me")
		public String myinfo_auth(HttpSession session) {
			String biz_email = (String)session.getAttribute("email");
			if(memberSV.selectBizMember(biz_email) == null) {
				System.out.println("bizcheck selectBizmemeber : " + null);
				return "myinfo_auth";
			}else {
				return "myinfo_already";
			}
	}
	@RequestMapping(value = "/biz_check.do", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, String> biz_check(Biz_memberVO bo) {
		Map<String, String> result = new HashMap<String, String>();
		System.out.println("biz no : "+ bo.getBiz_no());
		try {
				String biz_com = memberSV.check_auth(bo);
				System.out.println("biz_com : "+ biz_com);
				if(biz_com.equals(bo.getBiz_com())) {
					result.put("res", "OK");
				}
				else {
					result.put("res", "dont");
				}
		}catch(Exception e) {
			System.out.println("biz_check ���� : " + e.getMessage());
			result.put("res", "FAIL");
			result.put("message", "Failure");
		}
			
	return result;
}
	@RequestMapping("/pre_auth.me") 
	public String pre_auth(Biz_memberVO bo, HttpSession session) throws Exception {
		MultipartFile mf = bo.getFile();
		bo.setBiz_email((String)session.getAttribute("email"));
		MemberVO vo = memberSV.selectMember(bo.getBiz_email());
		System.out.println("biz �̸����ּ�: " + bo.getBiz_email() + "�㰡��ȣ :" + bo.getBiz_no());
		String uploadPath = "C:\\Project\\upload\\";
		
		//�������ּҿ� ���� ����        
        if(mf.getSize() != 0) {//÷�ε� ���� ������
        	// ���� Ȯ���ڸ� �����ϴ� ����
    		String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
    		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
            //mf.transferTo(new File(uploadPath+"/"+mf.getOriginalFilename()));     
        	mf.transferTo(new File(uploadPath+mf.getOriginalFilename())); // ����ó�� ��� �ʿ���. transferTo ������ ���ε�(������ ����)
        	bo.setBiz_img(mf.getOriginalFilename());
        	bo.setBiz_add(vo.getLocal());
        	bo.setBiz_name(vo.getName());
        	bo.setStatus(1);
        	int result = memberSV.pre_insertBiz(bo);
        	if(result == 1) {
        		return "myinfo_check";
        	}else {
        		return "myinfo_auth";
        	}
        	
		}else { //÷�ε� ������ ������
			System.out.println("pre_auth : ÷�����Ͼ���");  
			
        	return "myinfo_auth";
		}
	} 
}
