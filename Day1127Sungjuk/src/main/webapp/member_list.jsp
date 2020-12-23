<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.spring.day1127.MemberVO" %>

<%
String hakbun=null;

if((session.getAttribute("hakbun")==null)|| (!((String)session.getAttribute("hakbun")).equals("admin"))) {
	out.println("<script>");
	out.println("location.href='loginform.me'");
	out.println("</script>");
}

ArrayList<MemberVO> member_list= (ArrayList<MemberVO>)request.getAttribute("member_list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자모드(회원목록 보기)</title>
</head>
<body>
<table border=1 width =300 align=center>
	<tr align=center><td colspan=3>회원 목록 </td></tr>
	<%for(int i=0; i<member_list.size();i++){ 
		MemberVO vo =(MemberVO)member_list.get(i);
	%>
	<tr align=center>
		<td>
			<a href ="memberinfo.me?hakbun=<%=vo.getHakbun() %>">
			<%=vo.getHakbun() %>
			</a>
		</td>
		<td><a href ="memberdelete.me?hakbun=<%=vo.getHakbun() %>">삭제</a></td>
		<td><a href ="memberupdateform.me?hakbun=<%=vo.getHakbun() %>">수정</a></td>
	</tr>
	<%} %>
	<tr>
		<td colspan ="3" align="center">
		<input type="button" value = "메인화면" onclick = "location.href='main.me'"> &nbsp;&nbsp;
		<input type="button" value = "로그아웃" onclick = "location.href='login.me'">
		</td>
	</tr>
	
</table>
</body>
</html>