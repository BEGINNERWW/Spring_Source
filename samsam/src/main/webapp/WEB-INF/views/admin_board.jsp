<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.project.samsam.member.MemberVO"%>

<% 
String email = (String) session.getAttribute("email");
System.out.println("session email :" +session.getAttribute("email"));

if (session.getAttribute("email") == null && session.getAttribute("email") != "admin"){
	out.println("<script>");
	out.println("location.href='loginForm.me'");
	out.println("</script>");
}


HashMap<Object, Object> map = (HashMap<Object, Object>)request.getAttribute("map");


//	클래스 변수이름 = (클래스)request.getAttribute("모델로 저장한 이름");
//	int b_no = 변수이름.getB_no();

	//email.toUpperCase();
	//<%= email.toUpperCase() 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="resources/img/title.png" rel="shortcut icon" type="image/x-icon">
<title>삼삼하개</title>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">
<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
<!-- 어드민페이지 -->
<link href="resources/css/admin_sidebar.css" rel="stylesheet">
<link href="resources/css/admin_add2.css" rel="stylesheet" >
<script type="text/javascript" src="resources/js/adminPage.js" charset="UTF-8"></script>


<!-- 달력 -->
<link href="resources/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<script type="text/javascript" src="resources/js/datepicker.js" charset="UTF-8"></script> <!-- Air datepicker js -->
<script type="text/javascript" src="resources/js/datepicker.ko.js" charset="UTF-8"></script> <!-- Air datepicker js -->
<!-- 스윗얼럿 -->
<script src = "https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>

ul{
	list-style: none;
}
</style>
<script>
$("#fromDate").datepicker({
});

$("#toDate").datepicker({
});
</script>
<script type="text/javascript">

function btn_disable()  {
	  const find_data = document.getElementById('find_data');
	  if($('.category').val() == '' || $('.category').val() == null ){
		  find_data.disabled = true;
		  console.log("카테고리"+ $('.category').val() )
	  }
	  else{
		  find_data.disabled = false;
	  }
}//btn_disable 끝 

$(document).ready(function(){
	
	btn_disable();
		//검색 시작
		$("#find_data").click(function(event) {
			
			var startDate = $('#fromDate').val();
			var endDate = $('#toDate').val();
			
			console.log(startDate);
			console.log(endDate);
			console.log($('.category').val());
			
			var params = $('#find_form').serialize(); //단순 확인용
			var kind_str = $('[name=kind]:checked').val();
		
			var data = {
				"startDate" : startDate,
				"endDate" : endDate,
				"keyword" : $('#keyword').val(),
				"category" : $('.category').val(),
				"kind" :  kind_str
						}
			
			console.log("params :"+params)
			console.log("kind_str : "+kind_str);
			console.log("date :" + data)
		
			if ( kind_str != "writing") {  //신고

				console.log("엘스")
				$.ajax({url : '/samsam/boardWFind.do', //게시글 신고
							type : 'POST',
							data : JSON.stringify(data),
							contentType : 'application/json;charset=utf-8',
							dataType : 'json',

							success : function(list) {
								console.log("신고")
								$('#output').empty();
								$('.tb-bottom').empty();

								var b_count = 0
								$.each(list,function(index,item) {
									
									var category = $('.category').val();
									console.log("에이젝스 카테고리 : " +$('.category').val())
									var output = '';
									output += '<tr class ="wc_board">';
									output += '<td>'+ item.doc_no+ '</td>';
									output += '<td>'+ item.doc_subject+'</td>';
									output += '<td>'+ item.doc_nick+ '</td>';
									output += '<td>'+ item.doc_date+ '</td>';
									output += '<td>'+ item.doc_readcount+ '</td>';
									output += '<td><button type="button" id="location_open_btn" number='+item.doc_no+' category='+category+' onclick="location_change(this);"  value="상세보기">상세보기</button></td>';
									output += '</tr>';
									console.log("output:"+ output);
									$('#output').append(output);
									
									b_count += 1
									
								});
							
								$(".wc_board").slice(2).hide();

								console.log("글갯수 : " + b_count)
								var app = "<div class='tb-bottom'><input type='button' class ='before-btn' value = '이전'>" + "<span class='pagenum'></span><input type='button' class = 'after-btn' value = '다음'></div>"
								$("#result-table").after(app);
								var page = 0
								var b = 0;
								for(var i = 1; i <= b_count ; i++){
									console.log("반복문")
									b += i;
									if(b%2 == 0){
										page += 1	
										console.log("page수 :" + page)
										$('.pagenum').html($('.pagenum').html()+'<a class ="pageA" href="javascript:void(0);" onclick="page_detail(this);" value = "'+ page +'">'+ page + '</a>')
									}else if(b <= 2){
										page += 1	
										console.log("page값 :" + $('.pagenum').val())

										$('.pagenum').html($('.pagenum').html()+'<a class ="pageA" href="javascript:void(0);" onclick="page_detail(this);" value = "'+ page +'">'+ page + '</a>')
									}
								}
								sessionStorage.setItem("pagenum", 1);
								console.log("세션"+ sessionStorage.getItem("pagenum"))
							},
							error : function(request, error) {

								alert("fail");

								// error 발생 이유를 알려준다.

							alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

							}

						});
				event.preventDefault();
			} else {  //게시글
				
				$.ajax({
					url : '/samsam/boardFind.do',
					type : 'POST',
					data : JSON.stringify(data),
					contentType : 'application/json;charset=utf-8',
					dataType : 'json',

					success : function(list) {
						console.log("게시글")
						$('#output').empty();
						$('.tb-bottom').empty();

						var b_count = 0

					$.each(list,function(index, item){
						var category = $('.category').val();
					
							var output = '';
							output += '<tr class ="wc_board">';
							output += '<td>'+ item.doc_no+ '</td>';
							output += '<a href="#"><td>'+ item.doc_subject+'</td></a>';
							output += '<td>'+ item.doc_nick+ '</td>';
							output += '<td>'+ item.doc_date+ '</td>';
							output += '<td>'+ item.doc_readcount+ '</td>';
							output += '<td><button type="button" id="location_open_btn" number='+item.doc_no+' category='+category+' onclick="location_change(this);"  value="상세보기">상세보기</button></td>';
							output += '</tr>';
							console.log("output:"+ output);
							$('#output').append(output);
							b_count += 1

					});  //		each
					$(".wc_board").slice(10).hide();

					console.log("글갯수 : " + b_count)
					var app = "<div class='tb-bottom'><input type='button' class ='before-btn' value = '이전'>" + "<span class='pagenum'></span><input type='button' class = 'after-btn' value = '다음'></div>"
					$("#result-table").after(app);
					var page = 0
					var b = 0;
					for(var i = 1; i <= b_count ; i++){
						console.log("반복문")
						b += i;
						if(b%2 == 0){
							page += 1	
							console.log("page수 :" + page)
							$('.pagenum').html($('.pagenum').html()+'<a class ="pageA" href="javascript:void(0);" onclick="page_detail(this);" value = "'+ page +'">'+ page + '</a>')
						}else if(b <= 2){
							page += 1	
							console.log("page값 :" + $('.pagenum').val())

							$('.pagenum').html($('.pagenum').html()+'<a class ="pageA" href="javascript:void(0);" onclick="page_detail(this);" value = "'+ page +'">'+ page + '</a>')
						}
					}
					sessionStorage.setItem("pagenum", 1);
					console.log("세션"+ sessionStorage.getItem("pagenum"))
				}, //성공
					error : function(error) {
						alert("통신실패"+ error);
					}
				}); //  if 에이젝스
		event.preventDefault();

			}//else
			
			
		}); //find_data
})	//ready
	
function page_detail(obj){
	console.log("page"+sessionStorage.getItem("pagenum"));

	$(".wc_board").hide();
	var page = $(obj).attr('value');
	console.log(page)
	var start = (page-1)*2;
	var end = page*2;
	$(".wc_board").slice(start, end).show();
	sessionStorage.setItem("pagenum", page);
	console.log("page"+sessionStorage.getItem("pagenum"));
}//page event


	$(document).on("click", ".before-btn",function(event) {
		$(".wc_board").hide();

		page = sessionStorage.getItem("pagenum")
		console.log("page"+sessionStorage.getItem("pagenum"));

		if(page <= 1){
			swal("","첫 페이지 입니다.","info")
		}
		var start = (page-2)*2;
		var end = (page-1)*2;

		$(".wc_board").slice(start, end).show();
		sessionStorage.setItem("pagenum", Number(page)-1)
	});

	$(document).on("click", ".after-btn",function(event) {
		$(".wc_board").hide();
		console.log($(".wc_board").length)

		if($(".wc_board").length <= (Number(page)+1)*2){
			swal("","마지막 페이지 입니다.","info")
		}
		page = sessionStorage.getItem("pagenum")

		console.log("page"+sessionStorage.getItem("pagenum"));
		var start = page*2;
		var end = start+2;
		
		$(".wc_board").slice(start, end).show();
		sessionStorage.setItem("pagenum",Number(page)+1)

	});

//
	function checkOnlyOne(element) {
		  
		  const checkboxes = document.getElementsByName("kind");
		  console.log("체크박스 " + checkboxes)
		  checkboxes.forEach(function(cb) {
		    cb.checked = false;
		  })
		  element.checked = true;
	}
	//분류 체크박스 선택값 radio 함수
	
	function location_change(obj){
		var number = $(obj).attr('number');
		var category = $(obj).attr('category');
		console.log("함수 : " +$(obj).attr('category'))
		console.log("ㅇㅇㅇ"+number);	
		location.href="/samsam/ad_boardDetail.do?number="+ number +"&category="+ category;
	}


</script>	


</head>
<body>
<div class ="body_content">

<header id = "header">
	<div class="d-flex flex-column">
		<div class ="profile">
		<img src = "resources/img/samsam2.png" alt class = "img-circle">
			<h1 class ="text-light">
				<a href ="#" class = "onMember"> <%= email.toUpperCase()%>  </a>
			</h1>
		</div>
		<div class ="admin_inout">
			<button type="button" class ="grade">ADMIN</button>
			<button type="button" class ="grade" onclick="location.href='logout.me'">LOGOUT</button>
		</div>
						
		<ul>
			<li>
				<a href = "adminboard.do" class = "nav-menu"><i class= "far fa-clipboard menu"></i><span class="a-menu"> 게시물관리</span></a>
			</li>
			<li>
				<a href="admin_main.me" class = "nav-menu"><i class = "fas fa-users menu"></i><span class="a-menu"> 회원관리</span></a>
			</li>
			<li>
				<a href="admin_pay.me" class = "nav-menu"><i class = "fas fa-ticket-alt menu"></i><span class="a-menu"> 이용권관리</span></a>
			</li>
			<li>
				<a href="adminfree_auth.me" class = "nav-menu"><i class = "fas fa-dog menu"></i><span class="a-menu"> 책임분양</span></a>
			</li>
		</ul>
</div>
</header>

<div class = "main_content"> <!-- 메인컨텐트 -->
	<div class="content">
	<h3>게시물관리 > 게시글조회</h3>
		<form id="content" name="content" method="post">
			<div class="search">
				<div class = "condition">
				<div class="date">
				일자&nbsp;&nbsp; <input id="fromDate" type="text"autocomplete="off">&nbsp; - &nbsp; <input id="toDate" type="text"autocomplete="off">
				</div>
				
				<div class="member">
					분류 &nbsp; &nbsp;
					<div class="label"><label>게시글</label><input type='radio' name='kind' class='kind' value='writing' checked />    </div>&nbsp;&nbsp;
					<div class="label"><label>신&nbsp; 고</label><input type='radio' name='kind'class='kind' value='warning' /></div>&nbsp;&nbsp;
					<div class="kind_bar">
						카테고리&nbsp;&nbsp; 
						<select class="category" onchange="btn_disable();">
							<option value="">선택하세요</option>
							<option value="adopt_list">분양게시판</option>
							<option value="community" checked>커뮤니티</option>
						</select>
					</div>
				</div>
				<div class="keyword">
				검색<input type="text" id= "keyword" name = "keyword" value = "" placeholder
				="제목/ 내용을 입력하세요">
				</div> 
				</div>
				<div class = "submit_btn">
				<input type="button" id ="find_data" value="조회">
				</div>
			</div> <!-- search -->
		</form>
	
			
	<table id ="result-table">
		<thead>
			<tr>
			<td>#</td><td>제목</td><td>닉네임</td><td>작성일</td><td>조회수</td><td></td>
			</tr>
			</thead>
		<tbody id="output">
	
		</tbody>
	</table>	
	
	</div><!--container  -->

</div><!-- 메인컨텐트 끝 -->

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
</body>
</html>