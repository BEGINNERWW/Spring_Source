package com.spring.ajax;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PeopleController {
	
	@Autowired
	private PeopleService peopleService;
	
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	@RequestMapping(value = "/getPeopleJSON.do", produces="application/json; charset=UTF-8")
	@ResponseBody // jsp�� ���� �並 �����ϴ°� �ƴ� �����͸� �����ϱ� ���� ���
	public List<PeopleVO> getPeopleJSONGET() {
		List<PeopleVO> list = peopleService.getPeopleList();
		
		return list;
	}
	
	@RequestMapping(value = "/selectPeople.do", produces="application/json; charset=UTF-8")
	@ResponseBody // jsp�� ���� �並 �����ϴ°� �ƴ� �����͸� �����ϱ� ���� ���
	public PeopleVO selectPeople(@RequestParam(value="id") String id) {
		System.out.println("id : " + id);
		PeopleVO vo = new PeopleVO();
		try {
			vo = peopleService.selectPeople(id);
			System.out.println("�Ѿ�� �Ķ���� :"+ vo.getId());
		}catch(Exception e) {
			System.out.println("select ���� : " + e.getMessage());
		}
		
		return vo;
	}
	
	@RequestMapping(value = "/insertPeople.do", method=RequestMethod.POST, produces="application/json; charset=UTF-8")
	@ResponseBody // jsp�� ���� �並 �����ϴ°� �ƴ� �����͸� �����ϱ� ���� ���
	public Map<String, Object> insertPeople(PeopleVO vo) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		try {
			peopleService.insertPeople(vo);
			retVal.put("res", "OK");
		}catch(Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	@RequestMapping(value = "/deletePeople.do",  produces="application/json; charset=UTF-8")
	@ResponseBody // jsp�� ���� �並 �����ϴ°� �ƴ� �����͸� �����ϱ� ���� ��� >> response�� ���� ���� ������ ������ ������Ÿ�� >> ���� �������� ������� �ٽ� �ѷ���(������ ����x)
	public Map<String, Object> deletePeople(PeopleVO vo) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		try {
			String id = vo.getId();
			System.out.println("id=" + id);
			peopleService.deletePeople(id);
			retVal.put("res", "OK");
			System.out.println("BBBBB");
		}catch(Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	@RequestMapping(value = "/updatePeople.do", produces="application/json; charset=UTF-8")
	@ResponseBody // jsp�� ���� �並 �����ϴ°� �ƴ� �����͸� �����ϱ� ���� ��� >> response�� ���� ���� ������ ������ ������Ÿ�� >> ���� �������� ������� �ٽ� �ѷ���(������ ����x)
	public Map<String, Object> updatePeople(PeopleVO vo) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		String id = vo.getId();
		try {
			peopleService.updatePeople(vo);
			retVal.put("res", "OK");
		}catch(Exception e) {
			System.out.println("update ���� : " + e.getMessage());
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
}
