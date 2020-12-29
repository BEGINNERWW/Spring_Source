package com.project.samsam.member;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

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
			
			//�����ȸ������ Ȯ��
			Biz_memberVO bo = memberSV.selectBizMember(vo.getEmail());
			if(bo != null) {
				if(bo.getStatus() == 0) {
					return "redirect:/cominfo_main.me";
				}
			}
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
		int res = 0;
		try {
				String biz_com1 = memberSV.check_auth(bo);
				String biz_com = bo.getBiz_com();
				//�Է��� ������� ���õ����ͻ� �㰡��ȣ�� ��ȸ������ Ȯ�εǴ� ������ ��ġ�ϴ��� Ȯ��
				//�Էµ� �㰡��ȣ�� ������ db�� �ִ��� Ȯ��
				if(biz_com1.equals(biz_com)) {
					System.out.println("biz_com : "+ biz_com1 + "�Էµ� ������ :"+bo.getBiz_com());
					res = memberSV.selectBiz_no(bo.getBiz_no());
					if(res == 0) {
					result.put("res", "OK");
					}else {
					result.put("res", "dont");
					}
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
		try {
		MultipartFile mf = bo.getFile();
		
		Biz_memberVO biz = new Biz_memberVO();
		biz.setBiz_com(bo.getBiz_com());
		biz.setBiz_no(bo.getBiz_no());
		biz.setBiz_email((String)session.getAttribute("email"));

		MemberVO vo = memberSV.selectMember(biz.getBiz_email());
		
		String uploadPath = "C:\\Project\\upload\\";
		//�������ּҿ� ���� ����        
		if(mf.getSize() != 0) {//÷�ε� ���� ������
        	// ���� Ȯ���ڸ� �����ϴ� ����
    		String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
    		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
            //mf.transferTo(new File(uploadPath+"/"+mf.getOriginalFilename()));     
        	mf.transferTo(new File(uploadPath+mf.getOriginalFilename())); // ����ó�� ��� �ʿ���. transferTo ������ ���ε�(������ ����)
        	biz.setBiz_img(mf.getOriginalFilename());
        	biz.setBiz_add(vo.getLocal());
        	biz.setBiz_name(vo.getName());
        	biz.setStatus(1);

        	int result = memberSV.pre_insertBiz(biz);
    		System.out.println("form ������ Ȯ�� : ���� " + biz.getBiz_img() + "����ڸ� : " + biz.getBiz_com()+"�㰡��ȣ : "+ biz.getBiz_no()+ "�̸��� : "+ biz.getBiz_email());

        	if(result == 1) {
        		return "myinfo_already";
        	}else {
        		return "myinfo_auth";
        	}
		}else { //÷�ε� ������ ������
			System.out.println("pre_auth : ÷�����Ͼ���");  
			
        	return "myinfo_auth";
		}
		
		}catch(Exception e) {
			System.out.println("pre_auth ����: ���Ͼ���" + e.getMessage());
			return "myinfo_auth";
		}
	} 
	@RequestMapping(value = "/cominfo_main.me")
	public String cominfo_main(HttpSession session, Model model) {
		String email = (String)session.getAttribute("email");
		
		MemberVO mvo = memberSV.selectMember(email);
		Biz_memberVO vo = memberSV.selectBizMember(email);
		ArrayList<Adopt_BoardVO> bvo = memberSV.getMyAdopt(mvo.getNick());
		
		ArrayList<Adopt_BoardVO> new_bvo = new ArrayList<Adopt_BoardVO>();
		Map<Integer, Integer> map = new HashMap<Integer, Integer>();
		
		for(Adopt_BoardVO bo : bvo) {
			StringBuffer str = new StringBuffer(bo.getAdopt_phone());
			str.insert(0, "0");
					
			String phone = str.substring(0);
			if(phone.substring(0,2).equals("00")) {
				phone = phone.substring(1);
			}
			bo.setAdopt_phone(phone);
			new_bvo.add(bo);
			
			int res = memberSV.getMyAdoptReply(bo.getAdopt_no());
			map.put(bo.getAdopt_no(), res);
			}
		
		model.addAttribute("Biz_memberVO", vo);
		model.addAttribute("MemberVO", mvo);
		model.addAttribute("Adopt_list", new_bvo);
		model.addAttribute("map_count", map);

		return "cominfo_pay";
	}
	
	@RequestMapping(value = "/cominfo_member.me")
	public String cominfo_member() {

		return "cominfo_member";
	}
}
