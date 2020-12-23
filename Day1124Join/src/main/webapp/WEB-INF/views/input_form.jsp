<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<table align="center" border="1">
	<tr>
		<td width="110"> 아이디 </td>
		<td width="400">
			${id }
		</td>
	</tr>
	<tr>
		<td width="110"> 비밀번호 </td>
		<td width="400">
			${pw }
		</td>
	</tr>	
	<tr>
		<td width="110"> 주민번호 </td>
		<td width="400">
			${jumin1 } - ${jumin2 }
		</td>
	</tr>	
	<tr>
		<td width="110"> 성별 </td>
		<td width="400">
			${gender }
		</td>
	</tr>
	<tr>
		<td width="110"> 이메일 </td>
		<td width="400">
			${email1 } @ ${email2 }
		</td>
	</tr>
	<tr>
		<td width="110"> 취미 </td>
		<td width="400">
			${hobby }
		</td>
	</tr>
	<tr>
		<td width="110"> 자기소개 </td>
		<td width="400">
			${intro }
		</td>
	</tr>
</table>
</body>
</html>