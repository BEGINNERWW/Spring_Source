package com.project.samsam.admin;

import java.util.ArrayList;

import com.project.samsam.member.MemberVO;
import com.project.samsam.simport.Payed_listVO;

public interface AdminSV {
	public ArrayList<MemberVO> serach_member(Search_paramsVO svo);
	public int 	auth_confirm(String email);
	public int 	update_confirm(String email);
	public int 	auth_return(String email);
	public ArrayList<Payed_listVO> 	getPay_list();

}
