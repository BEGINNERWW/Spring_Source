package com.project.samsam.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.samsam.member.MemberVO;


@Controller
public class JJBoardController {

	@Autowired
	private JJBoardService boardService; // BoardService빈객체가 만들어져있어야 한다
	
	@RequestMapping("/home_search.me")
	public String getSearchlist(@RequestParam(value="keyword", required= true, defaultValue="")String keyword, Model model){
			//community
			List<JJBoardVO> c_list = boardService.getSearch_commu_List(keyword);
		try {
			if(c_list != null) {
				model.addAttribute("community",c_list); 
			}
			else{
				System.out.println("community");
			}
		}
		catch(Exception e) {
			System.out.println("search error(community) : " + e.getMessage());
		}
		//adopt
		List<JJBoardVO> a_list = boardService.getSearch_adopt_List(keyword);
		try {
			if(a_list != null) {
				model.addAttribute("adopt_list",a_list); 
			}
			else{
				System.out.println("adopt_list");
			}
		}
		catch(Exception e) {
			System.out.println("search error(adopt) : " + e.getMessage());
		}
		//free
		List<JJBoardVO> f_list = boardService.getSearch_free_List(keyword);
		try {
			if(f_list != null) {
				model.addAttribute("free_doc",f_list); 
			}
			else{
				System.out.println("free_doc");
			}
		}
		catch(Exception e) {
			System.out.println("search error(free) : " + e.getMessage());
		}
		
           return "jj/ho_search_list";
        
	}
	
	@RequestMapping("/s_board_detail.bo")
	public String getSDetail(@RequestParam(value ="b_no", required = true) int b_no, Model model) {
		try {
		JJBoardVO bvo = boardService.getSDetail(b_no);

		model.addAttribute("bvo", bvo);
		System.out.println("글보기"+bvo);
		}catch(Exception e) {
			e.getMessage();
		}
		return "jj/ho_search_view";
	}
	//홈페이지 원본 글이동   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>a href 이동을 위한 메소드 수정필요
	
////////////////////////////	
	//관리자 페이지 컨트롤러
	
	@RequestMapping("/adminboard.do")
	public String adminboard() throws Exception {
		return "jj/admin_board";
	}
	

	
	@RequestMapping(value="/boardFind.do",
						produces= "application/json;charset=utf-8")
	@ResponseBody
	public List<JJABoardVOto> getAFindList(@RequestBody JJABoardVO abvo) throws Exception {
		System.out.println("startDate : " + abvo.getStartDate());
		System.out.println("startDate : " + abvo.getEndDate());
		System.out.println("startDate : " + abvo.getKeyword());
		System.out.println("startDate : " + abvo.getCategory());
		List<JJABoardVOto> list = boardService.findList(abvo);
		System.out.println(3);

		return list;
		}
	//어드민 게시글관리 일반리스트 함수
	
	@RequestMapping(value="/boardWFind.do",
			produces= "application/json;charset=utf-8")
	@ResponseBody
	public List<JJABoardVOto> getFindWList(@RequestBody JJABoardVO abvo) throws Exception {
		System.out.println("startDate : " + abvo.getStartDate());
		System.out.println("startDate : " + abvo.getEndDate());
		System.out.println("startDate : " + abvo.getKeyword());
		System.out.println("startDate : " + abvo.getCategory());
		System.out.println("kind : " + abvo.getKind());
		List<JJABoardVOto> list = boardService.find_w_List(abvo);
		System.out.println(3);

		System.out.println(2);
		return list;
		}
	//어드민 게시글관리 신고리스트 함수 끝 
	////////////////////
	
	//admin board view detail
	@RequestMapping(value="/ad_boardDetail.do")
	public ModelAndView ad_boardDetail (HttpServletRequest request) throws Exception{
		System.out.println("controller: board_detail.do");
		
		String num =request.getParameter("number");
		String category = request.getParameter("category");
		ModelAndView mav = new ModelAndView();
		JJADModalVO movo = new JJADModalVO();
		movo.setCategory(category);
		movo.setNumber(num); 
		System.out.println("카테고리 : "+ category + " / num : " + num);
		
		MemberVO vo = boardService.ad_member(movo);
		if(vo != null) {	
			System.out.println("vo.grade : " +vo.getGrade());
			mav.addObject("vo", vo);
		}
		else {
			System.out.println("modal MemberVO null");
		}
		JJABoardVOto bvo = boardService.ad_board(movo);
		if(bvo != null) {
			String category1 = movo.getCategory();
			if(category1.equals("community")) {
				bvo.setCategory("커뮤니티");
				System.out.println("글내용"+bvo.getDoc_content());
				mav.addObject("bvo",bvo);
			}
			else{
				bvo.setCategory("분양게시판");
				mav.addObject("bvo",bvo);
			}
		}
		else {
			System.out.println("modal ABoardVOto null");
		}
		
		List<JJCommentVO> cList = boardService.ad_cList(movo);
		if(cList != null) {
			mav.addObject("cList",cList);
		}
		else {
			System.out.println("modal cList null");
		}
		JJCommentVO covo = boardService.ad_cccount(movo);
		if(covo != null) {
			mav.addObject("covo", covo);
		}
		else {
			System.out.println("modal ccount null");
		}
		
		List<JJWarningVO> w_coList = boardService.w_coList(movo); //신고 댓글
		if(w_coList != null) {
			mav.addObject("w_coList", w_coList);
		}
		else {
			System.out.println("modal wList null");
		}
		List<JJWarningVO> w_docList = boardService.w_docList(movo); //신고 글
		if(w_docList != null) {
			mav.addObject("w_docList", w_docList);
		}
		else {
			System.out.println("modal wcoList null");
		}
		
		JJWarningVO w_count = boardService.ad_wcount(movo);  //신고 카운드
		if(w_count != null) {
			mav.addObject("wcount",w_count);
		}
		else {
			System.out.println("modal wcount null");
		}
		
		mav.setViewName("admin_detail");
		return mav;
	}
	//admin board view detail END
	@RequestMapping(value="/ad_w_detail.do", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> w_modal (HttpServletRequest request, @RequestBody JJADModalVO param)throws Exception {
		System.out.println("....미친...."+param.getNumber());
		
		JJADModalVO movo = new JJADModalVO();
		movo.setNumber(param.getNumber());
		
		System.out.println("w_no"+movo.getNumber());
		Map<String, Object> map = new HashMap<String, Object> ();
		
		JJWarningVO wvo = boardService.wvo(movo);
		if(wvo != null) {
			map.put("wvo", wvo);
		}
		
		JJCommentVO covo = boardService.covo(movo);
		if(covo != null) {
		System.out.println("갯글 내용"+covo.getCo_content());
			map.put("covo", covo);
		}
		
		return map;
		
	}
	//admin board view MODAL END
	
	@RequestMapping(value="/w_authOrder.do", produces="application/json; charset=UTF-8")
	@ResponseBody
	public int update_status (HttpServletRequest request,@RequestBody JJWarningVO param) throws Exception{
		System.out.println("param : " + param.getW_no());
		int result= boardService.update_status(param);
		System.out.println("결과 " + result);
		return result;
	}
	//admin board view MODAL warning handler END
}
