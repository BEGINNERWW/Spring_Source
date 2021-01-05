package com.project.samsam.simport;

import com.project.samsam.member.Biz_memberVO;

public interface PaySV {

	public int insert_pay(Payed_listVO pvo);
	public Payed_listVO recentlyPay(String email);
	public int updateBiz_pay(Biz_memberVO vo);
	public int updateBiz_refund(Biz_memberVO vo);
	public int refund_pay(String merchant_uid);
}
