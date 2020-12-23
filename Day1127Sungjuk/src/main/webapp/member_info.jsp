<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.spring.day1127.MemberVO" %>
<%
String hakbun=null;

if(session.getAttribute("hakbun")==null) {
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
<h2 align =center>학생 인적 정보 </h2>
<table border = 1 width =300 align=center>
	<tr align =center><td>학번 : </td><td>${memberInfo.getHakbun() }</td></tr>
	<tr align =center><td>비밀번호 : </td><td>${memberInfo.getPw() }</td></tr>
	<tr align =center><td>이름 : </td><td>${memberInfo.getName() }</td></tr>
	<tr align =center><td>나이 : </td><td>${memberInfo.getAge() }</td></tr>
	<tr align =center><td>클래스 : </td><td>${memberInfo.getS_class() }</td></tr>
	<tr align =center><td>이메일 : </td><td>${memberInfo.getEmail() }</td></tr>
</table><br>
<h2 align =center>학생 성적 정보 </h2>
<h6 align =center> ** 성적이 입력되지 않을 경우 빈칸 혹은 0으로 표기됩니다</h6>
<table border = 1 width =300 align=center>
	<tr align =center><td>학번 : </td><td>${sungjukInfo.getHakbun() }</td></tr>
	<tr align =center><td>이름 : </td><td>${sungjukInfo.getName() }</td></tr>
	<tr align =center><td>국어 : </td><td>${sungjukInfo.getKor() }</td></tr>
	<tr align =center><td>영어 : </td><td>${sungjukInfo.getEng() }</td></tr>
	<tr align =center><td>수학 : </td><td>${sungjukInfo.getMath() }</td></tr>
	<tr align =center><td>합계 : </td><td>${sungjukInfo.getTot() }</td></tr>
	<tr align =center><td>평균 : </td><td>${sungjukInfo.getAvg() }</td></tr>
	<tr align =center><td>등급 : </td><td>${sungjukInfo.getGrade() }</td></tr>
</table><br>
	<div align=center>
		<input type="button" value="BACK" onclick="history.back()">
	</div><br><br>
</body>
</html>