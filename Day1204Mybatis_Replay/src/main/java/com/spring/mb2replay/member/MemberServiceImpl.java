package com.spring.mb2replay.member;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.Mapper;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	Mapper mapper = null;
	
	@Autowired
	public MemberServiceImpl(SqlSession sqlSession) {
	     this.mapper = sqlSession.getMapper(Mapper.class);
	}
	
	@Override
	public int insertMember(MemberVO memberVO) {
		int res  = 0;
		
		try {
		res = mapper.insertMember(memberVO);
		System.out.println("멤버 추가(res) : " + res);
		}catch(Exception e) {
			System.out.println("멤버 추가 에러 : " + e.getMessage());
		}
		return res;
	}

	@Override
	public int userCheck(MemberVO memberVO) {
		MemberVO member = new MemberVO();
		int res = 0;
		try {
		member = mapper.selectMember(memberVO);
		System.out.println("member.id :" + member.getId());
		if(memberVO.getPassword().equals(member.getPassword())) {
			res = 1;
		}else {
			res = 0;
		}
		}catch(Exception e) {
			System.out.println("유저체크 에러 : " + e.getMessage());
			res = -1;
		}
		
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
		MemberVO vo  = new MemberVO(); 
		
		try {
			vo = mapper.selectMember(memberVO);
			System.out.println("vo.id : " + vo.getId());
		}catch(Exception e) {
			System.out.println("selectMember 에러 : " + e.getMessage());
		}
		
		return vo;
	}

	@Override
	public int deleteMember(MemberVO memberVO) {
		MemberVO member = new MemberVO();
		int res = 0;
		try {
		res = mapper.deleteMember(memberVO.getId()); 
		System.out.println(memberVO.getId());
		}catch(Exception e) {
			System.out.println("deleteMember 에러 : " + e.getMessage());
		}
		
		return res;
	}

}
