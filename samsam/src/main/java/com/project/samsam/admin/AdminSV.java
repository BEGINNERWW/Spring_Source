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
	
	//chartjs
	public int 	storecount();
	public int 	standbycount();
	//1
	public int 	countAdopt();
	public int 	countHome();
	public int 	countFree();
	public ArrayList<TboardVO> getThreeCount();
	//2
	public ArrayList<ChartjsVO> weeklyLocala();
	public ArrayList<ChartjsVO> weeklyLocalh();
	public ArrayList<ChartjsVO> weeklyLocalf();
	//3
	public ArrayList<ChartjsVO> payedMonth();
	public ArrayList<ChartjsVO> repayedMonth();
	
	//todolist
	public int insert_todo(Todo_listVO todo);
	public int update_todo(Todo_listVO todo);
	public int delete_todo(Todo_listVO todo);
	public ArrayList<Todo_listVO> select_todo();
}
