package com.spring.ajax;

import java.util.List;
import java.util.Map;

public interface PeopleService {
	List<PeopleVO> getPeopleList();
	PeopleVO selectPeople(String id);
	void insertPeople(PeopleVO vo);
	void deletePeople(String id);
	void updatePeople(PeopleVO vo);
}
