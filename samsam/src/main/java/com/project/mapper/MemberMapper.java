package com.project.mapper;

import java.util.ArrayList;

import com.project.samsam.member.Biz_memberVO;
import com.project.samsam.member.MemberVO;

public interface MemberMapper {

	public MemberVO selectMember(String email);
	public ArrayList<MemberVO> getMemberlist();
	public int updateMember(MemberVO vo);
	public int updateBiz_Member(Biz_memberVO vo);
	public int pwUpdate_M(MemberVO vo);
	public int pwUpdate_BM(Biz_memberVO vo);
	public String check_auth(Biz_memberVO vo);
}
