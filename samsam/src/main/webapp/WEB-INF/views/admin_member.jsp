<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	String email = (String) session.getAttribute("email");
%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8"/>
<title>Insert title here</title>
<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<!-- sidebar -->
<link href="resources/css/admin_sidebar.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
<!-- 모달 플러그인 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script>
$(document).ready(function() {

	$("#check").click(function(event) { //정적데이터는 이벤트 처리를 바로 가능하나 동적이면 on을 사용하여 처리
		$('#result').empty();
		if($('#fromDate').val() == null) { 
			 $('#fromDate').val('')
		}
		if($('#toDate').val() == null) { 
			 $('#toDate').val('')
		}
		var temp ="";
		var temp1 ="";
		var temp2 ="";
		var temp3 ="";
		
		//체크박스 체크확인
		if($('input:checkbox[name="member_grade1"]').is(":checked") ==  true){
			temp1 = $('input:checkbox[name="member_grade1"]').val();	
		};
		if($('input:checkbox[name="member_grade2"]').is(":checked") ==  true){
			temp2 = $('input:checkbox[name="member_grade2"]').val();
		};	
		if($('input:checkbox[name="member_grade3"]').is(":checked") ==  true){
			temp3 = $('input:checkbox[name="member_grade3"]').val();
		};
		if(temp1 == null && temp2 == null && temp3 == null) { 
			temp = "대기";
		}
		
		var data = {
			"fromDate" : $('#fromDate').val(),
			"toDate" : $('#toDate').val(),
			"member_grade" : temp,
			"member_grade1" : temp1,
			"member_grade2" : temp2,
			"member_grade3" : temp3,
			"keyword" : $('#keyword').val()
		}
		var params = $("#content").serialize(); // .serialize() : 주어진 데이터를 키, 밸류 값을 짝지어(직렬화) 가져온다
		console.log(data);
		jQuery.ajax({ // $.ajax 와 동일한 표현
				url : '/samsam/search_member.do',
				type : 'POST',
				data : JSON.stringify(data), //서버로 보낼 데이터
				dataType : 'json', //서버에서 보내줄 데이터 타입
				contentType : 'application/json;charset=utf-8',
				success : function(mvo) {
					$('#result').empty();
					$('.result-table').empty();
					
					$.each(mvo, function(index, item){
						console.log(item.signdate);
						$('#result').html($('#result').html()+'<tr><td>' + item.grade+'</td><td class="email"><a href="#detail-form" rel="modal:open">' + item.email +'</td></a><td>' + item.nick +'</td><td>' + item.local + '</td><td>'
								 + item.signdate + '</td><td>' + item.wcount +'</td></tr>')
						$('.result-table').html($('.result-table').html()+'<div class="result-table-row"><a href="javascript:void(0);" onclick="member_detail(this);" value = "'+ item.email+'"><div class="result-table-cell">' + item.grade+'</div><div class="result-table-cell" id="detail_email">' + item.email +'</div><div class="result-table-cell">' + item.nick +'</div><div class="result-table-cell">' + item.local + 
						'</div><div class="result-table-cell">' + item.signdate + '</div><div class="result-table-cell">' + item.wcount +"</div></a></div>")
					});
				},
				error : function() {
						alert("ajax 통신 실패!!!");
				}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	
}); //레디

function member_detail(obj) {
	
	function fieldsetDisable()  {
		  const fieldset = document.getElementById('btn_fieldset');
		  if($('.status').val() == "완료" || $('.status').val() == "미제출" ){
		  fieldset.disabled = true;
		  }
	}
	
	var email = $(obj).attr('value');
	console.log("제발 " + email)
	$.ajax({
		url : '/samsam/member_detail.do',
		type : 'POST',
		data : JSON.stringify(email), //서버로 보낼 데이터
		dataType : 'json', //서버에서 보내줄 데이터 타입
		contentType : 'application/json;charset=utf-8',
		success : function(map) {
			console.log("map : " + map)
			$('input').val("");
			$('.w-table').empty();
			$('.b-table').empty();
			$('.c-table').empty();
			$('#biz_com').empty("");
			$('#biz_no').empty(""); 
			$('#biz_img').empty("");
			
			$('#email').val(map.MemberVO.email);
			$('#nick').val(map.MemberVO.nick);
			$('#phone').val(map.MemberVO.phone);
			$('#local').val(map.MemberVO.local);
			$('#grade').val(map.MemberVO.grade);
			$('#wcount').val(map.MemberVO.wcount);
			
			if(map.Biz_memberVO != null){
			$('#biz_com').html(map.Biz_memberVO.biz_com);
			$('#biz_no').html(map.Biz_memberVO.biz_no);
			$('#biz_img').html(map.Biz_memberVO.biz_img);
						
			if(map.Biz_memberVO.status == 0){
				console.log("map.Biz_membeerVO.status : " + map.Biz_memberVO.status )
				$('.status').val("완료");
				fieldsetDisable();
			}
			else if($('#biz_com').val() == "" && $('#biz_no').val() == "" && $('#biz_img').val() ==""){
				$('.status').val("미제출");
				fieldsetDisable();
			}
			}else{
				$('.status').val("미제출");
				fieldsetDisable();
			}
			
			if(map.Boardlist != null){
			$.each(map.Boardlist, function(index, item){
				console.log("map.Boardlist : " + map.Boardlist);
				$('.b-table').html($('.b-table').html()+'<div class="result-table-row"><div class="result-table-cell">'+ item.num+'</div><div class="result-table-cell"><a href="#">' + item.subject+'</a></div><div class="result-table-cell">' + item.write_date +'</div>')
			});//map.Boardlist each
			}else{
				$('.b-table').html($('.b-table').html()+'<div class="result-table-row"><div class="result-table-cell">작성글이 없습니다</div></div>')	
			}
			
			if(map.Commentlist != null){
			$.each(map.Commentlist, function(index, item){
				$('.c-table').html($('.c-table').html()+'<div class="result-table-row"><div class="result-table-cell"><a href="#">'+ item.content+'</a></div><div class="result-table-cell">' + item.write_date+'</div>')
			}); //map.Commentlist each
			}else{
				$('.c-table').html($('.c-table').html()+'<div class="result-table-row"><div class="result-table-cell">작성댓글이 없습니다</div></div>')	
			}
			$('#detail-form').modal('show');
			
			/*$.each(map, function(index, item){
				console.log(index)
				console.log(item)
				if(item.email != null || item.biz_email != null || item.content != null || item.no != null){
					$('#email').val(item.email);
					$('#nick').val(item.nick);
					$('#phone').val(item.phone);
					$('#local').val(item.local);
					console.log(item.local + item.grade)
					$('#grade').val(item.grade);
					$('#wcount').val(item.wcount);
					
					$('#biz_com').html(item.biz_com);
					$('#biz_no').html(item.biz_no);
					$('#biz_img').html(item.biz_img);
					
					if(item.status == "0"){
						$('.status').val("완료");
						fieldsetDisable();
					}
					if($('#biz_com').val() == "" && $('#biz_no').val() == "" && $('#biz_img').val() ==""){
						$('.status').val("미제출");
						fieldsetDisable();
					}
					console.log("어레이 인덱스 :" + index + " map.item :" + item)
				}
				$('#detail-form').modal('show');
			//	})//each
			});//each
			$.each(map.Boardlist, function(index){
				console.log(map.Boardlist)
				$('.b-table').html($('.b-table').html()+'<div class="result-table-row">'+ index.num+'<div class="result-table-cell"><a href="#">' + index.subject+'</a></div><div class="result-table-cell">' + index.write_date +'</div>')
			})
			$.each(map.Commentlist, function(index){
				console.log(map.Commentlist)
				$('.c-table').html($('.c-table').html()+'<div class="result-table-row"><a href="#">'+ index.content+'</a><div class="result-table-cell">' + index.write_date+'</div>')
			})		*/	
		},
		error : function() {
				alert("ajax 통신 실패!!!");
		}
	})//ajax
}//회원상세
$(document).on("click", ".auth_confirm", function(event){
	var email = $('#email').val();
	$.ajax({
		url : '/samsam/auth_confirm.do',
		type : 'POST',
		data : JSON.stringify(email), //서버로 보낼 데이터
		dataType : 'json', //서버에서 보내줄 데이터 타입
		contentType : 'application/json;charset=utf-8',
		success : function(result) {
			if(result.res == 1){
				$('.status').val("완료");
			}
			else{
				$('.status').val("업데이트실패");
			}
				
		},
		error : function() {
				alert("ajax 통신 실패!!!");
		}
	})//ajax
	
}) //모달 완료 버튼
$(document).on("click", ".auth_return", function(event){
	var email = $('#email').val();
	$.ajax({
		url : '/samsam/auth_return.do',
		type : 'POST',
		data : JSON.stringify(email), //서버로 보낼 데이터
		dataType : 'json', //서버에서 보내줄 데이터 타입
		contentType : 'application/json;charset=utf-8',
		success : function(result) {
			if(result.res == 1){
				$('.status').val("반려");
			}
			else{
				$('.status').val("삭제실패");
			}
		},
		error : function() {
				alert("ajax 통신 실패!!!");
		}
	})//ajax
		
}) //모달 반려 버튼

</script>
<script>
//달력
$(document).ready(function(){
	   // ================================
	// START YOUR APP HERE
	// ================================
	var init = {
	  monList: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
	  dayList: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
	  today: new Date(),
	  monForChange: new Date().getMonth(),
	  activeDate: new Date(),
	  getFirstDay: (yy, mm) => new Date(yy, mm, 1),
	  getLastDay: (yy, mm) => new Date(yy, mm + 1, 0),
	  nextMonth: function () {
	    var d = new Date();
	    d.setDate(1);
	    d.setMonth(++this.monForChange);
	    this.activeDate = d;
	    return d;
	  },
	  prevMonth: function () {
	    var d = new Date();
	    d.setDate(1);
	    d.setMonth(--this.monForChange);
	    this.activeDate = d;
	    return d;
	  },
	  addZero: (num) => (num < 10) ? '0' + num : num,
	  activeDTag: null,
	  getIndex: function (node) {
	    var index = 0;
	    while (node = node.previousElementSibling) {
	      index++;
	    }
	    return index;
	  }
	};

	var $calBody = document.querySelector('.cal-body');
	var $btnNext = document.querySelector('.btn-cal.next');
	var $btnPrev = document.querySelector('.btn-cal.prev');

	/**
	 * @param {number} date
	 * @param {number} dayIn
	*/
	function loadDate (date, dayIn) {
	  document.querySelector('.cal-date').textContent = date;
	  document.querySelector('.cal-day').textContent = init.dayList[dayIn];
	}

	/**
	 * @param {date} fullDate
	 */
	function loadYYMM (fullDate) {
	  let yy = fullDate.getFullYear();
	  let mm = fullDate.getMonth();
	  let firstDay = init.getFirstDay(yy, mm);
	  let lastDay = init.getLastDay(yy, mm);
	  let markToday;  // for marking today date
	  
	  if (mm === init.today.getMonth() && yy === init.today.getFullYear()) {
	    markToday = init.today.getDate();
	  }

	  document.querySelector('.cal-month').textContent = init.monList[mm];
	  document.querySelector('.cal-year').textContent = yy;

	  let trtd = '';
	  let startCount;
	  let countDay = 0;
	  for (let i = 0; i < 6; i++) {
	    trtd += '<tr>';
	    for (let j = 0; j < 7; j++) {
	      if (i === 0 && !startCount && j === firstDay.getDay()) {
	        startCount = 1;
	      }
	      if (!startCount) {
	        trtd += '<td>'
	      } else {
	        let fullDate = yy + '.' + init.addZero(mm + 1) + '.' + init.addZero(countDay + 1);
	        trtd += '<td class="day';
	        trtd += (markToday && markToday === countDay + 1) ? ' today" ' : '"';
	        trtd += ` data-date="${countDay + 1}" data-fdate="${fullDate}">`;
	      }
	      trtd += (startCount) ? ++countDay : '';
	      if (countDay === lastDay.getDate()) { 
	        startCount = 0; 
	      }
	      trtd += '</td>';
	    }
	    trtd += '</tr>';
	  }
	  $calBody.innerHTML = trtd;
	}

	/**
	 * @param {string} val
	 */
	function createNewList (val) {
	  let id = new Date().getTime() + '';
	  let yy = init.activeDate.getFullYear();
	  let mm = init.activeDate.getMonth() + 1;
	  let dd = init.activeDate.getDate();
	  const $target = $calBody.querySelector(`.day[data-date="${dd}"]`);

	  let date = yy + '.' + init.addZero(mm) + '.' + init.addZero(dd);

	  let eventData = {};
	  eventData['date'] = date;
	  eventData['memo'] = val;
	  eventData['complete'] = false;
	  eventData['id'] = id;
	  init.event.push(eventData);
	  $todoList.appendChild(createLi(id, val, date));
	}

	loadYYMM(init.today);
	loadDate(init.today.getDate(), init.today.getDay());

	$btnNext.addEventListener('click', () => loadYYMM(init.nextMonth()));
	$btnPrev.addEventListener('click', () => loadYYMM(init.prevMonth()));

	$calBody.addEventListener('click', (e) => {
	  if (e.target.classList.contains('day')) {
	    if (init.activeDTag) {
	      init.activeDTag.classList.remove('day-active');
	    }
	    let day = Number(e.target.textContent);
	    loadDate(day, e.target.cellIndex);
	    e.target.classList.add('day-active');
	    init.activeDTag = e.target;
	    init.activeDate.setDate(day);
	    reloadTodo();
	  }
	}); 
}); //달력끝

//투두리스트
$(document).ready(function(){
$(".txt").on("keyup",function(e){
  if(e.keyCode == 13 && $(".txt").val() != ""){
    //Task에 입력 값 넣기
    var task = $("<div class='task'></div>").text($(".txt").val());
    
    //삭제버튼
    var del = $("<i class='fas fa-trash-alt'></i>").click(function(){
      var p = $(this).parent();
      p.fadeOut(function(){
        p.remove();
      })
    });
    
    //체크 버튼
    var check = $("<i class='fas fa-check'></i>").click(function(){
      var p = $(this).parent();
      p.fadeOut(function(){
        $(".done").append(p);
        p.fadeIn();
      })
      $(this).remove();
    });
    
    //Task에 삭제 & 체크 버튼 추가하기
    task.append(del,check)
	  
    //할일 목록에 추가
    $(".notdone").append(task);
    
    //입력 창 비우기
    $(".txt").val("");
  }
})
});//투두리스트끝
</script>
<style>
.right-container, .content{
    margin-top:100px;
    width : 37%;
    display : flex;
    flex-direction: column;
    justify-content : flex-start;
}

#check{
width : 80px;
height : 50px;
border : 1px solid skyblue;
background-color : rgba(0,0,0,0);
color : skyblue;
padding : 5px;
border-radius : 5px;
align-self : right;

}
#check:hover{
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
  margin-bottom:10px;
  display: block;
  width:250px;
  height : 40px;
  font-size:1em;
}

.task{
  width:100%;
  background: rgba(255,255,255,0.5);
  padding: 18px;
  margin: 6px 0;
  overflow: hidden;
  border-radius: 3px;
}
.task i{
  float: right;
  margin-left: 20px;
  cursor: pointer;
}
.done .task{
  background: rgba(0,0,0,0.5);
  color : #fff;
}
/* ======== Calendar ======== */

.clearfix:after {
  content: '';
  display: block;
  clear: both;
  float: none;
}

/* ======== Calendar ======== */
.my-calendar {
  width: 400px;
  margin: 30px;
  padding: 20px 20px 10px;
  text-align: center;
  font-weight: 800;
  border: 1px solid #ddd;
  cursor: default;
}

.ctr-box {
  padding: 0 16px;
  margin-bottom: 20px;
  font-size: 20px;
}
.ctr-box .btn-cal {
  position: relative;
  float: left;
  width: 25px;
  height: 25px;
  margin-top: 5px;
  font-size: 16px;
  cursor: pointer;
  border: none;
  background: none;
}
.ctr-box .btn-cal:after {
  content: '<';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  line-height: 25px;
  font-weight: bold;
  font-size: 20px;
}
.ctr-box .btn-cal.next {
  float: right;
}
.ctr-box .btn-cal.next:after {
  content: '>';
}

.cal-table {
  width: 100%;
}
.cal-table th {
  width: 14.2857%;
  padding-bottom: 5px;
  font-size: 16px;
  font-weight: 900;
}
.cal-table td {
  padding: 3px 0;
  height: 50px;
  font-size: 15px;
  vertical-align: middle;
}
.cal-table td.day {
  position: relative;
  cursor: pointer;
}
.cal-table td.today {
  background: #ffd255;
  border-radius: 50%;
  color: #fff;
}
.cal-table td.day-active {
  background: #ff8585;
  border-radius: 50%;
  color: #fff;
}
.cal-table td.has-event:after {
  content: '';
  display: block;
  position: absolute;
  left: 0;
  bottom: 0;
  width: 100%;
  height: 4px;
  background: #FFC107;
}

/* 인증/반려 버튼 */

.auth_confirm {
	border: 1px solid #22B24C;
	color:#22B24C;
}
.auth_confirm:hover{
	color : #fff;
	background-color:#22B24C;
	border-color:#22B24C;
}

.auth_return{
	border: 1px solid #f8585b;
	color:#f8585b;
}
.auth_return:hover{
	color : #fff;
	background-color:#f8585b;
	border-color:#f8585b;
}

.auth_confirm,
.auth_return {
    width:80px;
    height : 30px;
    background-color: white;
    border: 1px solid #f8585b;
    color:#f8585b;
    padding: 15px 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
}

</style>
</head>
<body>
<div class ="body_content">
<header id = "header">
	<div class="d-flex flex-column">
		<div class ="profile">
			<img src = "주소" alt class = "img-fluid rounded-circle">
			<h1 class = "text-light">
				<a href = "#" class = "onMember"> <%= email%> </a>
			</h1>
			<div class ="admin_inout">
				<button type="button" class ="grade">ADMIN</button>
				<button type="button" class ="grade" onclick="location.href='loginForm.me'">LOGOUT</button>
			</div>
						
			<ul class = "nav-menu">
				<li class="active">
					<a href = "#" class = "nav-menu"><i class= "far fa-clipboard menu"></i><span> 게시물관리</span></a>
				</li>
				<li>
					<a href="admin_main.me" class = "nav-menu"><i class = "fas fa-users menu"></i><span> 회원관리</span></a>
				</li>
				<li>
					<a href="admin_pay.me" class = "nav-menu"><i class = "fas fa-ticket-alt menu"></i><span> 이용권관리</span></a>
				</li>
				<li>
					<a href="#" class = "nav-menu"><i class = "fas fa-dog menu"></i><span> 책임분양</span></a>
				</li>
			</ul>

</div>
</header>

<div class=content>
<form id="content" name="content" action="search_member.do" method="post">
<div class="search">
	<div class = "condition">
	<div class="date">
	일자 <input id="fromDate" type="text"> - 	<input id="toDate" type="text">
	</div>
	<div class="member">
	분류<label><input type="checkbox" name="member_grade1" value="사업자">사업자</label>&nbsp;&nbsp;
		<label><input type="checkbox" name="member_grade2" value="일반">개인</label>&nbsp;&nbsp;
		<label><input type="checkbox"name="member_grade3" value="대기" checked>대기</label>
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
<div class = "member_list-table">
<div class = "ml-table-row">
<table>
<td>분류</td><td>아이디</td><td>닉네임</td><td>지역</td><td>가입일</td><td>신고횟수</td>
</table>
</div>
</div>
<table>
<tbody id="result">

</tbody>
</table>
<div class = "result-table">

</div>
<!-- 반복문 -->

</div> <!-- content -->

<div class="right-container">
<!-- 달력 -->
  <div class="my-calendar clearfix">
    <div class="calendar-box">
      <div class="ctr-box clearfix">
        <button type="button" title="prev" class="btn-cal prev">
        </button>
        <span class="cal-month"></span>
        <span class="cal-year"></span>
        <button type="button" title="next" class="btn-cal next">
        </button>
      </div>
      <table class="cal-table">
        <thead>
          <tr>
            <th>S</th>
            <th>M</th>
            <th>T</th>
            <th>W</th>
            <th>T</th>
            <th>F</th>
            <th>S</th>
          </tr>
        </thead>
        <tbody class="cal-body"></tbody>
      </table>
    </div>
  </div>
  <!-- // .my-calendar -->

<!-- 투두리스트 -->
	<!-- 입력 -->
      <input type="text" placeholder="Add A Task" class ="txt" > 
    <!-- to do list -->
      <div class="notdone">
        <h3>To Do List</h3>
      </div>
	<!-- done list -->      
      <div class="done">
        <h3>Done</h3>
      </div>
    </div>
<!-- 방문자 -->
</div>
<form id= "detail-form" class="modal">
<div class = "member">
	<h3>회원정보</h3>
	<div class = "member_tab">
		<label>아이디</label><input type="text" id = "email" readonly>
		<label>닉네임</label><input type="text" id = "nick" readonly>
		<label>전화번호</label><input type="text" id = "phone" readonly>
		<label>주소</label><input type="text" id = "local" readonly>
		<label>분류</label><input type="text" id = "grade" readonly>
		<label>신고횟수</label><input type="text" id = "wcount" readonly>
	</div>
	<div class = "auth">
		<div class="auth_status">
		<h3>판매허가내역확인</h3>
		<fieldset id ="btn_fieldset">
		<button class ="auth_confirm">완료</button> <button class="auth_return">반려</button>
		</fieldset>
		<input type="text" class = "status" value ="미확인" readonly>
		</div>
		<div class = "auth_detail-table">
			<div class ="ad-table-row">
				<div class ="ad-table-cell">사업장명</div>
				<div class ="ad-table-cell" id = "biz_com"></div>
			</div>
			<div class ="ad-table-row">
				<div class ="ad-table-cell">관리번호</div>
				<div class ="ad-table-cell" id = "biz_no"></div>
			</div>
			<div class ="ad-table-row">
				<div class ="ad-table-cell">허가증</div>
				<div class ="ad-table-cell" id = "biz_img"></div>
			</div>
		</div>
		<div class ="warning">
			<h3>신고목록</h3>
			<div class="w-table">
			
			</div>
		</div>
		<div class ="boardlist">
			<h3>최근게시글</h3>
			<div class="b-table">
			
			</div>
		</div>
		<div class ="commentlist">
			<h3>최근댓글</h3>
			<div class="c-table">
			
			</div>
		</div>
	</div>
</div>
</form>

<!-- pageup button -->
<div class ="back-to-top">
<a href="#"><i class = "fas fa-angle-up"></i></a>
</div>
</body>
</html>