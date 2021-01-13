<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.project.samsam.member.MemberVO"%>

<%
	String email = (String) session.getAttribute("email");
	//email.toUpperCase();
	if ((session.getAttribute("email") == null) || (((String) session.getAttribute("email")).equals("admin"))) {
		out.println("<script>");
		out.println("location.href='loginForm.me'");
		out.println("</script>");
	}
	MemberVO vo = (MemberVO) request.getAttribute("MemberVO");
	System.out.println("vo.getName : " + vo.getName());
	
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/img/title.png" rel="shortcut icon" type="image/x-icon">
<title>삼삼하개</title>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">
<!-- 마이페이지/업체페이지 -->
<link href="resources/css/my_com.css" rel="stylesheet" >
<link href="resources/css/my_member.css" rel="stylesheet" >

<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
<script type="text/javascript" src="resources/js/myinfo_member.js" charset="UTF-8"></script> 
<!-- 스윗얼럿 -->
<script src = "https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

</head>
<body>
<div class ="body_content">
<header id = "header">

	<div class ="inout_gocen">
			<input type="button" class= "header_btn" id="login" value="로그인">
			<input type="button" class= "header_btn" id="logout" value="로그아웃">
			<input type="button" class= "header_btn" id="signin" value="회원가입">
			<input type="button" class= "header_btn" id="mypage" value="마이페이지">
			<input type="button" class= "header_btn" id="gocen" value="고객센터">
		</div>
	
	<div class="nav-menu">
				<ul class="sticky-wrapper">
					<li class="dropdown"><a href="main.me">HOME</a></li>
					<li class="dropdown"><a href="board.me">분양</a>
						<ul class="dropdown-menu">
							<li><a href="#">&nbsp;&nbsp;가정분양</a></li>
							<li><a href="#">책임분양</a></li>
							<li><a href="#">업체분양</a></li>
						</ul></li>
					<li class="dropdown"><a href="care.me">보호소</a>
						<ul class="dropdown-menu">
							<li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;보호소</a></li>
							<li><a href="#">파양</a></li>
							<li><a href="#">실종</a></li>
						</ul></li>
					<li class="dropdown"><a href="community.me">커뮤니티</a>
						<ul class="dropdown-menu">
							<li><a href="#">&nbsp;자유게시판</a></li>
							<li><a href="#">책임분양인증</a></li>
						</ul></li>
				</ul>
	
	<div class="header-top">
		<div class="mainlogo">
		<a href="#">
		<img src = "resources/img/mainlogo.png" class = "mainlogo">
		</a>
		</div>
	</div>
	<div class= "search-wrapper">
      <input class="search-box input" type="text" placeholder="Search">
      <button class="search-box btn" type="button"><i class="fas fa-search"></i></button>
	</div>
	</div><!-- nav-menu -->
</header>
		
		<div class="main-content">
			<div class="content-wrap">
			
			<!-- 왼쪽. 서브메뉴가 들어갈 부분 -->
			<div class="sidemenu-section">
			<div class ="profile">
			<img src = "resources/img/samsam2.png" alt class = "img-circle">
			<h2 class = "text-light">
				<a href = "#" class = "onMember">  <%= vo.getNick()%> </a>
			</h2>
			</div>
			<nav class="m_menu">
				<li class = "list-group-item"><a href="#">책임분양관리</a></li>
				<li class = "list-group-item click"><a href="myinfo_check.me">회원정보</a></li>
				<li class = "list-group-item"><a href="#">작성글관리</a></li>
				<li class = "list-group-item"><a href="myinfo_auth.me">판매허가번호인증</a></li>
			</nav>
			</div>
			
			<!-- 오른쪽. 내용이 들어갈 부분 -->
<div class="content-section">
	<h2 class ="font"> 회원정보 > 회원정보수정</h2>
	<form class="content" method="post">
		<div class="textbox">
			<label>아이디/이메일</label>&nbsp;&nbsp; 
			<input id="email" name="email"	type="text" readonly value=<%=email%>>
		</div>
		<div class="textbox">
			<label>비밀번호</label>&nbsp;&nbsp;
			<input id="pw" name="pw" type="password" autofocus>
		</div>
		<div class="textbox">
			<label>비밀번호확인</label>&nbsp;&nbsp;
			<input id="pw2" type="password" onchange="isSame();"> 
		</div>
		<span id=same></span>
		<div class="textbox">
			<label>이름</label>&nbsp;&nbsp;
			<input id="name" name="name" type="text" value="<%=vo.getName()%>" readonly>
		</div>
		<div class="textbox">
			<label>닉네임</label>&nbsp;&nbsp;
			<input id="nick" name="nick" type="text" value=<%=vo.getNick()%>>
		</div>
		<div class="textbox">
			<label>휴대폰번호</label>&nbsp;&nbsp;
			<input id="phone" name="phone" type="text" value=<%=vo.getPhone()%>>
		</div>
		<div class="textbox">
			<label>지역</label>&nbsp;&nbsp;
			<input id="local" name="local" type="text" value=<%=vo.getLocal()%>>
		</div>
		<br> <input type="button" id="check" value="회원정보수정">
		</form>
	</div>
		</div>
		</div>

	<!-- 카카오톡 채널 상담 -->
	<div class="kakaoChat">
	<a href="javascript:void plusFriendChat()">
    <img src="resources/img/kakaolink_btn_medium.png" width="45px" height="45px" class="kakao_btn">
	</a>
	</div>
	
	<!-- pageup button -->
	<div class ="back-to-top">
	<a href="#" class ="back-to-top" style="display: inline;">
	<i class = "fas fa-angle-up"></i>
	</a>
	</div>
	
</div><!-- 바디컨텐트 -->
	
		
<footer id="footer">
<p>Copyright ©2021 All rights reserved | This template is made with <i class="fas fa-heart"></i> by SamSam

</footer>



<script>
$(document).ready(function(){
	$('#login').on('click', function(e){
	      $('#logout').show();
		  $('#mypage').show();
		  $('#login').hide();
		  $('#signin').hide();
	  });
	}) //헤더 상단 로그인 체인지

	$(document).ready(function(){
	$('#logout').on('click', function(e){
	       $('#logout').hide();
		   $('#mypage').hide();
		   $('#login').show();
		   $('#signin').show();
		});
	}) //헤더 상단 로그아웃 체인지
</script>

<!-- 카카오톡 채널 상담 js -->
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('be685f4c6119a7e447cd31c67878faf1');
    // 카카오톡 채널 1:1채팅 버튼을 생성합니다.
    function plusFriendChat() {
        Kakao.Channel.chat({
              channelPublicId: '_cjxmxiK' // 카카오톡채널 홈 URL에 명시된 홈ID
        });
    }
    
  //]]>
</script>

</body>
</html>