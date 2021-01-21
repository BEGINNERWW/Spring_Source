<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.project.samsam.simport.Payed_listVO"%>
<%
	String email = (String) session.getAttribute("email");
	System.out.println("session email :" +session.getAttribute("email"));
	
	if (session.getAttribute("email") == null && session.getAttribute("email") != "admin"){
		out.println("<script>");
		out.println("location.href='loginForm.me'");
		out.println("</script>");
	}
	
	ArrayList<Payed_listVO> plist = (ArrayList<Payed_listVO>) request.getAttribute("Pay_list");
		
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
<link href="resources/css/admin_sidebar.css" rel="stylesheet">
<link href="resources/css/admin_pay.css" rel="stylesheet">
<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
<script src="resources/js/adminPage.js"></script>
<!-- chart.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<!-- 스윗얼럿 -->
<script src = "https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
var count = 20;
var page =0;
$(document).on("click", ".before-btn",function(event) {
	if(count > 20){
		count -= 20
		page -= 1
		$(".payed").slice(page * 20,count).show();
	}
	else{
		swal("","첫 페이지 입니다.","info")
	}
});

$(document).on("click", ".after-btn",function(event) {
	count += 20
	page += 1
	$(".payed").slice(page * 20,count).show();
	if($(".payed").length <= count){
		console.log($(".payed").length)
		swal("","마지막 페이지 입니다.","info")
	}
});
var chart1Labels = [];
var chart1adopt = [];
var chart1home = [];
var chart1free = [];
var chart2Labels = [];
var chart2data = [];
var chart2tooltip = [];
var chart3Labels = [];
var chart3data = [];

$(document).ready(function(){
	getTimeStamp();

	jQuery.ajax({ // $.ajax 와 동일한 표현
		url : '/samsam/storereport.do',
		type : 'POST',
		dataType : 'json', //서버에서 보내줄 데이터 타입
		contentType : 'application/json;charset=utf-8',
		success : function(map) {
			console.log(map);
			if(map.storecount != null || map.standbycount != null){
			 	var count = "<tr><td>총 가입업체 수</td><td>" + map.storecount+"</td></tr>"
			 		count += "<tr><td>인증대기업체 수</td><td>" + map.standbycount+"</td></tr>"
		
				   $('.storecount').append(count);  
			}//if
			if(map.chart1 != null && map.chart1 != ""){
				console.log("chart1")
				console.log(map.chart1)
			$.each(map.chart1, function(index, item){
				if(chart1Labels.length != 0){
					for(var i =0; i<=chart1Labels.length; i++){
						if(chart1Labels[i] != item.write_date){
							chart1Labels.push(item.write_date);
						}
					}
				}
				if(item.board == "분양"){
					chart1adopt.push(item.write_count);
				}
				if(item.board == "가정"){
					chart1home.push(item.write_count);
				}
				if(item.board == "책임"){
					chart1free.push(item.write_count);
				}
			});
			}//map.chart1
			console.log("chart2")
			console.log(map.adopt)
			console.log(map.home)
			console.log(map.free)

			if(map.adopt != null && map.adopt != ""){
				chart2Labels.push("분양")
				chart2data.push(map.adopt.alocal_count)
				console.log(map.adopt.alocal_count)
				chart2tooltip.push(map.adopt.local)
			}
			if(map.home != null && map.home != ""){
				chart2Labels.push("가정")
				chart2data.push(map.home.hlocal_count)
				chart2tooltip.push(map.home.local)
			}
			if(map.free != null && map.free != ""){
				chart2Labels.push("책임")
				chart2data.push(map.free.flocal_count)
				chart2tooltip.push(map.free.local)
			}//map.chart2
			console.log("chart3")
			console.log(map.chart3)
			if(map.chart3 != null && map.chart3 != ""){
				$.each(map.chart3, function(index, item){
					var repayCount = null;
					if(map.chart3.refund != null && map.chart3.refund !=""){
						chart3Lables.push(map.chart3.refund)
						chart3data.push(map.chart3.count)	
					}else{
						repayCount += map.chart3.biz_count
					}
					chart3Labels.push("Buy again")
					chart3data.push(repayCount)
				});
			}
			barChart();
			console.log("create Chart");
		},
		error : function() {
			console.log("업체카운팅 and chart ajax실패!!!");
		}
	});	

})//ready

function barChart(){
	console.log("barchart")
	console.log(chart2data)
var ctx = $('#barchart').get(0).getContext('2d');
var bardata =
{
    labels: chart2Labels,
    datasets:
        [{
        	label: chart2tooltip,
            backgroundColor: [ 
            	'rgba(255, 99, 132, 0.5)', 
            	'rgba(54, 162, 235, 0.5)', 
            	'rgba(255, 206, 86, 0.5)'
            ], 
            borderColor: [
            	'rgba(255, 99, 132, 1.5)',
            	'rgba(54, 162, 235, 1.5)', 
            	'rgba(255, 206, 86, 1.5)'
            ],
            data: chart2data
        }]
};
var baroptions = { 
		title: { 
			display: true, 
			text: '최근 1주 간 게시글 지역 탑 3', 
			fontSize: 18, 
			fontColor: 'rgba(46, 49, 49, 1)' 
		},
		animation: false,
		tooltips: {
		      callbacks: {
		        label: function(tooltipItem, data) {
		          var label = data.datasets[tooltipItem.index];
		          return label;
		        }
		      }
		    }
		};
		
var barChart = new Chart(ctx,{          
	type: 'bar',
	data: bardata,
	options: baroptions
});
}//bar chart


function getTimeStamp() {

    var d = new Date();
    console.log(d.getFullYear())
    console.log(d.getMonth()+1)
    console.log(d.getDate())
    var s = d.getFullYear() + '-' +
        	(d.getMonth() + 1) + '-' +
            d.getDate();
	$('.today').html(s);	
}
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
<h3>이용권관리 > 이용권 결제내역</h3>
<div class = "today"></div>
<div class ="chartjs">
	<table class = "storecount"></table>
	<div class ="linechart"><canvas id="linechart" height="180" width="180"></canvas></div>
	<div class ="barchart"><canvas id="barchart" height="180" width="180"></canvas></div>
	<div class ="donutchart"><canvas id="donutchart" height="180" width="180"></canvas></div>
</div>
<table class="paylist">
<thead>
<tr>
<td>번호</td><td>아이디</td><td>결제상태</td><td>결제일</td>
</tr>
</thead>
<%
System.out.println("plist :" + plist);
if(!plist.isEmpty()){
	for(Payed_listVO pay : plist){
		if(pay.getMerchant_uid() == null){
 } %>
<tbody>
<tr class = "payed">
	<td><%=pay.getMerchant_uid() %></td>
	<td><%=pay.getBiz_email() %></td>
	<td><%=pay.getRefund() %></td>
	<fmt:formatDate var="formatDate" value="<%=pay.getPay_date()%>" pattern="yyyy-MM-dd HH:mm:ss"/>
    <td>${formatDate}</td>
</tr>
<% }} else{%>
<tr><td colspan = "4"> 전체 조회결과, 결제내역이 존재하지 않습니다 </td></tr>
<% } %>
<tr><td class="tb-bottom" colspan = "4">
	<input type='button' class ='before-btn' value = '이전'>
	<input type='button' class = 'after-btn' value = '다음'>
	</td>
</tr>
</tbody>
</table>
</div>
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
</body>
</html>