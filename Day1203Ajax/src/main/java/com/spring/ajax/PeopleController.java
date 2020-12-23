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
	@ResponseBody // jsp와 같은 뷰를 전달하는게 아닌 데이터를 전달하기 위해 사용
	public List<PeopleVO> getPeopleJSONGET() {
		List<PeopleVO> list = peopleService.getPeopleList();
		
		return list;
	}
	
	@RequestMapping(value = "/selectPeople.do", produces="application/json; charset=UTF-8")
	@ResponseBody // jsp와 같은 뷰를 전달하는게 아닌 데이터를 전달하기 위해 사용
	public PeopleVO selectPeople(@RequestParam(value="id") String id) {
		System.out.println("id : " + id);
		PeopleVO vo = new PeopleVO();
		try {
			vo = peopleService.selectPeople(id);
			System.out.println("넘어온 파라미터 :"+ vo.getId());
		}catch(Exception e) {
			System.out.println("select 에러 : " + e.getMessage());
		}
		
		return vo;
	}
	
	@RequestMapping(value = "/insertPeople.do", method=RequestMethod.POST, produces="application/json; charset=UTF-8")
	@ResponseBody // jsp와 같은 뷰를 전달하는게 아닌 데이터를 전달하기 위해 사용
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
	@ResponseBody // jsp와 같은 뷰를 전달하는게 아닌 데이터를 전달하기 위해 사용 >> response가 붙은 순간 리턴은 무조건 데이터타입 >> 현재 페이지에 결과값을 다시 뿌려줌(페이지 변경x)
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
	@ResponseBody // jsp와 같은 뷰를 전달하는게 아닌 데이터를 전달하기 위해 사용 >> response가 붙은 순간 리턴은 무조건 데이터타입 >> 현재 페이지에 결과값을 다시 뿌려줌(페이지 변경x)
	public Map<String, Object> updatePeople(PeopleVO vo) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		String id = vo.getId();
		try {
			peopleService.updatePeople(vo);
			retVal.put("res", "OK");
		}catch(Exception e) {
			System.out.println("update 에러 : " + e.getMessage());
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
}
