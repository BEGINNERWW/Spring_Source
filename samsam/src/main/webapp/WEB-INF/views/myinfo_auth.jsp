<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
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
$(document).ready(function(){
	   var fileTarget = $('.textbox .upload-hidden');

	    fileTarget.on('change', function(){
	        if(window.FileReader){
	            // 파일명 추출
	            var filename = $(this)[0].files[0].name;
	        } 

	        else {
	            // Old IE 파일명 추출
	            var filename = $(this).val().split('/').pop().split('\\').pop();
	        };

	        $(this).siblings('.upload-name').val(filename);
	    });
	});
	
$(document).ready(function() {
	$(".check").click(function(event) { //정적데이터는 이벤트 처리를 바로 가능하나 동적이면 on을 사용하여 처리
		var biz_no = $('#biz_no').val();
		var biz_com= $('#biz_com').val();
		console.log($('#biz_no').val());
		jQuery.ajax({ // $.ajax 와 동일한 표현
				url : '/samsam/biz_check.do',
				type : 'POST',
				data : {"biz_no" : biz_no,
					"biz_com" : biz_com }, //서버로 보낼 데이터
				/* (참고) 파일 첨부시 필요함
				- cache : false 로 선언시 ajax로통신 중 cache가 남아서 갱신된 데이터를 받아오지 못할 경우를 대비
				- contentType : false 로 선언시 content-Type 헤더가 multipart/form-data로 전송되게 함
				- processData : false로 선언시 formData를 string으로 변환하지 않음
				*/
				dataType : 'json', //서버에서 보내줄 데이터 타입
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(result) {
					    $('.error').text("")
						if(result.res == "OK"){}
						if (result.res == "dont") {
							//데이터 성공일때 이벤트 작성
							$('#modal').modal('show');
						} else {
							console.log("업데이트 실패!!");
							$('.error').text("관리번호를 다시 확인해주세요")
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

.textbox {
	display: block;
	max-height: 60px;
	margin: 0;
	padding: 20px 8px 4px 8px;
	width: 500px;
	height: 60px;
	position: relative;
	align-self: center;
}

input {
	font-family: 'Noto Serif KR', serif;
	outline: 0;
	border: 0;
	margin: 20px;
	display: block;
	width: 270px;
	height: 25px;
	font-size: 1em;
}

.auth {
	align-self: center;
	margin-right: 80px;
	height: 43px;
	border: 1px solid skyblue;
	background-color: rgba(0, 0, 0, 0);
	color: skyblue;
	padding: 5px;
	border-radius: 5px;
	align-self: center;
}

.auth:hover {
	color: white;
	background-color: skyblue;
}

.textbox input:focus {
	border-bottom: solid 2px #bdbdbd;
}

.textbox {
	display: flex;
	align-items: center;
}

.textbox input[type="button"] {
	display: inline-block;
	padding: .5em .75em;
	width: 57px;
	height: 41px;
	margin: 0px;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

.textbox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.textbox[name="button_1"] label[for="biz_img"] {
	display: inline-block;
	padding: .5em .15em;
	width: 50px;
	height: 28px;
	color: #999;
	font-size: inherit;
	text-align: center;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}
/* named upload */
.textbox .upload-name {
	display: inline-block;
	padding: .5em .15em; /* label의 패딩값과 일치 */
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	appearance: none;
}

h6 {
	padding-left: 110px;
}
.error{
font-size: 0.8em;
color : red;
padding-left: 110px;

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
		<form class="content" method="post" enctype="multipart/form-data">
			<div class="textbox">
				<label>사업장명</label><input id="biz_com" name="biz_com" type="text">
			</div>
			<div class="textbox" name="button_1">
				<label>관리번호</label> <input id="biz_no" name="biz_no" type="text">
				<input type="button" class="check" value="확인">
			</div>
				<div class="error">
  				</div>
			<div class="textbox preview-image" name="button_1">
				<label>허가증</label>&nbsp;&nbsp;&nbsp; <input class="upload-name"
					name="biz_img" value="파일선택" disabled="disabled">
				<label for="ex_filename">첨부</label> <input type="file"	id="biz_img" name="biz_img" class="upload-hidden">
			</div>
			<input class="auth" type="button" value="인증하기" onclick="">
			<h6>*인증완료까지 최대 3영업일이 소요될수 있습니다.</h6>
		</form>
	</div>
	<div class="modal fade" id="modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<!-- header title -->
					<h4 class="modal-title">사업장명 또는 관리번호가 일치하지 않습니다.</h4>
				</div>
			</div>
		</div>
	</div>
</body>
</html>