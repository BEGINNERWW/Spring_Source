package com.spring.day1126;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("memberService") // "memberService" >> 서버안에서 bean객체가 만들어질때 생성된 객체 이름
public class MemberServiceImpl implements MemberService {
	
	@Autowired(required=false) //주로 필드에 사용, 의존성주입(DI)가 이루어짐(알아서 대입해줌)
	private MemberDAO memberDAO = null;
	
	@Override
	public int insertMember(MemberVO memberVO) {
		int res = memberDAO.insertMember(memberVO);
		return res;
	}

	@Override
	public int userCheck(MemberVO memberVO) {
		int res = memberDAO.userCheck(memberVO);
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
		MemberVO vo = memberDAO.selectMember(memberVO);
		return vo;
	}

	@Override
	public int deleteMember(MemberVO memberVO) {
		int res = memberDAO.deleteMember(memberVO);
		return res;
	}
	@Override
	public int updateMember(MemberVO memberVO) {
		int res = memberDAO.updateMember(memberVO);
		return res;
	}
}
