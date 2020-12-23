package com.spring.day1202mybatis;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	MemberMapper mapper = null;
	
	   @Autowired
	    public MemberServiceImpl(SqlSession sqlSession) {
	        this.mapper = sqlSession.getMapper(MemberMapper.class);
	    }
	   
	// ���� ���ϱ�.... >> mapper ��ü �ʱ�ȭ ������ �������� �Ķ���Ͱ��� ���ؼ� �����ϵ��� �Ǿ��־ ��ü�� �������� �ʾ���
	   
	/*@Autowired //�ַ� �ʵ忡 ���, ����������(DI)�� �̷����(�˾Ƽ� ��������)
	public MemberServiceImpl() {}
	
	SqlSession sqlsession = null;
	MemberMapper mapper = sqlsession.getMapper(MemberMapper.class);
	MemberVO vo = new MemberVO();
	*/
	   
	@Override
	public ArrayList<MemberVO> getMemberlist() {
		ArrayList<MemberVO> member_list = new ArrayList<MemberVO>(); 
		member_list = mapper.getMemberlist();
		
		return member_list;
	}

	@Override
	public HashMap<String, String> selectMember(MemberVO memberVO) {
		HashMap<String,String> map = new HashMap<String,String>();
		map = mapper.selectMember(memberVO);
		
		return map;
	}

	@Override
	public int insertMember(MemberVO memberVO) {
		int res = mapper.insertMember(memberVO);
		
		return res;
	}

	@Override
	public void deleteMember(String id) {
		mapper.deleteMember(id);
		
	}

	@Override
	public int updateMember(MemberVO memberVO) {
		int res = mapper.updateMember(memberVO);
		
		return res;
	}

}
