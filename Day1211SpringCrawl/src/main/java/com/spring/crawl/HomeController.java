package com.spring.crawl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HomeController {
	
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home() {
				
		return "home";
	}
	@RequestMapping(value = "/crawl.do", method = RequestMethod.GET)
	public ModelAndView crawl(ModelAndView model) {
		String url = "https://movie.naver.com/movie/sdb/rank/rmovie.nhn";
		Document doc = null;
		
		try {
			doc = Jsoup.connect(url).get();
		}catch(IOException e) {
			e.printStackTrace();
			System.out.println("doc read error : " +e.getMessage());
		}
		
		//랭킹 나오는 태그를 찾아서 가져오도록 한다
		//System.out.println(doc);
		Elements element = doc.select("div.tab_type_6");
		System.out.println("####################### div.tab_type_6 #######################");
		//System.out.println(element);
		
		ArrayList<String> tabs_url = new ArrayList<String>();
		ArrayList<String> tabs_img_url = new ArrayList<String>();
		ArrayList<String> tabs_alt = new ArrayList<String>();
		
		for(Element el : element.select("li")) {
			String tab_url = "https://movie.naver.com/movie/sdb/rank/" + el.select("a").attr("href");
			String tab_img_url = el.select("img").attr("src");
			String tab_alt = el.select("img").attr("alt");
			System.out.println(tab_url);
			tabs_url.add(tab_url);
			tabs_img_url.add(tab_img_url);
			tabs_alt.add(tab_alt);
		}
		
		Elements element1 =doc.select("table.list_ranking");
		System.out.println("####################### table.list_ranking #######################");
		//System.out.println(element1);
		
		ArrayList<String> title_list = new ArrayList<String>();
		ArrayList<String> movie_url = new ArrayList<String>();

		for(Element el : element1.select("td.title")) {
			String title = el.select("a").attr("title");
			//System.out.println(title);
			title_list.add(title);
			String movie = el.select("a").attr("href");
			movie_url.add(movie);
		}
		model.addObject("title_list",title_list);
		model.addObject("tabs_url", tabs_url);
		model.addObject("tabs_img_url", tabs_img_url);
		model.addObject("tabs_alt", tabs_alt);
		model.addObject("movie_url", movie_url);
		model.setViewName("crawl3");
		
		return model;
	}
	@RequestMapping(value = "/url0.do", produces="application/json; charset=UTF-8")
	@ResponseBody // jsp와 같은 뷰를 전달하는게 아닌 데이터를 전달하기 위해 사용
	public ModelAndView getList(ModelAndView model) {
		String url = "https://movie.naver.com/movie/sdb/rank/rmovie.nhn";
		Document doc = null;
		
		try {
			doc = Jsoup.connect(url).get();
		}catch(IOException e) {
			e.printStackTrace();
			System.out.println("doc read error : " +e.getMessage());
		}
		
		//랭킹 나오는 태그를 찾아서 가져오도록 한다
		//System.out.println(doc);
		Elements element = doc.select("div.tab_type_6");
		System.out.println("####################### div.tab_type_6 #######################");
		//System.out.println(element);
		
		ArrayList<String> tabs_url = new ArrayList<String>();
		ArrayList<String> tabs_img_url = new ArrayList<String>();
		ArrayList<String> tabs_alt = new ArrayList<String>();
		
		for(Element el : element.select("li")) {
			String tab_url = "https://movie.naver.com/movie/sdb/rank/" + el.select("a").attr("href");
			String tab_img_url = el.select("img").attr("src");
			String tab_alt = el.select("img").attr("alt");
			System.out.println(tab_url);
			tabs_url.add(tab_url);
			tabs_img_url.add(tab_img_url);
			tabs_alt.add(tab_alt);
		}
		
		Elements element1 =doc.select("table.list_ranking");
		System.out.println("####################### table.list_ranking #######################");
		//System.out.println(element1);
		
		ArrayList<String> title_list = new ArrayList<String>();
		ArrayList<String> movie_url = new ArrayList<String>();

		for(Element el : element1.select("td.title")) {
			String title = el.select("a").attr("title");
			//System.out.println(title);
			title_list.add(title);
			String movie = el.select("a").attr("href");
			movie_url.add(movie);
		}
		model.addObject("title_list",title_list);
		model.addObject("tabs_url", tabs_url);
		model.addObject("tabs_img_url", tabs_img_url);
		model.addObject("tabs_alt", tabs_alt);
		model.addObject("movie_url", movie_url);
		model.setViewName("crawl3");
		
		return model;
		
	}
	
	@RequestMapping(value = "/url1.do", produces="application/json; charset=UTF-8")
	@ResponseBody // jsp와 같은 뷰를 전달하는게 아닌 데이터를 전달하기 위해 사용
	public ModelAndView getList1(ModelAndView model) {
		String url = "https://movie.naver.com/movie/sdb/rank/rmovie.nhn";
		Document doc = null;
		
		try {
			doc = Jsoup.connect(url).get();
		}catch(IOException e) {
			e.printStackTrace();
			System.out.println("doc read error : " +e.getMessage());
		}
		
		ArrayList<String> tabs_url = new ArrayList<String>();
		ArrayList<String> tabs_img_url = new ArrayList<String>();
		ArrayList<String> tabs_alt = new ArrayList<String>();
		ArrayList<String> title_list = new ArrayList<String>();
		ArrayList<String> point_list = new ArrayList<String>();
		
		//랭킹 나오는 태그를 찾아서 가져오도록 한다
		//System.out.println(doc);
		Elements element = doc.select("div.tab_type_6");
		System.out.println("####################### div.tab_type_6 #######################");
		
		for(Element el : element.select("li")) {
			String tab_url = "https://movie.naver.com/movie/sdb/rank/" + el.select("a").attr("href");
			String tab_img_url = el.select("img").attr("src");
			String tab_alt = el.select("img").attr("alt");
			System.out.println(tab_url);
			tabs_url.add(tab_url);
			tabs_img_url.add(tab_img_url);
			tabs_alt.add(tab_alt);
		}
		
		for(Element el : element.select("td.title")) {
		String text = el.select("a").attr("title");
		//System.out.println(text);
		//System.out.println("-------------------------------------------------------------------------------------------------------");
		title_list.add(text);
		}
		
		for(Element el : element.select("td.point")) {
		String text = el.text().toString();
		System.out.println("평점 :" +text);
		System.out.println("-------------------------------------------------------------------------------------------------------");
		point_list.add(text);
		}
		
		model.addObject("title_list",title_list);
		model.addObject("point_list",point_list);
		model.addObject("tabs_url", tabs_url);
		model.addObject("tabs_img_url", tabs_img_url);
		model.addObject("tabs_alt", tabs_alt);
		model.setViewName("crawl2");
		
		return model;
	}
	
	@RequestMapping(value = "/url2.do", produces="application/json; charset=UTF-8")
	@ResponseBody // jsp와 같은 뷰를 전달하는게 아닌 데이터를 전달하기 위해 사용
	public ModelAndView getList2(ModelAndView model) {
		String url = "https://movie.naver.com/movie/sdb/rank/rmovie.nhn";
		Document doc = null;
		
		try {
			doc = Jsoup.connect(url).get();
		}catch(IOException e) {
			e.printStackTrace();
			System.out.println("doc read error : " +e.getMessage());
		}
		
		ArrayList<String> tabs_url = new ArrayList<String>();
		ArrayList<String> tabs_img_url = new ArrayList<String>();
		ArrayList<String> tabs_alt = new ArrayList<String>();
		ArrayList<String> title_list = new ArrayList<String>();
		ArrayList<String> point_list = new ArrayList<String>();
		ArrayList<String> movie_url = new ArrayList<String>();
		
		//랭킹 나오는 태그를 찾아서 가져오도록 한다
		//System.out.println(doc);
		Elements element = doc.select("div.tab_type_6");
		System.out.println("####################### div.tab_type_6 #######################");
		
		for(Element el : element.select("li")) {
			String tab_url = "https://movie.naver.com/movie/sdb/rank/" + el.select("a").attr("href");
			String tab_img_url = el.select("img").attr("src");
			String tab_alt = el.select("img").attr("alt");
			System.out.println(tab_url);
			tabs_url.add(tab_url);
			tabs_img_url.add(tab_img_url);
			tabs_alt.add(tab_alt);
		}
		Elements element2 = doc.select("table.list_ranking");
		System.out.println("####################### list_rangking #######################");
		
		for(Element el : element2.select("td.title")) {
		String text = el.select("a").attr("title");
		String movie = el.select("a").attr("href");
		System.out.println(text);
		System.out.println("-------------------------------------------------------------------------------------------------------");
		title_list.add(text);
		movie_url.add(movie);
		}
	
		for(Element el : element2.select("td.point")) {
		String text = el.text();
		System.out.println("평점 :" +text);
		System.out.println("-------------------------------------------------------------------------------------------------------");
		point_list.add(text);
		}
		
		model.addObject("title_list",title_list);
		model.addObject("point_list",point_list);
		model.addObject("tabs_url", tabs_url);
		model.addObject("tabs_img_url", tabs_img_url);
		model.addObject("tabs_alt", tabs_alt);
		model.addObject("movie_url", movie_url);
		model.setViewName("crawl1");
		
		return model;
	}
	
	@RequestMapping(value = "/url10.do", produces="application/json; charset=UTF-8")
	@ResponseBody // jsp와 같은 뷰를 전달하는게 아닌 데이터를 전달하기 위해 사용
	public Map<Object,Object> getSearchList(String url, Model model) {
		ArrayList<String> title_list = new ArrayList<String>();
		ArrayList<String> point_list = new ArrayList<String>();
		Map<Object,Object> tot_list = new HashMap<Object,Object>();
		
		System.out.println("url=" + url);
		String url1 = url;
		Document doc = null;
		
		try {
			doc = Jsoup.connect(url1).get();
			System.out.println("doc=" + doc);
		}catch(IOException e) {
			e.printStackTrace();
			System.out.println("doc read error : " +e.getMessage());
		}
						
		//2.하위 리스들을 for문 돌면서 출력
		Elements element2 = doc.select("table.list_ranking");
		System.out.println("####################### list_rangking #######################");
		//System.out.println("element2=" + element2);
		
		for(Element el : element2.select("td.title")) {
		String text = el.select("a").attr("title");
		//System.out.println(text);
		//System.out.println("-------------------------------------------------------------------------------------------------------");
		title_list.add(text);
		}
		
		for(Element el : element2.select("td.point")) {
		String text = el.text().toString();
		System.out.println("평점 :" +text);
		System.out.println("-------------------------------------------------------------------------------------------------------");
		point_list.add(text);
		}
		
		tot_list.put(title_list, point_list);
		System.out.println("tot_list:"+tot_list);
		
		return tot_list;
	}
}
