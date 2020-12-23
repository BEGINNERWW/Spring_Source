package com.spring.day1130_2.member;

import java.util.ArrayList;

public interface MemberService {
	public int insertMember(MemberVO memberVO);
	public int userCheck(MemberVO memberVO);
	public ArrayList<MemberVO> getMemberlist();
	public MemberVO selectMember(MemberVO memberVO);
	public int deleteMember(MemberVO memberVO);
}
