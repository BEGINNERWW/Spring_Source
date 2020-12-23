package com.project.samsam.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public class HomeController {
	

	@RequestMapping(value = "/pw_find.me", method = RequestMethod.GET)
	public String pw_find() {
		
		return "pw_find";
	}
	@RequestMapping(value = "/pw_auth.me", method = RequestMethod.GET)
	public String pw_auth(MemberVO vo) {
		
		
		return "pw_auth";
	}
}
