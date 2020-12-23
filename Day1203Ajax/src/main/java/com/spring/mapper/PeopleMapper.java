package com.spring.mapper;

import java.util.List;
import java.util.Map;

import com.spring.ajax.PeopleVO;

public interface PeopleMapper {

	List<PeopleVO> getPeopleList();
	PeopleVO selectPeople(String id);
	int insertPeople(PeopleVO vo);
	void deletePeople(String id);
	void updatePeople(PeopleVO vo);
}
