package com.project.samsam.member;

import java.util.ArrayList;

public interface MemberSV {

	public MemberVO selectMember(String email);
	public ArrayList<MemberVO> getMemberlist();
	public int updateMember(MemberVO vo);
	public int updateBiz_Member(Biz_memberVO vo);
	public int pwUpdate_M(MemberVO vo);
	public int pwUpdate_BM(Biz_memberVO vo);
	public String check_auth(Biz_memberVO vo);
	public int pre_insertBiz(Biz_memberVO vo);
	public Biz_memberVO selectBizMember(String email);
	public int selectBiz_no(String biz_no);
	public ArrayList<Adopt_BoardVO> getMyAdopt(String adopt_email);
	public int getMyAdoptReply(int adopt_no);
	public ArrayList<BoardlistVO> getWriteList(String email);
	public ArrayList<CommentListVO> getWriteComment(String email);
}
