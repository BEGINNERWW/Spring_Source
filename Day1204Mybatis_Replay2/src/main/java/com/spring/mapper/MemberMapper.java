package com.spring.mapper;

import java.util.ArrayList;

import com.spring.mb2replay.member.MemberVO;

public interface MemberMapper {
	public ArrayList<MemberVO> getMemberlist();
	public int insertMember(MemberVO memberVO);
	public MemberVO selectMember(MemberVO memberVO);
	public int userCheck(MemberVO memberVO);
	public int deleteMember(MemberVO memberVO);

}
