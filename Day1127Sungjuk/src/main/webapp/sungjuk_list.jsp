<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.spring.day1127.SungjukProcessVO" %>

<%
String hakbun=null;

if((session.getAttribute("hakbun")==null)|| (!((String)session.getAttribute("hakbun")).equals("admin"))) {
	out.println("<script>");
	out.println("location.href='loginform.me'");
	out.println("</script>");
}

ArrayList<SungjukProcessVO> sungjuk_list = 

(ArrayList<SungjukProcessVO>)request.getAttribute("sungjuk_list");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>관리자모드(학생성적 보기)</title>
</head>
<body>
<table border=1 width =300 align=center>
	<tr align=center><td colspan=3> 학생 성적 목록 </td></tr>
	<%
		for(int i=0; i < sungjuk_list.size();i++){ 
		SungjukProcessVO vo =(SungjukProcessVO)sungjuk_list.get(i);
	%>
	<tr align=center>
		<td>
			<a href ="memberinfo.me?hakbun=<%=vo.getHakbun() %>">
			<%=vo.getHakbun() %>
			</a>
		</td>
		<td><a href ="sungjukdelete.me?hakbun=<%=vo.getHakbun() %>">삭제</a></td>
		<td><a href ="sungjukupdateform.me?hakbun=<%=vo.getHakbun() %>">수정</a></td>
	</tr>
	<% } %>
	<tr>
		<td colspan ="3" align="center">
		<input type="button" value = "성적입력" onclick = "location.href='sungjukform.me'"> &nbsp;&nbsp;
		<input type="button" value = "메인화면" onclick = "location.href='main.me'"> &nbsp;&nbsp;
		<input type="button" value = "로그아웃" onclick = "location.href='login.me'">
		</td>
	</tr>
</table>
</body>
</html>
