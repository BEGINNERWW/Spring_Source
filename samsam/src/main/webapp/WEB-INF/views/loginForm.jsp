<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리 시스템 로그인 페이지</title>
	<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
	<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script> <!-- 카카오톡 자바스크립트 라이브러리 -->
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function(){
			//카카오톡 디벨로퍼 api 사이트에서 발급받은 자바스크립트 키
			Kakao.init("4658e426b678bd2dd9ed7731ab1a1868"); // 내어플리케이션 클릭해서 앱 클릭 >> 자바스크립트 키 입력 
			//카카오 로그인 버튼을 생성합니다.
			Kakao.Auth.createLoginButton({ //로그인 버튼 만들어줌
				container : "#kakao-login-btn", //연결자
				success: function(authObj){
					console.log(authObj);
					Kakao.API.request({
						url: '/v2/user/me', //v1/user/me api는 종료
						success: function(res) {
						    console.log(res);
						    
						    
						  	$('.email').val(res.kakao_account.email);
						  	$('.name').val(res.properties.nickname);
						  	console.log("이메일: " + $('.email').val() + "닉네임 : " + $('.name').val() )
						  	
						  	$('#kkoData').submit();
						     
						},
						fail: function(error) {
							 alert(JSON.stringify(error));
						     console.log(error);
						}
					});
				}, //성공
				fail : function(error){
					alert(JSON.stringify(error));
				}
			});//카카오로그인버튼
		});//이벤트리스너 추가
	
		  function kakaoLogout() {
		    if (!Kakao.Auth.getAccessToken()) {
		      alert('Not logged in.')
		      return
		    }
		    Kakao.Auth.logout(function() {
		      alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken())
		    })
		  }
		
	</script>
</head>
<body>
<form name="loginform" action = "login.me" method="post">
<table border = 1 align = center>
	<tr> 
		<td colspan ="2" align = center>
			<b><font size = 5>로그인 페이지</font></b>
		</td>
	</tr>
	<tr><td>아이디 : </td><td><input type="text" name="email"/></td></tr>
	<tr><td>비밀번호 : </td><td><input type="password" name="pw"/></td></tr>
	<tr>
		<td colspan="2" align=center>
			<a href ="javascript:loginform.submit()">로그인</a>&nbsp;&nbsp;
			<a href ="joinform.me">회원가입</a>
		</td></tr>
</table>
</form>
<a id="kakao-login-btn"></a>
<button class="api-btn" onclick="kakaoLogout()">로그아웃</button>

<form id = "kkoData" action = "kkoLogin.me" method= "post">
<input type="hidden" class="email" name = "email" value = "">
<input type="hidden" class="name" name = "nick" value="">
</form>
</body>
</html>
