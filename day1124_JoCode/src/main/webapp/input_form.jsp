<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="com.spring.day1124a1.Member" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

Member member = (Member)request.getAttribute("member");

String hobby[] = member.getHobby();
String hobby_str="";
int i;
for(i=0; i<hobby.length-1; i++)
	hobby_str += hobby[i] + ", ";
hobby_str += hobby[i];
%>
<table align="center" border="1" width="280">
	<tr>
		<td width="80"> 아이디 </td>
		<td width="200">
			<%=member.getId() %>
		</td>
	</tr>
	<tr>
		<td width="80"> 비밀번호 </td>
		<td width="200">
			<%=member.getPw() %>
		</td>
	</tr>	
	<tr>
		<td width="80"> 주민번호 </td>
		<td width="200">
			<%=member.getJumin1() %> - <%=member.getJumin2() %>
		</td>
	</tr>	
	<tr>
		<td width="80"> 성별 </td>
		<td width="200">
			<%=member.getGender() %>
		</td>
	</tr>
	<tr>
		<td > 이메일 </td>
		<td >
			<%=member.getEmail1() %>@<%=member.getEmail2() %> 
		</td>
	</tr>
	<tr>
		<td> 취미 </td>
		<td>
			<%=hobby_str %>
		</td>
	</tr>
	<tr>
		<td> 자기소개 </td>
		<td>
			<%=member.getIntro() %>
		</td>
	</tr>
</table>
</body>
</html>