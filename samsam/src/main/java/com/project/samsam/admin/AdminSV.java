package com.project.samsam.admin;

import java.util.ArrayList;

import com.project.samsam.member.MemberVO;

public interface AdminSV {
	public ArrayList<MemberVO> serach_member(Search_paramsVO svo);
	public int 	auth_confirm(String email);
	public int 	auth_return(String email);


}
