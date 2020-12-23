<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.spring.day1127.MemberVO" %>
<%
String hakbun=null;

if((session.getAttribute("hakbun")==null)|| (!((String)session.getAttribute("hakbun")).equals("admin"))) {
	out.println("<script>");
	out.println("location.href='loginform.me'");
	out.println("</script>");
}
MemberVO vo= (MemberVO)request.getAttribute("memberVO");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name = "updateform" action = "memberupdate.me" method ="post">
<table border = 1 width =300 align=center>
	<tr align =center><td colspan=2 align=center> 학생정보 수정 </td></tr>
	<tr align =center><td>학번 : </td><td><input type="text" name= "hakbun" readonly value="${memberVO.getHakbun() }"/></td></tr>
	<tr align =center><td>비밀번호 : </td><td><input type="password" name="pw" value="${memberVO.getPw() }"/></td></tr>
	<tr align =center><td>이름 : </td><td><input type="text" name= "name" value="${memberVO.getName() }"/></td></tr>
	<tr align =center><td>나이 : </td><td><input type="text" name= "age" maxlength =2 value="${memberVO.getAge() }"/></td></tr>
	<tr align =center><td>클래스 : </td><td><input type="text" name= "s_class" value="${memberVO.getS_class() }"/>	</td></tr>
	<tr align =center><td>이메일 : </td><td><input type="text" name= "email" value="${memberVO.getEmail() }"/></td></tr>
	<tr align=center>
		<td colspan="2">
		<input type="button" value="수정" onclick="location.href='javascript:updateform.submit()'">&nbsp;&nbsp;
		<input type="button" value="학생리스트" onclick="location.href='memberlist.me'">
		</td>
	</tr>
</table>
</body>
</html>