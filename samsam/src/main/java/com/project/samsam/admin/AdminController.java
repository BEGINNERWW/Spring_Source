package com.project.samsam.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.samsam.member.MemberSV;
import com.project.samsam.simport.PaySV;
import com.project.samsam.simport.Payed_listVO;
import com.project.samsam.simport.PaymentCheck;

@Controller
public class AdminController {
	
	@Autowired
	private PaySV paySV;
	@Autowired
	private MemberSV memberSV;
	

	@RequestMapping(value = "/admin_main.me")
	public String pay() {
	
		
		return "admin_member";
	}
	
}