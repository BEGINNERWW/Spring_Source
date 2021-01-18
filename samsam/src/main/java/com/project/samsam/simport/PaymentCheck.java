package com.project.samsam.simport;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class PaymentCheck {
	public static final String IMPORT_TOKEN_URL ="https://api.iamport.kr/users/getToken";
	//	public static final String IMPORT_PAYMENTINFO_URL ="https://api.iamport.kr/payments/find/";
	public static final	String IMPORT_CANCLE_URL = "https://api.iamport.kr/payments/cancel";
	//  public static final String IMPORT_PREPARE_URL = "https://api.iamport.kr/payments/prepare";
	//  public static final String KEY ="4743165764154638";
	public static final String KEY ="4743165764154638";
	//  public static final String SECRET = "Ypj2qqpTdQhkwP38ieJHV3BF9L3XXcZWCjY2JoWXfehL3kUlzD3uHE9QqdOoqNk27j5RH2OWg5IjqCFZ";
	public static final String SECRET = "Ypj2qqpTdQhkwP38ieJHV3BF9L3XXcZWCjY2JoWXfehL3kUlzD3uHE9QqdOoqNk27j5RH2OWg5IjqCFZ";
	
	public String getImportToken() {
		String result = "";
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_TOKEN_URL); 
		Map<String,String> m = new HashMap<String,String>();
		m.put("imp_key", KEY);
		m.put("imp_secret", SECRET);
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
			HttpResponse res = client.execute(post); 
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			System.out.println("body=" + body);
			JsonNode rootNode = mapper.readTree(body); 
			System.out.println("rootNode = " +rootNode);
			JsonNode resNode = rootNode.get("response");
			System.out.println("resNode="+resNode);
			
			result = resNode.get("access_token").asText();
			System.out.println("result ="+result);
		}catch(Exception e) {
			e.printStackTrace();
		} return result;
	}
	private List<NameValuePair> convertParameter(Map<String,String> paramMap){
		List<NameValuePair> paramList = new ArrayList<NameValuePair>();
		Set<Entry<String,String>> entries = paramMap.entrySet();
		
		for(Entry<String,String> entry : entries) {
			paramList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}
		return paramList;
	}
	
	public int cancelPayment(String token, String mid) {
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_CANCLE_URL);
		Map<String,String> map = new HashMap<String,String>();
		post.setHeader("Authorization", token);
		map.put("merchant_uid", mid);
		String asd ="";
		
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map)));
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String enty = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(enty);
			asd = rootNode.get("response").asText();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		if(asd.equals("null")) {
			System.out.println("fail"); return -1;
		}else{
			System.out.println("success"); return 1;
		}
	}
}
