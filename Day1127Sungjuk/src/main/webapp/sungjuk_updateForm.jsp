<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.spring.day1127.SungjukProcessVO" %>
<%
String hakbun=null;

if((session.getAttribute("hakbun")==null)|| (!((String)session.getAttribute("hakbun")).equals("admin"))) {
	out.println("<script>");
	out.println("location.href='loginform.me'");
	out.println("</script>");
}
SungjukProcessVO vo= (SungjukProcessVO)request.getAttribute("sungjukVO");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name = "s_updateform" action = "sungjukupdate.me" method ="post">
<table border = 1 width =300 align=center>
	<tr align =center><td colspan=2 align=center> 성적정보 수정 </td></tr>
	<tr align =center><td>학번 : </td><td><input type="text" name= "hakbun" readonly value="${sungjukVO.getHakbun() }"/></td></tr>
	<tr align =center><td>이름 : </td><td><input type="text" name= "name" value="${sungjukVO.getName() }"/></td></tr>
	<tr align =center><td>국어 : </td><td><input type="text" name= "kor" maxlength =3 value="${sungjukVO.getKor() }"/></td></tr>
	<tr align =center><td>영어 : </td><td><input type="text" name= "eng" maxlength =3 value="${sungjukVO.getEng() }"/>	</td></tr>
	<tr align =center><td>수학 : </td><td><input type="text" name= "math" maxlength =3 value="${sungjukVO.getMath() }"/></td></tr>
	<tr align=center>
		<td colspan="2">
		<input type="button" value="수정" onclick="location.href='javascript:s_updateform.submit()'">&nbsp;&nbsp;
		<input type="button" value="성적리스트" onclick="history.back()">
		</td>
	</tr>
</table>
</body>
</html>