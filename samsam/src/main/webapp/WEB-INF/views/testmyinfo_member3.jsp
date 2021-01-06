<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
	<meta charset="utf-8"/>
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<link href="resources/css/my_sidebar.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
<!-- 달력 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.5.1/moment.min.js"></script>
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

$(".textbox input").attr("value", "");
$(".textbox input").attr("onkeyup", "this.setAttribute('value', this.value);");

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

#check{
width : 500px;
height : 48px;
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
#admin{
margin-top:50px;
margin-right : 80px;
text-align:right;
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
html, body {
  box-sizing: border-box;
  padding: 0;
  margin: 0;
}

*, *:before, *:after {
  box-sizing: inherit;
}
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
.my-calendar .clicked-date {
  border-radius: 25px;
  margin-top: 36px;
  float: left;
  width: 42%;
  padding: 46px 0 26px;
  background: #ddd;
}
.my-calendar .calendar-box {
  float: right;
  width: 58%;
  padding-left: 30px;
}

.clicked-date .cal-day {
  font-size: 24px;
}
.clicked-date .cal-date {
  font-size: 130px;
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
</style>
</head>
<body>
<div class ="body_content">

<!-- mobile toggle -->
<button type="button" class ="mobile-nav-toggle d-xl-none">
<i class="fas fa-hamburger"></i></button>
<!-- mobile toggle -->

<header id = "header">
	<div class="d-flex flex-column">
		<div class ="profile">
			<img src = "주소" alt class = "img-fluid rounded-circle">
			<h1 class = "text-light">
				<a href = "#"> ADMIN </a>
			</h1>
			
			<nav class = "nav-menu">
			<ul>
				<li class="active">
					<a href = "#"><i class= "far fa-clipboard"></i><span> 게시물관리</span></a>
				</li>
				<li>
					<a href="admin_main.me"><i class = "fas fa-users"></i><span> 회원관리</span></a>
				</li>
				<li>
					<a href="admin_pay.me"><i class = "fas fa-ticket-alt"></i><span> 이용권관리</span></a>
				</li>
				<li>
					<a href="#"><i class = "fas fa-dog"></i><span> 책임분양</span></a>
				</li>
			</ul>
			</nav>

<!-- mobile toggle -->
	<button type="button" class ="mobile-nav-toggle d-xl-none">
		<i class="fas fa-angle-up"></i>
	</button>
	
</div>
</header>

<!-- pageup button -->
<a href-"#" class ="back-to-top" style="display: inline;">
	<i class = "fas fa-angle-up"></i>
</a>


<div class=content>
<div>
<img name = "profile" src="">
</div>
<div>
<h3>회원정보</h3>
아이디 &nbsp;&nbsp; 닉네임<br>
지역 &nbsp;&nbsp; 분류<br>
전화번호 <br> 
신고횟수
</div>
<h3>판매허가내역</h3> 
<!-- 판매허가인증 내역 불러오기 -->
<input type="button" value="확인" onclick="">&nbsp;&nbsp;
<input type="button" value="반려" onclick="">
<table>
<tr><td>사업장명</td><td>사업장명 출력 </td></tr>
<tr><td>관리번호</td><td>관리번호 출력</td></tr>
<tr><td>허가증 </td><td>업로드한 허가증 파일명.확장자</td></tr>
</table>
<h3>신고목록</h3>
<!-- 반복문 table -->
<table><tr><td>제목</td><td>날짜</td></tr></table>
<h3>최근 게시글</h3>
<!-- 반복문 table -->
<table><tr><td>제목</td><td>날짜</td></tr></table>
<h3>최근 댓글</h3>
<!-- 반복문 table -->
<table><tr><td>제목</td><td>날짜</td></tr></table>
</div>

<div class="right-container">
<!-- 달력 -->
  <div class="my-calendar clearfix">
    <div class="clicked-date">
      <div class="cal-day"></div>
      <div class="cal-date"></div>
    </div>
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
</body>
</html>