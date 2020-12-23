package com.spring.springwebsocket2;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.MemberMapper;

@Service
public class MemberServiceImp implements MemberService {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int insertMember(MemberVO vo) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		int res = mapper.insertMember(vo);
		System.out.println(res);
		return res;
	}

	@Override
	public int userCheckMember(MemberVO vo) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		int res = mapper.userCheckMember(vo.getId());
		System.out.println(res);
		return res;
	}

	@Override
	public String pickNameMember(MemberVO vo) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		String name = mapper.pickNameMember(vo.getId());
		return name;
	}

}
