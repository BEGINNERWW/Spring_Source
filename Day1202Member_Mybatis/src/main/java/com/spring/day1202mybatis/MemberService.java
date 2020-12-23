package com.spring.day1202mybatis;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Service;


public interface MemberService {
	
	public ArrayList<MemberVO> getMemberlist();
	public HashMap<String,String> selectMember(MemberVO memberVO);
	public int insertMember(MemberVO memberVO);
	public int updateMember(MemberVO memberVO);
	public void deleteMember(String id);


}
