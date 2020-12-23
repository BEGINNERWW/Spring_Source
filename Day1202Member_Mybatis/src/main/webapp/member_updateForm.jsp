<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="com.spring.day1202mybatis.MemberVO" %>
<%
String id=null;

if((session.getAttribute("id")==null)|| (!((String)session.getAttribute("id")).equals("admin"))) {
	out.println("<script>");
	out.println("location.href='loginform.me'");
	out.println("</script>");
}
HashMap<String, String> vo= (HashMap<String, String>)request.getAttribute("memberVO");
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
	<tr align =center><td colspan=2 align=center> 회원정보 수정 </td></tr>
	<tr align =center><td>아이디 : </td><td><input type="text" name= "id" readonly value="${memberVO.get("id") }"/></td></tr>
	<!-- <td>아이디 : </td>
		 <td>${memberVO.get("id") }</td>
		 <input type="hidden" name="id" value="${memberVO.get("id") }"> -->
	<tr align =center><td>비밀번호 : </td><td><input type="password" name="password" value="${memberVO.get("password") }"/></td></tr>
	<tr align =center><td>이름 : </td><td><input type="text" name= "name" value="${memberVO.get("name") }"/></td></tr>
	<tr align =center><td>나이 : </td><td><input type="text" name= "age" maxlength =2 value="${memberVO.get("age") }"/></td></tr>
	<tr align =center><td>성별 : </td>
		<td>
		<% 
		if(vo.get("gender").equals("남")){ %>
			<input type="radio" name ="gender" value="남" checked/> 남자
			<input type="radio" name ="gender" value="여" /> 여자
		<% } else{ %>
			<input type="radio" name ="gender" value="남" /> 남자
			<input type="radio" name ="gender" value="여" checked /> 여자
			
		<% } %>
		</td></tr>
	<tr align =center><td>이메일 : </td><td><input type="text" name= "email" value="${memberVO.get("email") }"/></td></tr>
	<tr align=center>
		<td colspan="2">
		<a href="javascript:updateform.submit()">수정</a>&nbsp;&nbsp;
		<a href="memberlist.me">리스트로 돌아가기</a>
		</td>
	</tr>
</table>
</body>
</html>