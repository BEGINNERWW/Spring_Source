package com.spring.day1124a1;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/career.me", method = RequestMethod.GET)
	public String career() {
		return "career";
	}
	@RequestMapping(value = "/form_input.me", method = RequestMethod.GET)
	public String form_input() {
		return "form_input";
	}
	@RequestMapping(value = "/input_form.me", method = RequestMethod.POST)
	public String input_form(Member member, Model model) {
		
		model.addAttribute("member", member);
		return "input_form";
	}
	@RequestMapping(value = "/register.me", method = RequestMethod.GET)
	public String register() {
		return "register";
	}
}
