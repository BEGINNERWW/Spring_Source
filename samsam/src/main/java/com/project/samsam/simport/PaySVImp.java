package com.project.samsam.simport;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.MemberMapper;
import com.project.samsam.member.Biz_memberVO;

@Service
public class PaySVImp implements PaySV {
	MemberMapper mapper = null;
	
	@Autowired
	public PaySVImp(SqlSession sqlSession) {
	     this.mapper = sqlSession.getMapper(MemberMapper.class);
	}
	
	@Override
	public int insert_pay(Payed_listVO pvo) {
		int res = mapper.insert_pay(pvo);
		
		return res;
	}
	
	@Override
	public Payed_listVO recentlyPay(String email) {
		Payed_listVO pvo = mapper.recentlyPay(email);
				
		return pvo;
	}
	
	@Override
	public int updateBiz_pay(Biz_memberVO vo) {
		int res = mapper.updateBiz_pay(vo);
		
		return res;
	}
	
	@Override
	public int updateBiz_refund(Biz_memberVO vo) {
		int res = mapper.updateBiz_refund(vo);
		
		return res;
	}
	
	@Override
	public int refund_pay(String merchant_uid) {
		int res = mapper.refund_pay(merchant_uid);
		
		return res;
		
	}
}
