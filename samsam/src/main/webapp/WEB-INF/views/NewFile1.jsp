<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	String email = (String) session.getAttribute("email");
	//email.toUpperCase();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">
<!-- 메인페이지 -->
<link href="resources/css/main.css" rel="stylesheet">
<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
<script src="resources/js/mainPage.js"></script>
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
	<div class="header-top">
		<img src = "resources/img/banner_3.PNG" alt class = "img-circle">
	</div>
	<div class ="nav-menu">
	<ul class = "sticky-wrapper">
		<li><a href ="#">HOME</a></li>
		<li><a href ="#">분양</a></li>
		<li><a href ="#">보호소</a></li>
		<li><a href ="#">커뮤니티</a></li>
	</ul>
	<div class= "search-wrapper">
      <input class="search-box input" type="text" placeholder="Search">
      <button class="search-box btn" type="button"><i class="fas fa-search"></i></button>
	</div>
	</div><!-- nav-menu -->
</header>
<div class = "main-content">

</div>

<footer id="footer">
<p>Copyright ©2021 All rights reserved | This template is made with <i class="fas fa-heart"></i> by SamSam

</footer>
</div> <!-- 바디컨텐트 -->
</body>
</html>