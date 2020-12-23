package com.spring.mb2replay.member;

import java.util.ArrayList;

public interface MemberService {
	public ArrayList<MemberVO> getMemberlist();
	public int insertMember(MemberVO memberVO);
	public MemberVO selectMember(MemberVO memberVO);
	public int userCheck(MemberVO memberVO);
	public int deleteMember(MemberVO memberVO);
}
