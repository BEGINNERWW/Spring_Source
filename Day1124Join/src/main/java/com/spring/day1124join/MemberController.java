package com.spring.day1124join;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class MemberController {
	
	/*@RequestMapping(value="input.bo", method= RequestMethod.POST)
	public String res(HttpServletRequest request, Model model) {
		
		String id= request.getParameter("id");
		String pw = request.getParameter("pw");
		model.addAttribute("id", id);
		model.addAttribute("pw", pw);
		
		return "res";
	}*/
	/*@RequestMapping(value="input.bo", method= RequestMethod.POST)
	public String res(LoginVO vo, Model model) {
		
		String id= vo.getId();
		String pw = vo.getPw();
		model.addAttribute("id", id);
		model.addAttribute("pw", pw);
		
		return "res";
	}*/
	@RequestMapping(value = "/join_form.bo", method = RequestMethod.GET)
	public String form_input() {
		return "join_form";
	}
	@RequestMapping(value="/input_form.bo", method= RequestMethod.POST)
	public String input_form(Member member, Model model) {
		
		
		String id= member.getId();
		String pw = member.getPw();
		String jumin1 = member.getJumin1();
		String jumin2 = member.getJumin2();
		String gender = member.getGender();
		String tel1 = member.getTel1();
		String tel2 = member.getTel2();
		String tel3 = member.getTel3();
		String email1 = member.getEmail1();
		String email2 = member.getEmail2();
		String hobby[] = member.getHobby();
		String intro = member.getIntro();
		
		String hobby_str="";
		int i;
		for(i=0; i<hobby.length-1; i++)
			hobby_str += hobby[i] + ", ";
		hobby_str += hobby[i];
		
		model.addAttribute("id", id);
		model.addAttribute("pw", pw);
		model.addAttribute("jumin1", jumin1);
		model.addAttribute("jumin2", jumin2);
		model.addAttribute("gender", gender);
		model.addAttribute("tel1", tel1);
		model.addAttribute("tel2", tel2);
		model.addAttribute("tel3", tel3);
		model.addAttribute("email1", email1);
		model.addAttribute("email2", email2);
		model.addAttribute("hobby", hobby_str);
		model.addAttribute("intro", intro);
		
		return "input_form";
	}
}
