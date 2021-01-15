<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String email = (String)session.getAttribute("email");
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.0.js"></script>


<script>
	$(".textbox input").attr("value", "");
	$(".textbox input").attr("onkeyup",
			"this.setAttribute('value', this.value);");

	function isSame() {
		console.log("pw:" + $('#pw').val() + "pw2:" + $('#pw2').val())
		if ($('#pw').val() != '' && $('#pw2').val() != '') {
			if ($('#pw').val() == $('#pw2').val()) {
				$('#same').html('비밀번호가 일치합니다.');
				$('#same').css("color", "blue");
			} else {
				$('#same').html('비밀번호가  일치하지 않습니다');
				$('#same').css("color", "red");
			}
		}
	}
</script>
<style>
body, html {
	margin: 0;
	font-family: 'Noto Serif KR', serif;
}
#same {
  font-size: 0.8em;
}
.body_content {
	margin: 0;
	height: 100vh;
	display: flex;
	justify-content: center;
}

#aside {
	width: 250px;
	flex-direction: column;
	justify-content: space-around;
}

.box .name .m_menu {
	align-self: auto;
}

.name {
	margin-right: 50px;
	padding: 0;
	text-align: center;
}

.box {
	margin: 30px;
	padding: 0;
	width: 150px;
	height: 150px;
	border-radius: 70%;
	overflow: hidden;
}

.profile {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

ul {
	padding: 0;
	margin-top: 30px;
}

li {
	width: 100%;
	height: 48px;
	list-style-type: none;
	display: flex;
	justify-content: flex-start;
}

a {
	color: black;
	text-decoration: none;
}

.content {
	margin-top: 250px;
	width: 550px;
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
}

#check {
	width: 264px;
	height: 48px;
	border: 1px solid skyblue;
	background-color: rgba(0, 0, 0, 0);
	color: skyblue;
	margin-right: 105px;
	padding: 5px;
	border-radius: 5px;
	align-self: center;
}

#check:hover {
	color: white;
	background-color: skyblue;
}

.textbox {
	display: flex;
	flex-direction: column;
	align-items: left;
	max-height: 60px;
	margin-left: 80px;
	padding: 10px 8px 4px 8px;
	width: 500px;
	height: 100px;
	position: relative;
}

input {
	font-family: 'Noto Serif KR', serif;
	outline: 0;
	border: 1px solid #eeeeee;
	border-radius: 5px;
	margin-top: 10px;
	display: block;
	width: 270px;
	height: 40px;
	font-size: 1em;
}
</style>
</head>
<body>
	<div class="body_content">
		<div id="aside">
			<div class="box" style="background: #BDBDBD;">
				<img class="profile" src="C:\Project\upload\rabit.jpg">
			</div>
			<div class="name">이름/닉네임</div>
			<nav class="m_menu">
				<ul>
					<li><a href="#">책임분양관리</a></li>
					<li><a href="#">회원정보</a></li>
					<li><a href="#">작성글관리</a></li>
					<li><a href="#">판매허가번호인증</a></li>
				</ul>
			</nav>
		</div>
		<form action="pw_new.me" method="POST" class="content">
			<div class="textbox">
				<label>새비밀번호</label> <input id="pw" name="pw" type="password">
			</div>
			<div class="textbox">
				<label>새비밀번호 확인</label> <input id="pw2" type="password"
					onchange="isSame();"><span id=same></span>
			</div>
			<br><br>
			<input type="submit" id="check" value="비밀번호변경">
			<input type="hidden" name="email" value=<%=email %>>
		</form>
	</div>
</body>
</html>