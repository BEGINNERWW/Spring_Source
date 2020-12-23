package com.spring.springwebsocket2;

public interface MemberService {
	public int insertMember(MemberVO vo);
	public int userCheckMember(MemberVO vo);
	public String pickNameMember(MemberVO vo);
}
