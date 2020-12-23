package com.spring.mb2replay.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.MemberMapper;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	MemberMapper mapper = null;
	
	@Autowired
	public MemberServiceImpl(SqlSession sqlSession) {
	     this.mapper = sqlSession.getMapper(MemberMapper.class);
	}
	
	@Override
	public int insertMember(MemberVO memberVO) {
		int res = mapper.insertMember(memberVO);
		
		return res;
	}

	@Override
	public int userCheck(MemberVO memberVO) {
		int res  = mapper.userCheck(memberVO); 
		
		return res;
	}

	@Override
	public ArrayList<MemberVO> getMemberlist() {
		ArrayList<MemberVO> member_list = new ArrayList<MemberVO>();
		member_list = mapper.getMemberlist();
	
		return member_list;
	}

	@Override
	public MemberVO selectMember(MemberVO memberVO) {
		MemberVO vo  = mapper.selectMember(memberVO);
			
		return vo;
	}

	@Override
	public int deleteMember(MemberVO memberVO) {
		int res = mapper.deleteMember(memberVO); 
		
		return res;
	}

}
