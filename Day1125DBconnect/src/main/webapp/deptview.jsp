<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.spring.day1125.DeptVO" %>
<%
DeptVO deptvo = (DeptVO)request.getAttribute("deptvo");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<table align="center" border="1">
	<tr align="center">
		<td width="80">&nbsp;부서번호</td>
		<td width="120">&nbsp;${deptvo['deptno'] }</td>
	</tr>
	<tr align="center">
		<td width="80">&nbsp;부서명</td>
		<td width="120">&nbsp;${deptvo['dname'] }</td>
	</tr>
	<tr align="center">
		<td width="80">&nbsp;부서지역</td>
		<td width="120">&nbsp;${deptvo['loc'] }</td>
	</tr>
	<tr align="center">
		<td width="80">&nbsp;부서지역</td>
		<td width="120">&nbsp;${deptvo.loc }</td>
	</tr>
	<tr align="center">
		<td colspan="2">
		<a href="selectProcess.me">사원정보</a></td>
	</tr>
</table>
</body>
</html>