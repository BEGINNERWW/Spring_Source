package com.project.samsam.admin;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.MemberMapper;
import com.project.samsam.member.MemberVO;
import com.project.samsam.simport.Payed_listVO;

@Service
public class AdminSVImp implements AdminSV {

	MemberMapper mapper = null;
	
	@Autowired
	public AdminSVImp(SqlSession sqlSession) {
	     this.mapper = sqlSession.getMapper(MemberMapper.class);
	}
	
	@Override
	public ArrayList<MemberVO> serach_member(Search_paramsVO svo) {
		ArrayList<MemberVO> mvo = mapper.serach_member(svo);
				
		return mvo;
	}
	
	@Override
	public int 	auth_confirm(String email) {
		int res = mapper.auth_confirm(email);
		
		return res;
	}
	
	@Override
	public int 	update_confirm(String email) {
		int res = mapper.update_confirm(email);
		
		return res;
	}

	@Override
	public int 	auth_return(String email) {
		int res = mapper.auth_return(email);
		
		return res;
	}

	@Override
	public ArrayList<Payed_listVO> getPay_list(){
		ArrayList<Payed_listVO> plist = mapper.getPay_list();
		
		return plist;
	}
	//todolist
	@Override
	public int insert_todo(Todo_listVO todo) {
		int res = mapper.insert_todo(todo);
		
		return res;
	}
	@Override
	public int update_todo(Todo_listVO todo) {
		int res = mapper.update_todo(todo);
		
		return res;
	}

	@Override
	public int delete_todo(Todo_listVO todo) {
		int res= mapper.delete_todo(todo);
		
		return res;
	}
	@Override
	public ArrayList<Todo_listVO> select_todo(){
		ArrayList<Todo_listVO> todolist = mapper.select_todo();
				
		return todolist;
	}
	
}
