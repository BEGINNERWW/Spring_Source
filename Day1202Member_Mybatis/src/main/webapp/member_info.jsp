<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.spring.day1202mybatis.MemberVO" %>
<%
String id=null;

if((session.getAttribute("id")==null)|| (!((String)session.getAttribute("id")).equals("admin"))) {
	out.println("<script>");
	out.println("location.href='loginform.me'");
	out.println("</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border = 1 width =300 align=center>
	<tr align =center><td>아이디 : </td><td>${memberVO.get("id") }</td></tr>
	<tr align =center><td>비밀번호 : </td><td>${memberVO.get("password") }</td></tr>
	<tr align =center><td>이름 : </td><td>${memberVO.get("name") }</td></tr>
	<tr align =center><td>나이 : </td><td>${memberVO.get("age") }</td></tr>
	<tr align =center><td>성별 : </td><td>${memberVO.get("gender") }</td></tr>
	<tr align =center><td>이메일 : </td><td>${memberVO.get("email") }</td></tr>
	<tr align=center>
		<td colspan=2><a href="memberlist.me">리스트로 돌아가기</a></td>
	</tr>
</table>
</body>
</html>