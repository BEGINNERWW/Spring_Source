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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/img/title.png" rel="shortcut icon" type="image/x-icon">
<title>삼삼하개</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">
<!-- 어드민페이지 -->
<link href="resources/css/admin_sidebar.css" rel="stylesheet" >
<link href="resources/css/admin_add.css" rel="stylesheet" >
<link href="resources/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">

<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
<!-- js -->
<script type="text/javascript" src="resources/js/adminPage.js" charset="UTF-8"></script>
<script type="text/javascript" src="resources/js/admin_member.js" charset="UTF-8"></script>
<script type="text/javascript" src="resources/js/datepicker.js" charset="UTF-8"></script> <!-- Air datepicker js -->
<script type="text/javascript" src="resources/js/datepicker.ko.js" charset="UTF-8"></script> <!-- Air datepicker js -->
<!-- 스윗얼럿 -->
<script src = "https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- 모달 플러그인 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script>
    $("#fromDate").datepicker({
    });
    
    $("#toDate").datepicker({
    }); 

var count = 20;

$(document).on("click", ".before-btn",function(event) {
	if(count > 20){
		count -= 20
		$(".payed").slice(0,count).show();
	}
	else{
		swal("","첫 페이지 입니다.","info")
	}
});

$(document).on("click", ".after-btn",function(event) {
	count += 20
	$(".payed").slice(0,count).show();
	if($(".payed").length <= count){
		console.log($("#result").length)
		swal("","마지막 페이지 입니다.","info")
	}
});
</script>
</head>
<body>
<div class ="body_content">

<header id = "header">
	<div class="d-flex flex-column">
		<div class ="profile">
			<img src = "resources/img/samsam2.png" alt class = "img-circle">
			<h1 class = "text-light">
				<a href = "#" class = "onMember">  <%= email.toUpperCase()%> </a>
			</h1>
		</div>
		<div class ="admin_inout">
			<button type="button" class ="grade">ADMIN</button>
			<button type="button" class ="grade" onclick="location.href='loginForm.me'">LOGOUT</button>
		</div>
						
		<ul>
			<li>
				<a href = "#" class = "nav-menu"><i class= "far fa-clipboard menu"></i><span class="a-menu"> 게시물관리</span></a>
			</li>
			<li>
				<a href="admin_main.me" class = "nav-menu"><i class = "fas fa-users menu"></i><span class="a-menu"> 회원관리</span></a>
			</li>
			<li>
				<a href="admin_pay.me" class = "nav-menu"><i class = "fas fa-ticket-alt menu"></i><span class="a-menu"> 이용권관리</span></a>
			</li>
			<li>
				<a href="#" class = "nav-menu"><i class = "fas fa-dog menu"></i><span class="a-menu"> 책임분양</span></a>
			</li>
		</ul>
</div>
</header>

<div class = "main_content">
<!-- 메인컨텐트 -->
<div class="content">
<form id="content" name="content" action="search_member.do" method="post">
<div class="search">
	<div class = "condition">
	<div class="date">
	일자&nbsp;&nbsp; <input id="fromDate" type="text">&nbsp; - &nbsp; <input id="toDate" type="text">
	</div>
	<div class="member">
	분류
	<div class="label"><label>사업자</label><input type="checkbox" name="member_grade1" value="사업자"></div>&nbsp;&nbsp;
	<div class="label"><label>개인</label><input type="checkbox" name="member_grade2" value="일반"></div>&nbsp;&nbsp;
	<div class="label"><label>대기</label><input type="checkbox"name="member_grade3" value="대기" checked></div>
	</div>
	<div class="keyword">
	검색<input type="text" id= "keyword" name = "keyword" value = "" placeholder
	="아이디/닉네임 을 입력하세요">
	</div> 
	</div>
	<div class = "submit_btn">
	<input type="button" id ="check" value="조회">
	</div>
</div> <!-- search -->
</form>

<table id ="result-table">
<thead>
<tr>
<td>분류</td><td>아이디</td><td>닉네임</td><td>지역</td><td>가입일</td><td>신고횟수</td>
</tr>
</thead>
<tbody id="result">

</tbody>
</table>

</div><!-- content -->
</div><!-- 메인컨텐트 -->

<!-- right-sidebar -->
<div class="right-container">
<!-- 달력 --> 
<widget class="no-drag">
  <table id="calendar">
    <thead>
      <tr height="35px">
        <td><label onclick="prev()" style="color: #ccc;"><</label></td>
        <td colspan="5" id="monthTable"></td>
        <td><label onclick="next()" style="color: #ccc;">></label></td>
      </tr>
      <tr id="dateHead">
        <td>S</td>
        <td>M</td>
        <td>T</td>
        <td>W</td>
        <td>T</td>
        <td>F</td>
        <td>S</td>
      </tr>
    </thead>
    <tbody></tbody>
  </table>
  <script>
    makeArray();
  </script>
</widget>
<!-- 투두리스트 -->
	<!-- 입력 -->
	<div class = "todolist">
      <input type="text" placeholder="Add A Task" class ="txt"> 
    <!-- to do list -->
      <div class="notdone">
        <h3>To Do List</h3>
      </div>
	<!-- done list -->      
      <div class="done">
        <h3>Done</h3>
      </div>
     </div>

<!-- pageup button -->
<div class ="back-to-top">
<a href="#" class ="back-to-top" style="display: inline;">
	<i class = "fas fa-angle-up"></i>
</a>
</div>
</div><!-- right-sidebar -->
</div><!-- 바디컨텐트 -->

<!-- 모달 -->
<form id= "detail-form" class="modal">
<div class = "modal-member">
	<h3>회원정보</h3>
	<div class = "modal_tab">
		<div class = "modal-group">
		<label class ="modal-label">아이디</label><input class="modal-detail" type="text" id = "email" readonly>
		</div>
		<div class = "modal-group">
		<label class ="modal-label">닉네임</label><input class="modal-detail" type="text" id = "nick" readonly>
		</div>
		<div class = "modal-group">
		<label class ="modal-label">전화번호</label><input class="modal-detail" type="text" id = "phone" readonly>
		</div>
		<div class = "modal-group">
		<label class ="modal-label">주소</label><input class="modal-detail" type="text" id = "local" readonly>
		</div>
		<div class = "modal-group">
		<label class ="modal-label">분류</label><input class="modal-detail" type="text" id = "grade" readonly>
		</div>
		<div class = "modal-group">
		<label class ="modal-label">신고횟수</label><input class="modal-detail" type="text" id = "wcount" readonly>
		</div>
	</div>
	<div class = "auth">
		<h3>판매허가내역확인</h3>

		<table class = "auth_detail-table">
			<tr class ="modal-ad-table-row">
				<td class ="ad-table-cell">사업장명</td>
				<td class ="ad-table-cell" id = "biz_com"></td>
				<td rowspan = "3">
					<div class="modal-auth_status">
						<input type="text" class = "status" value ="미확인" readonly>
						<fieldset class = "modal-fieldset" id ="btn_fieldset">
							<button class ="auth_confirm">완료</button> <button class="auth_return">반려</button>
						</fieldset>
					</div>
				</td>
			</tr>
			<tr class ="ad-table-row">
				<td class ="ad-table-cell">관리번호</td>
				<td class ="ad-table-cell" id = "biz_no"></td>
			</tr>
			<tr class ="ad-table-row">
				<td class ="ad-table-cell">허가증</td>
				<td class ="ad-table-cell" id = "biz_img"></td>
			</tr>
		</table>
		
		<div class ="warning">
			<h3>신고목록</h3>
			<table class="table">
			<tr><td>번호</td><td>신고내용</td>
			</table>
			<table class="w-table">
			
			</table>
		</div>
		<div class ="boardlist">
			<h3>최근게시글</h3>
			<table class="table">
			<tr><td>번호</td><td>제목</td><td>작성일</td>
			</table>
			<table class="b-table">
			
			</table>
		</div>
		<div class ="commentlist">
			<h3>최근댓글</h3>
			<table class="table">
			<tr><td>내용</td><td>작성일</td>
			</table>
			<table class="c-table">
			
			</table>
		</div>
	</div>
</div>
</form>
</body>
</html>