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
<!doctype html>
<html>
<head>
	<meta charset="utf-8"/>
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
$(document).ready(function(){
   var pay = <%=bvo.getPay_coupon() %>;
   console.log(pay);
   
   var today = new Date();   
   var year = today.getFullYear(); // 년도
   var month = today.getMonth() + 1;  // 월
   var date = today.getDate();  // 날짜
   var day = today.getDay();  // 요일
	
   //주문번호 생성
   var today_uuid = String(year) + String(month) + String(date) + String(day) 
   var random = Math.random().toString(36).substr(2,11);
   var newID = today_uuid + random;

   console.log(newID);
	  
	var IMP = window.IMP;
	var code = "imp70138110"; //가맹점 식별코드
	IMP.init(code);
	
	$("#check1").click(function(e){
		//결제요청
		IMP.request_pay({
			//name과 amout만있어도 결제 진행가능
			//pg : 'kakao', //pg사 선택 (kakao, kakaopay 둘다 가능)
			pay_method: 'card',
			//merchant_uid : 'merchant_' + new Date().getTime();
			merchant_uid : newID, //주문번호
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
				"biz_email" : <%=email%>,
				"pay_date" : today,
				"amount" : rsp.paid_amount,
				"card_no" : rsp.apply_num,
				"refund" : 0
				}
				
				$.ajax({
					url : '/samsam/insertPayCoupon.do', 
			        type :'POST',
			        data : result, //서버로 보낼 데이터
			        contentType:'application/x-www-form-urlencoded;charset=utf-8',
			        dataType: 'json', //서버에서 보내줄 데이터 타입
			        success: function(retVal){
			        			        	
			          if(retVal.res =="OK"){
			            //데이터 성공일때 이벤트 작성
			            selectData();
			            //초기화
			           
			          }else{
			            alert("Insert Fail!!!");
			          }
			        },
			        error:function(){
			          alert("Insert ajax 통신 실패!!!");
			        }
				}) //ajax
			}
			else{//결제 실패시
				var msg = '결제에 실패했습니다';
				msg += '에러 : ' + rsp.error_msg
			}
			alert(msg);
		});//pay
	}); //check1 클릭 이벤트
	 
	$("#check2").click(function(e){
		$.ajax({
				url: "/samsam/coupon_cancel.do",
				type:"post",
				//datatype:"json",
				contentType : 'application/x-www-form-urlencoded; charset = utf-8',
				data : {
					"merchant_uid" : newID // 주문번호
					//"cancle_request_amount" : 2000, //환불금액
					//"reason": "테스트 결제 환불", //환불사유
					//"refund_holder": "홍길동", //[가상계좌 환불시 필수입력] 환불 가상계좌 예금주
					//"refund_bank":"88", //[가상계좌 환불시 필수입력] 환불 가상계좌 은행코드(ex Kg이니시스의 경우 신한은행 88)
					//"refund_account": "56211105948400" // [가상계좌 환불시 필수입력] 환불 가상계좌 번호
				}
			}).done(function(result){ //환불 성공
				alert("환불 성공 : "+ result);
			}).fail(function(error){
				alert("환불 실패 : "+ error);
			});//ajax
		
	}); //check2 클릭
	
}); //doc.ready
</script>
<style>
body, html {
	margin: 0;
	font-family: 'Noto Serif KR', serif;
}
  .body_content{
  	margin : 0;
  	height:100vh;
    display : flex;
	justify-content: center;
  }
  #aside{
  	width : 250px;
    flex-direction:column;
    justify-content: space-around;
  }
  .box .name .m_menu{
    align-self: auto;
  }
  .name {
    margin-right : 50px;
    padding : 0;
    text-align:center;
  }
.box {
	margin : 30px;
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
ul{
padding:0;
margin-top:30px;
}
li{
width: 100%;
height : 48px;
list-style-type:none;
display:flex;
justify-content: flex-start;
}
a{
color : black;
text-decoration:none;
}
.content{
	margin-top:100px;
	width : 550px;
    display : flex;
    flex-direction: column;
    justify-content : flex-start;
}

#check1, #check2{
width : 500px;
height : 48px;
border : 1px solid skyblue;
background-color : rgba(0,0,0,0);
color : skyblue;
padding : 5px;
border-radius : 5px;
align-self : right;

}
#check1:hover, #check2:hover{
color : white;
background-color:skyblue;
}
.textbox {
  display:flex;
  flex-direction : column;
  align-items : left;
  max-height: 60px;
  margin-left:80px;
  padding: 10px 8px 4px 8px;
  width: 500px;
  height: 100px;
  position: relative;
 }
 
input {
  font-family: 'Noto Serif KR', serif;
  outline: 0;
  border: 1px solid #eeeeee;
  border-radius : 5px;
  margin-top:10px;
  display: block;
  width:270px;
  height : 40px;
  font-size:1em;
}


</style>
</head>
<body>
<div class ="body_content">
<div id="aside">
<div class="box" style="background: #BDBDBD;">
    <img class="profile" src="C:\Users\AIA\Downloads\Telegram Desktop\rabit.jpg">
</div>
<div class ="name">이름/닉네임</div>
<nav class ="m_menu">
 <ul>
    <li><a href="cominfo_member.me">회원정보</a></li>
    <li><a href="cominfo_list.me">작성글관리</a></li>
    <li><a href="cominfo_main.me">분양관리</a></li>
 </ul>
</nav>
</div>
<form class = "content">
<div class="textbox">
<h3>이용권</h3>
<table class = pay border="1">
	<tr><td rowspan="2">이용권</td><td>월 기본 제공 </td><td><%=bvo.getFree_coupon() %>/5</td></tr>
	<tr><td>남은 이용권 횟수</td><td id = "pay_coupon"> <%=bvo.getPay_coupon() %>/5</td></tr>
</table><br>
<input type="button" id="check1" value="구매">
<input type="button" id="check2" value="환불">
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
</body>
</html>