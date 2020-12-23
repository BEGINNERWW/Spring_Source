package com.spring.ajax;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.PeopleMapper;
@Service
public class PeopleServiceImpl implements PeopleService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<PeopleVO> getPeopleList() {
		List<PeopleVO> peopleList = null;
		PeopleMapper memberMapper = sqlSession.getMapper(PeopleMapper.class);
		peopleList = memberMapper.getPeopleList();
		
		return peopleList;
	}
	@Override
	public PeopleVO selectPeople(String id) {
		PeopleVO vo = new PeopleVO();
		PeopleMapper memberMapper = sqlSession.getMapper(PeopleMapper.class);
		System.out.println("서비스 id : " + id);
		vo = memberMapper.selectPeople(id);
		System.out.println("매퍼 : " + vo.getId());
		
		return vo;

	}
	@Override
	public void insertPeople(PeopleVO vo) {
		PeopleMapper memberMapper = sqlSession.getMapper(PeopleMapper.class);
		memberMapper.insertPeople(vo);
		return;

	}

	@Override
	public void deletePeople(String id) {
		PeopleMapper memberMapper = sqlSession.getMapper(PeopleMapper.class);
		memberMapper.deletePeople(id);
		return;

	}
	@Override
	public void updatePeople(PeopleVO vo) {
		PeopleMapper memberMapper = sqlSession.getMapper(PeopleMapper.class);
				memberMapper.updatePeople(vo);
		return;
	}


}
