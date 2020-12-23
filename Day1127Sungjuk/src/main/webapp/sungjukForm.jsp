<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>성적입력 페이지</title>
</head>
<body>
<form name = "sungjukform" action = "sungjukprocess.me" method ="post">
<center>
<table border= 1>
	<tr>
		<td colspan="2" align=center>
			<b><font size=5>성적입력 페이지</font></b>
		</td>
	</tr>
	<tr><td>학번 : </td><td><input type="text" name= "hakbun"/></td></tr>
	<tr><td>이름 : </td><td><input type="text" name= "name"/></td></tr>
	<tr><td>국어 : </td><td><input type="text" name= "kor" maxlength =3 /></td></tr>
	<tr><td>영어 : </td><td><input type="text" name= "eng" maxlength =3 /></td></tr>
	<tr><td>수학 : </td><td><input type="text" name= "math" maxlength =3 /></td></tr>
</table><br>
<div align="center">
		<input type="submit" value="성적입력">&nbsp;&nbsp;
		<input type="reset" value="다시작성">&nbsp;&nbsp;
		<input type="button" value="리스트" onclick="location.href='sungjuklist.me'">
</div>
</center>
</form>
</body>
</html>