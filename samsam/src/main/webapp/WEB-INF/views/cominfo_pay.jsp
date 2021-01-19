<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.project.samsam.member.MemberVO"%>
<%@ page import="com.project.samsam.member.Biz_memberVO"%>
<%@ page import="com.project.samsam.member.Adopt_BoardVO"%>


<%
	String email = (String) session.getAttribute("email");
	//email.toUpperCase();
	if (session.getAttribute("email") == null){
		out.println("<script>");
		out.println("location.href='loginForm.me'");
		out.println("</script>");
	}
	
	MemberVO mvo = (MemberVO) request.getAttribute("MemberVO");
	Biz_memberVO bvo = (Biz_memberVO) request.getAttribute("Biz_memberVO");
	ArrayList<Adopt_BoardVO> adopt_list = (ArrayList<Adopt_BoardVO>)request.getAttribute("Adopt_list");
	Map<Integer, Integer> map = (Map<Integer, Integer>) request.getAttribute("map_count");

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
<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
<!-- 부트스트랩 4.0 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous" type="text/javascript"></script>
<!-- 아임포트 -->
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
<link href="resources/css/com_pay.css" rel="stylesheet">
<style>
/* 공통으로 사용하는 CSS */
@charset "utf-8";

* {
   margin:0;
   padding: 0;
}
html{
   margin:0 auto;
   width : 100%;
   height: 100%;
    overflow: auto;
}


body {
   margin: 0;
   height: auto;
    min-height : 600px;
    box-sizing : content-box;
   line-height: 1.7;
    color: gray;
      font-family: 'Noto Sans KR', sans-serif;
    font-weight: 300;
    font-size: .9rem;
}


a{
   text-decoration : none;
   color : #9494b8;
}
a:hover {
    color: #0056b3;
    text-decoration: none;
}

body {
   text-align: -webkit-center;
   display : flex;
   flex-direction : column;
   justify-content : space-between;
}

.body_content{
     margin : 0;
     padding : 0;
     width : 100%;
     height:100vh;
    display : flex;
    flex-direction : column;
}

#header {
    width: 100%;
    height: 190px;
    box-sizing: content-box;
    display: flex;
    flex-direction: column;
    border-bottom: 1px solid #efefef;
    padding-bottom: 20px;
    background-color : #fff;
    position : fixed;
      z-index : 10000;
    top : 0;
    left : 0;
    right : 0;
}

.inout_gocen{
   position : inline;
   display : flex;
   justify-content : flex-end;
   margin-top : 20px;
   margin-right : 340px;
   background-color : #fff;
}
.fixinner{
   position: fixed; 
}
.header-top {
   margin-top : -10px;
   display : flex;
   justify-content : flex-start;
   margin-right: auto;
}
.header_btn{
   width : 70px;
   height : 30px;
   background-color : #fff;
   color : #9494b8;
    border-radius: 5px;
    border : none;
    outline : 0;
}
.header_btn:hover{
   color : #6200cc;
   font-weight: 700;
}
#logout, #mypage{
   display : none;
}
.img-circle{
   width : 450px;
   height : 150px;
   display: block;
   margin : 0 auto;
}
.nav-menu{
   margin : 0 auto;
   display : flex;
   justify-content : space-around;
   align-items: baseline;
   width: 1200px;
}
.sticky-wrapper{
   width: 400px;
   height: 50px;
   margin : 0;
   margin-left: 0;
     position: sticky;
     list-style : none;
    display : flex;
    padding: 0;
}

.sticky-wrapper > li{
   padding : 8px 8px;
   list-style-type:none;
   float: left;
}
.sticky-wrapper > ul{
   padding : 8px 8px;
}

li.dropdown {
    color: #9494b8;
    background: #fff;
    transition: .3s all ease;
    font-size: 20px;
    width: 90px;
    height: 50px;
}

.sticky-wrapper.active{
   position: fixed;
    top: 0px;
}

/* dropdown */
.dropdown-menu {
   display: none;
      justify-content : flex-start;
   position: absolute;
   list-style : none;
    visibility: visible;
    background-color: #fff;
   width: 1200px;
   top : 52px;
   margin-left : -30px;
   border: none;
}

.board {
	padding-left: 46px;
}
.care {
	padding-left: 30px;
}
.commu {
	padding-left: 35px;
}

li.dropdown > a {
    text-decoration: none;
}

.dropdown-menu li{
   margin-right : 40px;
}
.dropdown:hover .dropdown-menu { 
   display: flex; 
   visibility: visible; 
}

/* search-wrapper */
.search-wrapper {
  padding : 5px;
  width: 280px;
  height: 38px;
  display: flex;
  justify-content : space-betwwen;
  background: #fff;
  border: 2px solid #9494b8;
  border-radius: 10px;
}
.search-box {
  height : 100%;
  padding: 0;
  border: none;
  background: #fff;
}
.search-box.input {
  width : 80%;
  margin-left : 15px;
  font-size : .9rem;
}
.search-box.input:focus {outline:none;}

.search-box.btn {
  color : #9494b8;
  text-align : left; 
}

/* search-wrqpper */

.main-content{
   width : 100%;
   height : auto;
   margin : 0 auto;
}


/* footer */
#footer {
    margin: 0 auto;
    width: fit-content;
    bottom: 20px;
    position: relative;
}

p{
   text-align : center;
}
.fa-heart{
   color : red;
}

/* pageup button */
.back-to-top{
   width : 40px;
   height : 40px;
   margin : 0 auto;
   font-size : 24px;
   color : white;
   background-color : #149DDD;
   border-radius : 50%;
   visibility : visible;
   position: fixed; 
   bottom: 45px; 
   right: 30px;
   text-align : center;
}
/* pageup button */
*, ::after, ::before {
    box-sizing: border-box;
}


/*카카오톡 톡상담*/
.kakaoChat {
    text-align: right;
    position: fixed;
    margin-right: 28px;
    bottom: 90px;
    right: 0;
}
.kakao_btn {
	border-radius: 1rem!important;
}

/* side menu와 내용 묶음 */
.content-wrap {
	width: 1200px;
	min-height: 100%;
	margin: 0 auto;
	position: relative;
	top: 50px;
	
}
/* side menu 틀*/
.sidemenu-section {
    width: 200px;
    font-size: 18px;
    text-align: left;
    min-height: 740px;
    border-right-color: darkblue;
    border-right: 1px solid #efefef;
    padding: 0px 0px 0 0;
    margin-left: 0;
    margin-top: 210px;
    position: fixed;
}


/* 내용 틀*/
.content-section {
    width: 1001px;
    height: max-content;
    position: relative;
    left: 100px;
    text-align: left;
    font-size: 14px;
    margin-top: 0px;
    color: black;
    margin-left: 0;
    padding-bottom: 100px;
    border-left-color: darkblue;
    border-left: 1px solid #efefef;
    padding-left: 50px;
    padding-right: 0;
    min-height: 940px;
    padding-top: 200px;
}

/* 각각의 페이지에서 사용할 CSS */
.list-group {
	border-bottom: 1px solid rgba(0,0,0,.125);
}
.list-group-item {
    position: relative;
    display: block;
    padding: .75rem 1.25rem;
    margin-bottom: -1px;
    background-color: white;
    border: 1px solid rgba(0,0,0,.125);
}
/* 현재 페이지의 서브메뉴 */
li.list-group-item.click > a {
    font-weight: bold;
    color: #5c5c8a;
}


.list-group-item > a {
	text-decoration : none;
	}


</style>

</head>
<body>
<div class ="body_content">
<header id = "header">

	<div class ="inout_gocen">
			<input type="button" class= "header_btn" id="login" value="로그인" onclick ="location.href='loginForm.me'">
			<input type="button" class= "header_btn" id="logout" value="로그아웃" onclick ="location.href='logout.me'">
			<input type="button" class= "header_btn" id="signin" value="회원가입" onclick ="location.href='joinform.me'">
			<input type="button" class= "header_btn" id="mypage" value="마이페이지" onclick ="location.href='mypage.me'">
			<input type="button" class= "header_btn" id="gocen" value="고객센터" onclick ="location.href='customer_service.me'">
		</div>
	
	<div class="nav-menu">
				<ul class="sticky-wrapper">
					<li class="dropdown"><a href="main.me">HOME</a></li>
					<li class="dropdown"><a href="board.me">분양</a>
						<ul class="dropdown-menu board">
							<li><a href="#">&nbsp;&nbsp;가정분양</a></li>
							<li><a href="#">책임분양</a></li>
							<li><a href="#">업체분양</a></li>
						</ul></li>
					<li class="dropdown"><a href="care.me">보호소</a>
						<ul class="dropdown-menu care">
							<li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;보호소</a></li>
							<li><a href="#">파양</a></li>
							<li><a href="#">실종</a></li>
						</ul></li>
					<li class="dropdown"><a href="community.me">커뮤니티</a>
						<ul class="dropdown-menu commu">
							<li><a href="#">&nbsp;자유게시판</a></li>
							<li><a href="#">책임분양인증</a></li>
						</ul></li>
				</ul>
	
	<div class="header-top">
		<div class="mainlogo">
		<a href="home.me">
		<img src = "resources/img/mainlogo.png" class = "img-circle">
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
			<ul class="list-group list-group-flush">
				<li class="list-group-item"><a href="cominfo_member.me">회원정보</a></li>
				<li class="list-group-item"><a href="cominfo_list.me">작성글관리</a></li>
				<li class="list-group-item click"><a href="cominfo_main.do">분양관리</a></li>
			</ul>
			</div>
			
			<!-- 오른쪽. 내용이 들어갈 부분 -->
			<div class="content-section">
				<h5 class ="font"> 분양관리 > 이용권/분양글 </h5>
				<br>
	<form class = "content">
		<div class="textbox">
		<h3>이용권</h3>		
		<table class = pay border="1">
			<tr><td rowspan="2" class="pay_detail">이용권</td><td>월 기본 제공 </td><td><%=bvo.getFree_coupon() %>/5</td></tr>
			<tr><td>남은 구매 이용권 횟수</td><td id = "pay_coupon"><%=bvo.getPay_coupon() %> </td></tr>
		</table>
		
		<div class ="btns">
		<input type="button" id="check1" value="구매">
		<input type="button" id="check2" value="환불">
		</div>
		<h3>분양글</h3>
		<table class = pay border="1">
			<tr><td>글번호</td><td>제목</td><td>작성일</td><td>조회수</td></tr>
			<!-- 반복문 -->
		<%
			if(adopt_list != null){
				for(Adopt_BoardVO adopt_board : adopt_list){
					for ( Integer key : map.keySet() ) {
						if(key == adopt_board.getAdopt_no()){
		%>
			<tr>
				<td><%= adopt_board.getAdopt_no() %></td>
				<td><%=adopt_board.getAdopt_title() %>  (<%=map.get(key) %>)</td>
				<fmt:formatDate var="formatDate" value="<%=adopt_board.getAdopt_date()%>" pattern="yyyy-MM-dd"/>
    			<td>${formatDate}</td>
				<td><%=adopt_board.getAdopt_readcount() %></td>
			</tr>
		<% }}}} %>
		</table><br>
		</div>
	</form>
				
			</div>
			
			
		</div>
		<footer id="footer">
		<p>Copyright ©2021 All rights reserved | This template is made with <i class="fas fa-heart"></i> by SamSam
		</footer>
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

<script>
$(document).ready(function(){
    console.log("<%= email %>") 
    var session = '<%= email %>'
    console.log(session);
    if(session == "null" ){
        $('#logout').hide();
          $('#mypage').hide();
          $('#login').show();
          $('#signin').show();
        
     } //헤더 상단 로그인상태 일때
     else{
       $('#logout').show();
         $('#mypage').show();
         $('#login').hide();
         $('#signin').hide();
     }; //헤더 상단 로그아웃상태 일때 
  });
  
$(window).scroll(function(){ 
    var height = $(document).scrollTop(); //실시간으로 스크롤의 높이를 측정
    if(height > 190){ 
      $('#header').addClass('fixinner'); 

    }else if(height == 0){ 
      $('#header').removeClass('fixinner'); 
    } 
  });
 
</script>

<!-- 부트스트랩 4.0 js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

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
<!-- pay js -->
<script type="text/javascript">
$(document).ready(function(){
	   var pay = <%=bvo.getPay_coupon() %>;
	   console.log(pay);
	   	  
		var IMP = window.IMP;
		var code = "imp70138110"; //가맹점 식별코드
		IMP.init(code);
		
		$("#check1").click(function(e){
			//결제요청
			IMP.request_pay({
				//name과 amout만있어도 결제 진행가능
				//pg : 'kakao', //pg사 선택 (kakao, kakaopay 둘다 가능)
				pay_method: 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '결제테스트', // 상품명
				amount : 1,
				buyer_email : '<%=email%>',
				buyer_name : '<%=mvo.getName()%>',
				buyer_tel : '<%= mvo.getPhone()%>',  //필수항목
						//결제완료후 이동할 페이지 kko나 kkopay는 생략 가능
				//m_redirect_url : 'https://localhost:8080/payments/complete'
			}, function(rsp){
				if(rsp.success){//결제 성공시
					var msg = '결제가 완료되었습니다';
					var result = {
					"imp_uid" : rsp.imp_uid,
					"merchant_uid" : rsp.merchant_uid,
					"biz_email" : '<%=email%>',
					"pay_date" : new Date().getTime(),
					"amount" : rsp.paid_amount,
					"card_no" : rsp.apply_num,
					"refund" : 'payed'
					}
					console.log("결제성공 " + msg);
					$.ajax({
						url : '/samsam/insertPayCoupon.do', 
				        type :'POST',
				        data : JSON.stringify(result,
				        		['imp_uid', 'merchant_uid', 'biz_email', 
				        			'pay_date', 'amount', 'card_no', 'refund']),
				        contentType:'application/json;charset=utf-8',
				        dataType: 'json', //서버에서 보내줄 데이터 타입
				        success: function(res){
				        			        	
				          if(res == 1){
							 console.log("추가성공");	
							 pay += 5;
							 $('#pay_coupon').html(pay);			           
				          }else{
				             console.log("Insert Fail!!!");
				          }
				        },
				        error:function(){
				          console.log("Insert ajax 통신 실패!!!");
				        }
					}) //ajax
					
				}
				else{//결제 실패시
					var msg = '결제에 실패했습니다';
					msg += '에러 : ' + rsp.error_msg
				}
				console.log(msg);
			});//pay
		}); //check1 클릭 이벤트
		 
		$("#check2").click(function(e){
			if(<%=bvo.getPay_coupon() %> >= 5){
			$.ajax({
					url: "/samsam/coupon_cancel.do",
					type:"post",
					//datatype:"json",
					contentType : 'application/x-www-form-urlencoded; charset = utf-8',
					data : {
						"biz_email" : '<%=email%>' // 주문번호
						//"cancle_request_amount" : 2000, //환불금액
						//"reason": "테스트 결제 환불", //환불사유
						//"refund_holder": "홍길동", //[가상계좌 환불시 필수입력] 환불 가상계좌 예금주
						//"refund_bank":"88", //[가상계좌 환불시 필수입력] 환불 가상계좌 은행코드(ex Kg이니시스의 경우 신한은행 88)
						//"refund_account": "56211105948400" // [가상계좌 환불시 필수입력] 환불 가상계좌 번호
					}
				}).done(function(result){ //환불 성공
					 pay -= 5;
					 $('#pay_coupon').html(pay);	
					console.log("환불 성공 : "+ result);
				}).fail(function(error){
					console.log("환불 실패 : "+ error);
				});//ajax
			} else{
				console.log("환불 실패 : 남은 결제권 환불 불가");
			}
		}); //check2 클릭
		
	}); //doc.ready
</script>
</body>
</html>