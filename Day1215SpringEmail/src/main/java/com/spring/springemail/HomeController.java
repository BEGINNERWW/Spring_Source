package com.spring.springemail;

import java.io.IOException;
import java.io.PrintWriter;
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
	JavaMailSender mailSender; //메일 서비스를 사용하기 위해 의존성 주입
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
			
		return "home";
	}
	
	@RequestMapping(value = "/auth.do", method = RequestMethod.POST)
	public ModelAndView mailSending(HttpServletRequest request, HttpServletResponse response ) throws IOException {
		
		Random r = new Random();
		int num = r.nextInt(999999); //이메일로 받는 인증코드 부분(난수)
		
		//String setfrom ="지메일 주소"; //gmail 사용시 gmail 주소, 다음시 다음 이메일주소
		String setfrom = "ivedot@naver.com"; //naver 사용시(보내는 사람 이메일 주소)
		String tomail = request.getParameter("email"); //받는사람 이메일
		String title ="회원가입 인증 이메일 입니다"; //제목
		String content = System.getProperty("line.separator") + "안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"
				+ System.getProperty("line.separator") + "인증번호는 " + num + "입니다"
				+ System.getProperty("line.separator") + "받으신 인증번호를 홈페이지에 입력해주시면 다음으로 넘어갑니다 "; // 내용
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"utf-8");
			
			messageHelper.setFrom(setfrom); //보내는 사람 생략시 작동 안함
			messageHelper.setTo(tomail); //받는사람 이메일
			messageHelper.setSubject(title); // 메일 제목은 생략 가능
			messageHelper.setText(content); // 내용
			
			mailSender.send(message);
		}catch(Exception e) {
			System.out.println(e);
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("email_injeung");
		mv.addObject("num", num);
		
		/*response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요'); </script>");
		writer.flush();
		
		*/
		return mv;
	}
	
	//이메일로 받은 인증번호를 입력하고 전송버튼을 누르면 맵핑되는 메소드
	//내가 입력한 인증번호와메일로 입력한 인증번호가 맞는지 확인해서 맞으면 회원가입 페이지로 넘어가고
	//틀리면 다시 원래 페이지로 돌아오는 메소드
	@RequestMapping(value = "/join_injeung.do", method = RequestMethod.POST)
	public ModelAndView join_injeung(@RequestParam(value="email_injeung") String email_injeung,
			@RequestParam(value = "num") String num, HttpServletResponse response) throws IOException {
		
		ModelAndView mv = new ModelAndView();
		
		if(email_injeung.equals(num)) {
			//인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 회원가입창으로 이동함
			mv.setViewName("join");
			
			//만약 인증번호가 같다면 이메일을 회원가입 페이지로 같이 넘겨서 이메일을 한번 더 입력할 필요가 없게 한다.
			response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.println("<script>alert('인증번호가 일치합니다. 회원가입창으로 이동합니다.');</script>");
			writer.flush();
			
			return mv;
		}else {
			ModelAndView mv2 = new ModelAndView();
			mv2.setViewName("email_injeung");
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter writer = response.getWriter();
			writer.println("<script>alert('인증번호가 일치하지 않습니다. 인증번호를 다시 입력해주세요'); history.go(-1);</script>");
			writer.flush();

			return mv2;
		}
	}
}
