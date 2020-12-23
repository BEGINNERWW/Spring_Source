<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.spring.day1126.MemberVO" %>
<%
String id=null;

if((session.getAttribute("id")==null)|| (!((String)session.getAttribute("id")).equals("admin"))) {
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
	<tr align =center><td colspan=2 align=center> 회원정보 수정 </td></tr>
	<tr align =center><td>아이디 : </td><td><input type="text" name= "id" readonly value="${memberVO.getId() }"/></td></tr>
	<!-- <td>아이디 : </td>
		 <td>${memberVO.getId() }</td>
		 <input type="hidden" name="id" value="${memberVO.getId() }"> -->
	<tr align =center><td>비밀번호 : </td><td><input type="password" name="password" value="${memberVO.getPassword() }"/></td></tr>
	<tr align =center><td>이름 : </td><td><input type="text" name= "name" value="${memberVO.getName() }"/></td></tr>
	<tr align =center><td>나이 : </td><td><input type="text" name= "age" maxlength =2 value="${memberVO.getAge() }"/></td></tr>
	<tr align =center><td>성별 : </td>
		<td>
		<% 
		if(vo.getGender().equals("남")){ %>
			<input type="radio" name ="gender" value="남" checked/> 남자
			<input type="radio" name ="gender" value="여" /> 여자
		<% } else{ %>
			<input type="radio" name ="gender" value="남" /> 남자
			<input type="radio" name ="gender" value="여" checked /> 여자
			
		<% } %>
		</td></tr>
	<tr align =center><td>이메일 : </td><td><input type="text" name= "email" value="${memberVO.getEmail() }"/></td></tr>
	<tr align=center>
		<td colspan="2">
		<a href="javascript:updateform.submit()">수정</a>&nbsp;&nbsp;
		<a href="memberlist.me">리스트로 돌아가기</a>
		</td>
	</tr>
</table>
</body>
</html>