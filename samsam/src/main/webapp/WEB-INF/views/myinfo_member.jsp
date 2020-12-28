<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="com.project.samsam.member.MemberVO"%>
<%
	String email = (String) session.getAttribute("email");

	if ((session.getAttribute("email") == null) || (((String) session.getAttribute("email")).equals("admin"))) {
		out.println("<script>");
		out.println("location.href='loginForm.me'");
		out.println("</script>");
	}
	MemberVO vo = (MemberVO) request.getAttribute("MemberVO");
	System.out.println("vo.getName : " + vo.getName());
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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

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
	$(document).ready(function() {
		$("#check").click(function(event) { //정적데이터는 이벤트 처리를 바로 가능하나 동적이면 on을 사용하여 처리
			var params = $(".content").serialize(); // .serialize() : 주어진 데이터를 키, 밸류 값을 짝지어(직렬화) 가져온다
			console.log(params);
			jQuery.ajax({ // $.ajax 와 동일한 표현
					url : '/samsam/myinfo_update.do',
					type : 'POST',
					data : params, //서버로 보낼 데이터
					/* (참고) 파일 첨부시 필요함
					- cache : false 로 선언시 ajax로통신 중 cache가 남아서 갱신된 데이터를 받아오지 못할 경우를 대비
					- contentType : false 로 선언시 content-Type 헤더가 multipart/form-data로 전송되게 함
					- processData : false로 선언시 formData를 string으로 변환하지 않음
					*/
					dataType : 'json', //서버에서 보내줄 데이터 타입
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(result) {
							if (result.res == "OK") {
								//데이터 성공일때 이벤트 작성
								$('#modal').modal('show');
							} else {
								console.log("업데이트 실패!!");
							}
					},
					error : function() {
							alert("ajax 통신 실패!!!");
					}
			});
			//기본 이벤트 제거
			event.preventDefault();
		});
	});
</script>
<style>
body, html {
	margin: 0;
	font-family: 'Noto Serif KR', serif;
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
	margin-top: 200px;
	width: 550px;
	display: flex;
	flex-direction: column;
}

#check {
	width: 264px;
	height: 48px;
	border: 1px solid skyblue;
	background-color: rgba(0, 0, 0, 0);
	color: skyblue;
	padding: 5px;
	border-radius: 5px;
	align-self: center;
}

#check:hover {
	color: white;
	background-color: skyblue;
}

input {
	font-family: 'Noto Serif KR', serif;
	outline: 0;
	border: 0;
	display: block;
	height: 40px;
	font-size: 1em;
}

.textbox {
	display: block;
	max-height: 60px;
	padding: 20px 8px 4px 8px;
	width: 264px;
	height: 60px;
	position: relative;
	align-self: center;
}

.textbox input:focus {
	border-bottom: solid 2px #bdbdbd;
}
</style>
</head>
<body>
	<div class="body_content">
		<div id="aside">
			<div class="box" style="background: #BDBDBD;">
				<img class="profile"
					src="C:\Users\AIA\Downloads\Telegram Desktop\rabit.jpg">
			</div>
			<div class="name">이름/닉네임</div>
			<nav class="m_menu">
				<ul>
					<li><a href="#">책임분양관리</a></li>
					<li><a href="myinfo_check.me">회원정보</a></li>
					<li><a href="#">작성글관리</a></li>
					<li><a href="myinfo_auth.me">판매허가번호인증</a></li>
				</ul>
			</nav>
		</div>
		<form class="content" method="post">
			<div class="textbox">
				<label>아이디/이메일</label>&nbsp;&nbsp; <input id="email" name="email"
					type="text" readonly value=<%=email%>>
			</div>
			<div class="textbox">
				<label>비밀번호</label>&nbsp;&nbsp;<input id="pw" name="pw"
					type="password" autofocus>
			</div>
			<div class="textbox">
				<label>비밀번호확인</label>&nbsp;&nbsp;<input id="pw2" type="password"
					onchange="isSame();"> <span id=same></span>
			</div>
			<div class="textbox">
				<label>이름</label>&nbsp;&nbsp;<input id="name" name="name"
					type="text" value="<%=vo.getName()%>" readonly>
			</div>
			<div class="textbox">
				<label>닉네임</label>&nbsp;&nbsp;<input id="nick" name="nick"
					type="text" value=<%=vo.getNick()%>>
			</div>
			<div class="textbox">
				<label>휴대폰번호</label>&nbsp;&nbsp;<input id="phone" name="phone"
					type="text" value=<%=vo.getPhone()%>>
			</div>
			<div class="textbox">
				<label>지역</label>&nbsp;&nbsp;<input id="local" name="local"
					type="text" value=<%=vo.getLocal()%>>
			</div>
			<br> <input type="button" id="check" value="회원정보수정">
		</form>
	</div>
	<div class="modal fade" id="modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<!-- header title -->
					<h4 class="modal-title">회원정보가 수정되었습니다.</h4>
				</div>
			</div>
		</div>
	</div>
</body>
</html>