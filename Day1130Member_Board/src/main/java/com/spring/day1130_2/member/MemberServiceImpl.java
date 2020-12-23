package com.spring.day1130_2.member;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired(required=false)  // DI(의존성 주입)을 위해 필드에 설정, false시 의존성 주입실패하더라도 에러 미발생
	private MemberDAO memberDAO=null;
	
	@Override
	public int insertMember(MemberVO memberVO) {
		int res  = memberDAO.insertMember(memberVO); 
		
		return res;
	}

	@Override
	public int userCheck(MemberVO memberVO) {
		int res  = memberDAO.userCheck(memberVO); 
		
		return res;
	}

	@Override
	public ArrayList<MemberVO> getMemberlist() {
		ArrayList<MemberVO> member_list = new ArrayList<MemberVO>();
		member_list = memberDAO.getMemberlist();
	
		return member_list;
	}

	@Override
	public MemberVO selectMember(MemberVO memberVO) {
		MemberVO vo  = memberDAO.selectMember(memberVO);
			
		return vo;
	}

	@Override
	public int deleteMember(MemberVO memberVO) {
		int res = memberDAO.deleteMember(memberVO); 
		
		return res;
	}

}
