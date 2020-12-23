package com.spring.mapper;

import com.spring.springwebsocket2.MemberVO;

public interface MemberMapper {

		int insertMember(MemberVO vo);
		int userCheckMember(String id);
		String pickNameMember(String id);
}
