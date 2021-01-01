package com.project.samsam.simport;

public interface PaySV {

	public int insert_pay(Payed_listVO pvo);
	public Payed_listVO recentlyPay(String email);
	public int updateBiz_pay(String email);
	public int updateBiz_refund(String email);
	public int refund_pay(String merchant_uid);
}
