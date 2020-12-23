<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--  
<script language ="javascript" src = "./resources/js/form_input.js" >
-->
<script language ="javascript" src = "${pageContext.request.contextPath}/resources/js/form_input.js" >
</script>
</head>
<body>
<form name="input_form" action="input_form.me" method="post" onsubmit="return check_input();">
<!-- <form name ="input_form" action ="input_form.jsp" method="post" onsubmit="return check_input();">  -->
<!--  <form name="input_form" action="input_form.jsp" mecontextPaththod="port"> -->
<table align ="center" border ="1">
<tr>
	<td width="110"> 아이디 </td>
	<td width="400">
		<input type ="text" name ="id" size ="30" style="ime-mode:inactive"
		placeholder="최소6~최대10, 숫자와알파벳만 사용">
		</td>
</tr>
<tr>
	<td width="110"> 비밀번호 </td>
	<td width="400">
		<input type ="password" name ="pw" size ="30" style="ime-mode:inactive"
		placeholder="최소6~최대10, 숫자와알파벳만 사용">
		</td>
</tr>
<tr>
	<td width="110"> 비밀번호 확인 </td>
	<td width="400">
		<input type ="password" name ="pw2" size ="30" style="ime-mode:inactive"
		placeholder="최소6~최대10, 숫자와알파벳만 사용">
		</td>
</tr>
<tr>
	<td width="110"> 주민번호 </td>
	<td width="400">
		<input type ="text" name ="jumin1" size ="6"  maxlength="6"> - 
		<input type ="text" name ="jumin2" size ="7"  maxlength="7" onblur="set_gender();"> 
		</td>
</tr>
<tr>
	<td width="110"> 성별 </td>
	<td width="400">
		<input type ="radio" name ="gender" value= "남자"> 남자 
		<input type ="radio" name ="gender" value= "여자"> 여자
		</td>
</tr>
<tr>
	<td > 전화번호 </td>
	<td >
		<input type ="tel" name ="tel1" size="3" maxlength="3"> - 
		<input type ="tel" name ="tel2" size="4" maxlength="4"> - 
		<input type ="tel" name ="tel3" size="4" maxlength="4">  
	</td>
</tr>
<tr>
	<td width="110"> 이메일 </td>
	<td width="400">
		<input type ="text" name ="email1" size="10" style="ime-mode:inactive"> @ 
		<select name="email2">
			<option value="">메일주소선택
			<option value="hanmail.net">hanmail.net
			<option value="naver.com">naver.com
			<option value="nate.com">nate.com
		</select>
	</td>
</tr>
<tr>
	<td width="110"> 취미 </td>
	<td width="400">
		<input type="checkbox" name="hobby" value="등산"> 등산
		<input type="checkbox" name="hobby" value="독서"> 독서
		<input type="checkbox" name="hobby" value="스키"> 스키
		<input type="checkbox" name="hobby" value="음악"> 음악
		<input type="checkbox" name="hobby" value="영화"> 영화
	</td>
</tr>
<tr>
	<td width="110"> 자기소개 </td>
	<td width="400"><textarea name ="intro" rows="5" cols="50" style="ime-mode:active"></textarea></td>
</tr>
<tr>
	<td colspan="2" align="center" width="500">
		 <input type="submit" value="입력"> 
	<!--	<input type="button" value="입력" onclick="check_input();">-->
		<input type="reset" name="reset" value="취소">
	</td>
</tr>
</table>
</form>
</body>
</html>