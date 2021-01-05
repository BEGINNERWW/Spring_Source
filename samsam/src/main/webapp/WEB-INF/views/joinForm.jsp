<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.project.samsam.member.MemberVO"%>
<%	
	MemberVO vo = (MemberVO) request.getAttribute("MemberVO"); 
%>  
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리 시스템 회원가입 페이지</title>
</head>
<body>
<form name = "joinform" action = "kkoJoin.me" method ="post">
<input type="hidden" name = "grade" value =<%=vo.getGrade() %>>
<center>
<table border= 1>
	<tr>
		<td colspan="2" align=center>
			<b><font size=5>회원가입 페이지</font></b>
		</td>
	</tr>
	<tr><td>이메일 : </td><td><input type="text" name= "email" value=<%=vo.getEmail() %> readonly></td></tr>
	<tr><td>비밀번호 : </td><td><input type="password" name= "pw"/></td></tr>
	<tr><td>이름 : </td><td><input type="text" name= "name" /></td></tr>
	<tr><td>닉네임 : </td><td><input type="text" name= "nick" value=<%=vo.getNick() %>></td></tr>
	<tr>
		<td>전화번호 : </td>
		<td>
			<input type="text" name ="phone">
		</td>
	</tr>
	<tr><td>주소 : </td><td><input type="text" name= "local" size=30/></td></tr>
	<tr>
		<td>프로필사진  : 일단 공란</td> <td><input type="text" name="img"></td>
	</tr>
	<tr><td colspan="2" algin ="center">
		<a href="javascript:joinform.submit()">회원가입</a>&nbsp;&nbsp;
		<a href="javascript:joinform.reset()">다시작성</a>
		</td>
	</tr>
</table>
</center>
</form>
</body>
</html>