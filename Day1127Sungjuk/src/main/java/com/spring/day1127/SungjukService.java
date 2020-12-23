package com.spring.day1127;

import java.util.ArrayList;
import java.util.HashMap;

public interface SungjukService {
	public int insertSungjuk(SungjukProcessVO sVO);
	public int insertMember(MemberVO mVO);
	public int userCheck(MemberVO mVO);
	public ArrayList<SungjukProcessVO> getSungjuklist();
	public ArrayList<MemberVO> getMemberlist();
	public MemberVO selectMember(MemberVO mVO);
	public SungjukProcessVO selectSungjuk(SungjukProcessVO sVO);
	public int deleteSungjuk(SungjukProcessVO sVO);
	public int deleteMember(MemberVO mVO);
	public int updateSungjuk(SungjukProcessVO sVO);
	public int updateMember(MemberVO mVO);

}
