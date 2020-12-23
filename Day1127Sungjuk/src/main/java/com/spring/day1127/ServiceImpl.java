package com.spring.day1127;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.day1127.SungjukDAO;

@Service("memberService") // "memberService" >> 서버안에서 bean객체가 만들어질때 생성된 객체 이름
public class ServiceImpl implements SungjukService {

	@Autowired(required=false) //주로 필드에 사용, 의존성주입(DI)가 이루어짐(알아서 대입해줌)
	private SungjukDAO sungjukDAO = null;
	
	@Override
	public int insertSungjuk(SungjukProcessVO sVO) {
		sVO.process();
		int res = sungjukDAO.insertSungjuk(sVO);
		return res;
	}

	@Override
	public int insertMember(MemberVO mVO) {
		int res = sungjukDAO.insertMember(mVO);
		return res;
	}

	@Override
	public int userCheck(MemberVO mVO) {
		int x = sungjukDAO.userCheck(mVO);
		return x;
	}

	@Override
	public ArrayList<SungjukProcessVO> getSungjuklist() {
		ArrayList<SungjukProcessVO> sungjuk_list = new ArrayList<SungjukProcessVO>(); 
		sungjuk_list = sungjukDAO.getSungjuklist();
		return sungjuk_list;
	}

	@Override
	public ArrayList<MemberVO> getMemberlist() {
		ArrayList<MemberVO> member_list = new ArrayList<MemberVO>(); 
		member_list = sungjukDAO.getMemberlist();
		return member_list;
	}

	@Override
	public MemberVO selectMember(MemberVO mVO) {
		MemberVO vo = sungjukDAO.selectMember(mVO);
		return vo;
	}
	@Override
	public SungjukProcessVO selectSungjuk(SungjukProcessVO sVO) {
		SungjukProcessVO vo = sungjukDAO.selectSungjuk(sVO);
		return vo;
	}

	@Override
	public int deleteSungjuk(SungjukProcessVO sVO) {
		int result = sungjukDAO.deleteSungjuk(sVO);
		return result;
	}

	@Override
	public int deleteMember(MemberVO mVO) {
		int result = sungjukDAO.deleteMember(mVO);
		return result;
	}

	@Override
	public int updateSungjuk(SungjukProcessVO sVO) {
		sVO.process();
		
		int result = sungjukDAO.updateSungjuk(sVO);
		return result;
	}

	@Override
	public int updateMember(MemberVO mVO) {
		int result = sungjukDAO.updateMember(mVO);
		return result;
	}

}
