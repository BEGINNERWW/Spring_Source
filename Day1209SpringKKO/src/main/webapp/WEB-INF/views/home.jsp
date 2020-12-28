<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset ="utf-8" http-equiv = "X-UA-Compatible" content="IE=ege"/>
<!-- 반응형 웹 관련 작업 -->
<meta name ="viewport" content = "user-scalable=no, inital-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
	<title>KaKao JavaScript SDK</title>
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
						     //개발자 페이지에서 해당 앱의 제품설정 >> 카카오 로그인을 on으로 하고 
						     //제품설정 >> 동의항목에서 개인정보 보호항목에서 프로필 정보 설정에서 필수동의로 설정한다.
						     //아이디
						     document.getElementById("kakaoIdentity").innerHTML = res.id;
						     //카카오톡 계정
						     document.getElementById("kakaoAccount").innerHTML = res.kakao_account;
						     //닉네임
						     document.getElementById("kakaoEmail").innerHTML = res.email;
						     //이메일
						     document.getElementById("kakaoNickName").innerHTML = res.properties.nickname;
						     //프로필 이미지
						     document.getElementById("kakaoProfileImg").src = res.properties.profile_image;
						     //썸네일 이미지
						     document.getElementById("kakaoThumbnailImg").src = res.properties.thumbnail_image;
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

<div> 카카오 아이디 : <span id="kakaoIdentity"></span></div> 
<div> 카카오 계정 : <span id="kakaoAccount"></span></div> 
<div> 이메일 : <span id="kakaoEmail"></span></div>
<div> 닉네임 : <span id="kakaoNickName"></span></div>
<div> 프로필 이미지 : <img id="kakaoProfileImg"></img></div>
<div> 썸네일 이미지 : <img id="kakaoThumbnailImg"></img></div>
<br/>
<a id="kakao-login-btn"></a>
<button class="api-btn" onclick="kakaoLogout()">로그아웃</button>
</body>
</html>
