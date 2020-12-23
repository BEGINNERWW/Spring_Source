<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import= "java.util.ArrayList" %>
<%@ page import="com.spring.day1125.EmpDeptVO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<table border="1" align="center">
	<tr>
		<th width="80">EMPNO</th>
		<th width="80">ENAME</th>
		<th width="80">JOB</th>
		<th width="80">DEPTNO</th>
		<th width="80">DNAME</th>
		<th width="100">LOC</th>
	</tr>
<%
ArrayList<EmpDeptVO> list = (ArrayList<EmpDeptVO>)request.getAttribute("list");
for(int i=0; i<list.size(); i++){
	EmpDeptVO edvo = (EmpDeptVO)list.get(i);
%>
	<tr>
		<td>&nbsp;<%=edvo.getEmpno() %></td>
		<td>&nbsp;<%=edvo.getEname() %></td>
		<td>&nbsp;<%=edvo.getJob() %></td>
		<td>&nbsp;<%=edvo.getDeptno() %></td>
		<td>&nbsp;<%=edvo.getDname() %></td>
		<td>&nbsp;<%=edvo.getLoc() %></td>
	</tr>
	<%
}
	%>
	<tr align="center">
		<td colspan="6"><a href="index.jsp">처음으로</a></td>
	</tr>
</table>
</body>
</html>