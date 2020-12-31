package com.project.samsam.member;

import java.text.SimpleDateFormat;
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
		
		StringBuffer str = new StringBuffer(bo.getPhone());
		str.insert(0, "0");
				
		String phone = str.substring(0);
		if(phone.substring(0,2).equals("00")) {
			phone = phone.substring(1);
		}
		bo.setPhone(phone);
		
		System.out.println("세팅 폰 : " + bo.getPhone());
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
		System.out.println("check_auth : bvo(biz_name)" + bvo);
		return bvo;
	}
	@Override
	public int pre_insertBiz(Biz_memberVO vo) {
		int result = mapper.pre_insertBiz(vo);
		
		return result;
	}
	@Override
	public Biz_memberVO selectBizMember(String email) {
		Biz_memberVO vo = mapper.selectBizMember(email);
		
		return vo;
	}
	@Override
	public int selectBiz_no(String biz_no) {
		int res = mapper.selectBiz_no(biz_no);
		System.out.println("selectBiz_no : 성공" + res);
		
		return res;
	}
	@Override
	public ArrayList<Adopt_BoardVO> getMyAdopt(String adopt_email) {
		ArrayList<Adopt_BoardVO> bvo = mapper.getMyAdopt(adopt_email);
	
		return bvo;
	}
	
	@Override
	public int getMyAdoptReply(int adopt_no) {
		int res = mapper.getMyAdoptReply(adopt_no);
		
		return res;
	}
	@Override
	public ArrayList<BoardlistVO> getWriteList(String email) {
		ArrayList<BoardlistVO> list = mapper.getWriteList(email);
		if(list!=null) {
		System.out.println("조회 끝 게시글");
		}
		return list;
	}
	@Override
	public ArrayList<CommentListVO> getWriteComment(String email) {
		ArrayList<CommentListVO> list = mapper.getWriteComment(email);
		if(list!=null) {
			System.out.println("조회 끝 댓글");
			}
		return list;
	}
}
