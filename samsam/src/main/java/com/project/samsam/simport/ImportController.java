package com.project.samsam.simport;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ImportController {
	

	@RequestMapping(value = "/insertPayCoupon.do", method = RequestMethod.POST)
	@ResponseBody
	public String pay(@RequestParam(value="merchant_uid") String merchant_uid) {
		
		return "home";
	}
	@RequestMapping(value = "/coupon_cancel.do", method = RequestMethod.POST)
	@ResponseBody
	public String cancel(@RequestBody String merchant_uid) {
		System.out.println("merchant_uid = " +merchant_uid);
		PaymentCheck obj = new PaymentCheck();
		String token = obj.getImportToken();
		System.out.println("merchant_uid :" + merchant_uid);
		int res = obj.cancelPayment(token, merchant_uid);
		if(res == 1)
			return "Success";
		else
			return "Failure";
	}
}
