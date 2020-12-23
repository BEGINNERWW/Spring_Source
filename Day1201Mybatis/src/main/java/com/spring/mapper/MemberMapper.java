package com.spring.mapper;
// mapper.xml과 동일한 패키지에 소스파일 생성할것
// xml 파일을 직접적으로 사용하지 못해서 동일한 경로의 동일한 파일명을 가진 인터페이스를 이용한다.

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.mybatis.MemberVO;

public interface MemberMapper {

	ArrayList<MemberVO> getMembers();
	//ArrayList<MemberVO> getMembers(String t);
	//MemberVO getMember(String id);
	HashMap<String, String> getMember(String id);// HashMap 이용시 추가
	//삽입후 삽입한 결과 상태 반환하기 위해 반환값을 int로 정해줌
	int insertMember(MemberVO member);
	void insertMember2(HashMap<String, String> map);
	void updateMember(MemberVO member);
	void deleteMember(String id);
	int getCount();
}
