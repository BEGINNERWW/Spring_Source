package com.spring.springimport;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {
	

	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home() {
		
		return "home";
	}
	@RequestMapping(value = "/cancel.do", method = RequestMethod.POST)
	@ResponseBody
	public String cancel(@RequestParam(value="merchant_uid") String merchant_uid) {
		System.out.println("merchant_uid = " +merchant_uid);
		PaymentCheck obj = new PaymentCheck();
		String token = obj.getImportToken();
		int res = obj.cancelPayment(token, merchant_uid);
		if(res == 1)
			return "Success";
		else
			return "Failure";
	}
}
