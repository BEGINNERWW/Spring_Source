package com.project.samsam.admin;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.MemberMapper;
import com.project.samsam.member.MemberVO;

@Service
public class AdminSVImp implements AdminSV {

	MemberMapper mapper = null;
	
	@Autowired
	public AdminSVImp(SqlSession sqlSession) {
	     this.mapper = sqlSession.getMapper(MemberMapper.class);
	}
	
	@Override
	public ArrayList<MemberVO> serach_member(Search_paramsVO svo) {
		ArrayList<MemberVO> mvo = mapper.serach_member(svo);
		
		return mvo;
	}
	
	@Override
	public int 	auth_confirm(String email) {
		int res = mapper.auth_confirm(email);
		
		return res;
	}
	@Override
	public int 	auth_return(String email) {
		int res = mapper.auth_return(email);
		
		return res;
	}

}
