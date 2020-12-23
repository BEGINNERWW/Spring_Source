<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 가입</title>

<!--<link href="./resources/css/register.css" rel="stylesheet" type="text/css">-->
<link href="${pageContext.request.contextPath }/resources/css/register.css" rel="stylesheet" type="text/css">

</head>
<body>
<form>
<fieldset>
<legend>회원 기본 정보</legend>
<ol>
  <li>
    <label for="userid">아이디</label>
    <input type="text" id="userid" name="userid" required autofocus 
			placeholder="영문,숫자 사용. 10자미만">
  </li>
  <li>
    <label for="pwd1">비밀번호</label>
    <input type="password" id="pwd1" name="pwd1" required 
			placeholder="영문,숫자 사용. 6~10자리">
  </li>
  <li>
    <label for="pwd2">비밀번호 확인</label>
    <input type="password" id="pwd2" name="pwd2" required>
  </li> 
	
	<li>
    <label for="fullname">이름</label>
    <input type="text" id="fullname" name="fullname"  required>
  </li>
	<li>		<label for="age">나이</label>
    <input id="age" name="age" type="number" min="1" max="65" step="1">
  </li> 
	<li>
		<label for="birth">생일</label>
    <input id="birth" name="birth" type="date">
  </li> 
  <li>
    <label for="email">이메일 주소</label>
    <input id="email" name="email" type="email" autocomplete="off" 
			placeholder="zoca01@icore.com" required >
  </li>
  <li>
    <label for="tel">핸드폰</label>
    <input id="tel" name="tel" type="tel" autocomplete="off">
  </li>
</ol>
</fieldset>

<fieldset>
<legend>회원 추가 정보</legend>
<ol>
 <li>
    <label for="job">직업</label>
    <input list="job" name="job" >
		<datalist id="job">
			<option value="회사원">
			<option value="교사">
			<option value="프로그래머">
			<option value="자영업">
			<option value="기타">
		</datalist>
  </li>
  <li>
		<label for="office">오피스 활용</label>
    <input id="office" name="com" type="range" min="1" max="5" step="1">
  </li>  
</ol>
</fieldset>
<fieldset>
  <button type="submit"> 입력 </button> 
</fieldset>
</form>
</body>
</html>
