package com.project.mapper;

import java.util.ArrayList;

import com.project.samsam.admin.Search_paramsVO;
import com.project.samsam.admin.Todo_listVO;
import com.project.samsam.member.Adopt_BoardVO;
import com.project.samsam.member.Biz_memberVO;
import com.project.samsam.member.BoardlistVO;
import com.project.samsam.member.CommentListVO;
import com.project.samsam.member.MemberVO;
import com.project.samsam.simport.Payed_listVO;

public interface MemberMapper {

	public MemberVO selectMember(String email);
	public ArrayList<MemberVO> getMemberlist();
	public int updateMember(MemberVO vo);
	public int updateBiz_Member(Biz_memberVO vo);
	public int pwUpdate_M(MemberVO vo);
	public int pwUpdate_BM(Biz_memberVO vo);
	public String check_auth(Biz_memberVO vo);
	public int pre_insertBiz(Biz_memberVO vo);
	public int pre_updateBiz(String vo);
	public Biz_memberVO selectBizMember(String email);
	public int selectBiz_no(String biz_no);
	public ArrayList<Adopt_BoardVO> getMyAdopt(String adopt_email);
	public int getMyAdoptReply(int adopt_no);
	public ArrayList<BoardlistVO> getWriteList(String email);
	public ArrayList<CommentListVO> getWriteComment(String email);
	
	//pay
	public int insert_pay(Payed_listVO pvo);
	public Payed_listVO recentlyPay(String email);
	public int updateBiz_pay(Biz_memberVO vo);
	public int updateBiz_refund(Biz_memberVO vo);
	public int refund_pay(String merchant_uid);

	//admin
	public ArrayList<MemberVO> serach_member(Search_paramsVO svo);
	public int 	auth_confirm(String email);
	public int 	update_confirm(String email);
	public int 	auth_return(String email);
	public ArrayList<Payed_listVO> 	getPay_list();
	public int 	storecount();
	public int 	standbycount();
	
	//todolist
	public int insert_todo(Todo_listVO todo);
	public int update_todo(Todo_listVO todo);
	public int delete_todo(Todo_listVO todo);
	public ArrayList<Todo_listVO> select_todo();
	
	public int joinMember(MemberVO mvo);



}
