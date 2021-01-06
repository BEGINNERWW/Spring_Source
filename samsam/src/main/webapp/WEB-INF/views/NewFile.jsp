<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<link href="resources/css/admin_sidebar.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>

</head>
<body>
<div class ="body_content">

<header id = "header">
	<div class="d-flex flex-column">
		<div class ="profile">
			<img src = "주소" alt class = "img-fluid rounded-circle">
			<h1 class = "text-light">
				<a href = "#"> ADMIN </a>
			</h1>
			<div class ="admin_inout">
				<button type="button" class ="grade">ADMIN</button>
				<button type="button" class ="grade">LOGOUT</button>
			</div>
						
			<ul class = "nav-menu">
				<li class="active">
					<a href = "#"><i class= "far fa-clipboard menu"></i><span> 게시물관리</span></a>
				</li>
				<li>
					<a href="admin_main.me"><i class = "fas fa-users menu"></i><span> 회원관리</span></a>
				</li>
				<li>
					<a href="admin_pay.me"><i class = "fas fa-ticket-alt menu"></i><span> 이용권관리</span></a>
				</li>
				<li>
					<a href="#"><i class = "fas fa-dog menu"></i><span> 책임분양</span></a>
				</li>
			</ul>

</div>
</header>

<div class = "main_content">

<!-- pageup button -->
<div class ="back-to-top">
<a href="#" style="display: inline;">
	<i class = "fas fa-angle-up"></i>
</a>
</div>
</div>
</div>
</body>
</html>