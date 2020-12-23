<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<form action="inputProcess.me" method="post">
	<table align="center">
		<tr>
			<td>EMPNO</td>
			<td><input type="text" name="empno" size="10" maxlength="10"></td>
		</tr>
		<tr>
			<td>ENAME</td>
			<td><input type="text" name="ename" size="10" maxlength="10"></td>
		</tr>
		<tr>
			<td>JOB</td>
			<td><input type="text" name="job" size="10" maxlength="10"></td>
		</tr>
		<tr>
			<td>MGR</td>
			<td><input type="text" name="mgr" size="10" maxlength="10"></td>
		</tr>
		<tr>
			<td>SAL</td>
			<td><input type="text" name="sal" size="10" maxlength="10"></td>
		</tr>
		<tr>
			<td>COMM</td>
			<td><input type="text" name="comm" size="10" maxlength="10"></td>
		</tr>
		<tr>
			<td>DEPTNO</td>
			<td><input type="text" name="deptno" size="10" maxlength="10"></td>
		</tr>
		<tr align ="center">
			<td colspan="2">
				<input type="submit" value="입력">
				<input type="reset" value="취소">
			</td>
		</tr>
	</table>
</form>
</body>
</html>