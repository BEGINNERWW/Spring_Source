<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
	if ((session.getAttribute("id")==null) || 
			(!((String)session.getAttribute("id")).equals("admin"))) {
		out.println("<script>");
		out.println("location.href='./loginform.me'");
		out.println("</script>");
	}
%>
<html>
<head>
<title>회원관리 시스템 관리자모드(회원 정보 보기)</title>
</head>
<body>
<center>
<table border=1 width=300>
	<tr align=center><td>아이디 : </td><td>${memberVO.getId()}</td></tr>
	<tr align=center><td>비밀번호 : </td><td>${memberVO.getPassword()}</td></tr>
	<tr align=center><td>이름 : </td><td>${memberVO.getName()}</td></tr>
	<tr align=center><td>나이 : </td><td>${memberVO.getAge()}</td></tr>
	<tr align=center><td>성별 : </td><td>${memberVO.getGender()}</td></tr>
	<tr align=center><td>이메일 주소 : </td><td>${memberVO.getEmail()}</td></tr>
	<tr align=center>
		<td colspan=2><a href="memberlist.me">리스트로 돌아가기</a></td>
	</tr>
</table>
</center>
</body>
</html>