package com.spring.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.day1202mybatis.MemberVO;

public interface MemberMapper {

	ArrayList<MemberVO> getMemberlist();
	HashMap<String,String> selectMember(MemberVO memberVO);
	int insertMember(MemberVO member);
	int updateMember(MemberVO member);
	int deleteMember(String id);
	//int getCount();
}
