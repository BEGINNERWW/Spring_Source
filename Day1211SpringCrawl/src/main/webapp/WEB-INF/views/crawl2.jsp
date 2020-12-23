<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page import = "java.util.ArrayList" %>
<%
	ArrayList<String> tabs_url= (ArrayList<String>)request.getAttribute("tabs_url");
	ArrayList<String> tabs_img_url= (ArrayList<String>)request.getAttribute("tabs_img_url");
	ArrayList<String> tabs_alt= (ArrayList<String>)request.getAttribute("tabs_alt");
	ArrayList<String> title_list = (ArrayList<String>)request.getAttribute("title_list");
	ArrayList<String> point_list = (ArrayList<String>)request.getAttribute("point_list");
	ArrayList<String> movie_url = (ArrayList<String>)request.getAttribute("movie_url");


%>
<html>
<head>
<meta charset ="utf-8">
<title>네이버 영화순위 크롤링</title>
<style>
table {
border : 1px solid #ffffff;
}
a { text-decoration:none } 
</style>

</head>
<body>
	<div align="center">
		<%for(int i=0; i<tabs_url.size(); i++) {%>
		<span><img id="menu" src = <%=tabs_img_url.get(i).toString() %> alt=<%=tabs_url.get(i).toString() %> onclick = "location.href='url<%=i %>.do'"></span>
		<%} %>
	</div>
<table id ="listing" align ="center">
	<tr align="center">
		<th>순위 </th><th colspan="2">영화제목(평점순_현재 상영)</th>
	</tr>
	<tr>&nbsp;</tr>
	<%for(int i = 0; i<title_list.size(); i++){ %>
	<tr>
		<td><%=i+1 %></td><td>&nbsp;&nbsp;<a href=<%=movie_url.get(i).toString()%>><%=title_list.get(i).toString() %></a></td>
		<td>&nbsp;&nbsp;<%=point_list.get(i).toString() %></td>
	</tr>
	<%} %>
</table>
</body>
</html>