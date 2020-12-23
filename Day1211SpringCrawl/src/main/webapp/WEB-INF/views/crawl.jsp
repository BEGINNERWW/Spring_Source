<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page import = "java.util.ArrayList" %>
<%
	ArrayList<String> tabs_url= (ArrayList<String>)request.getAttribute("tabs_url");
	ArrayList<String> tabs_img_url= (ArrayList<String>)request.getAttribute("tabs_img_url");
	ArrayList<String> tabs_alt= (ArrayList<String>)request.getAttribute("tabs_alt");
	ArrayList<String> title_list = (ArrayList<String>)request.getAttribute("title_list");
%>
<html>
<head>
<meta charset ="utf-8">
<title>네이버 영화순위 크롤링</title>
<style>
table {
border : 1px solid #ffffff;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

function clickevent(){
	$.ajax({
		url : "/crawl/url1.do",
		type :'POST',
		data :{"url" : $(document).$("#menu").attr("alt")},
		contentType:'application/x-www-form-urlencoded;charset=utf-8',
	    dataType:'json',
	    success: function(list){
	    	var output = '';
	    	output += '<tr align=\"center\"><th>순위 </th><th colspan=\"2\">영화제목(조회순)</th></tr>';
	    	output += '<tr>&nbsp;</tr>';
	    	$.each(list, function(title, point){
	    		for(var i = 0; i < list.size(); i++){
	    		output += '<tr>'
	    		output += '<td>i</td>' + '<td>' + title + '</td><td>'+ point + '</td>';   
		    	output += '</tr>';
	    		}
	    	});
	    	console.log("output:" + output); //F12 개발자도구에서 볼수 있음 (dom 구조로 확인가능) 동적인 내용은 소스보기에서 볼수 없음
            $('#listing').innerHTML(output); //추가
	    }, 
		error : function(){
			alert("ajax통신 실패");
		}
	});//ajax
}; // 클릭이벤트

</script>
</head>
<body>
	<div align="center">
		<%for(int i=0; i<tabs_url.size(); i++) {%>
		<span><img id="menu" src = <%=tabs_img_url.get(i).toString() %> alt=<%=tabs_url.get(i).toString() %> onclick = "javascript:clickevent();"></span>
		<%} %>
	</div>
<table id ="listing" align ="center">
	<tr align="center">
		<th>순위 </th><th colspan="2">영화제목(조회순)</th>
	</tr>
	<tr>&nbsp;</tr>
	<%for(int i = 0; i<title_list.size(); i++){ %>
	<tr>
		<td><%=i+1 %></td><td colspan="2">&nbsp;&nbsp;<%=title_list.get(i).toString() %></td>
	</tr>
	<%} %>
</table>
</body>
</html>