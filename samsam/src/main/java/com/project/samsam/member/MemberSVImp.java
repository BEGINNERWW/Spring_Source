package com.project.samsam.member;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.MemberMapper;

@Service
public class MemberSVImp implements MemberSV {

	MemberMapper mapper = null;
	
	@Autowired
	public MemberSVImp(SqlSession sqlSession) {
	     this.mapper = sqlSession.getMapper(MemberMapper.class);
	}
	
	@Override
	public MemberVO selectMember(String email) {
		System.out.println(email);
		MemberVO bo = mapper.selectMember(email);
		
		return bo;
	}

	@Override
	public ArrayList<MemberVO> getMemberlist() {
		ArrayList<MemberVO> member_list = new ArrayList<MemberVO>();
		member_list = mapper.getMemberlist();
		
		return member_list;
	}

	@Override
	public int updateMember(MemberVO vo) {
		int result = mapper.updateMember(vo);
		
		return result;
	}

	@Override
	public int updateBiz_Member(Biz_memberVO vo) {
		int result = mapper.updateBiz_Member(vo);
		
		return result;
	}

	@Override
	public int pwUpdate_M(MemberVO vo) {
		int result = mapper.pwUpdate_M(vo);
		
		return result;
	}

	@Override
	public int pwUpdate_BM(Biz_memberVO vo) {
		int result = mapper.pwUpdate_BM(vo);
		
		return result;
	}

	@Override
	public String check_auth(Biz_memberVO vo) {
		String bvo = mapper.check_auth(vo); 
		
		return bvo;
	}

}