<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
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
<script>
//달력
var today = new Date();
var finall = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
if (today.getFullYear() % 4 == 0 && (today.getFullYear() % 100 != 0 || today.getFullYear() % 400 == 0)) {
  finall = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
}
function prev() {
  today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
  makeArray();
}
function next() {
  today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
  makeArray();
}
function makeArray() {
  var first = new Date(today.getFullYear(), today.getMonth(), 1);
  var day = 1;
  var cal = new Array(6);
  cal.fill(" ");
  var j = first.getDay();
  for (let i = 0; i < 6; i++) {
   	 cal[i] = new Array(7);
     cal[i].fill(" ");
    for (j; j < 7; j++) {
     cal[i][j] = day++;
     if (day > finall[today.getMonth()] + 1) cal[i][j] = " ";
    }
    j = 0;
  }
  arrayToTable(cal);
}

function arrayToTable(arr) {
	  document.getElementById("monthTable").innerHTML =
	    "<span>" +
	    today.getFullYear() +
	    "</span> " +
	    "<span style='font-weight:800; color:#cc3300'>" +
	    (today.getMonth() < 9 ? "0" + (((today.getMonth() - 1) % 12) + 2) : ((today.getMonth() - 1) % 12) + 2) +
	    "</span> ";
	  var calendar = document.getElementById("calendar").getElementsByTagName("tbody")[0];
	  if (calendar.rows.length > 2)
	    for (let i = 0; i < 6; i++) {
	      calendar.deleteRow(-1);
	    }
	  for (let i = 0; i < 6; i++) {
	    var row = calendar.insertRow();
	    for (let j = 0; j < 7; j++) {
	      cell = row.insertCell();
	      if (arr[i][j] != undefined) {
	        if (today.getMonth() == new Date().getMonth() && today.getFullYear() == new Date().getFullYear() && arr[i][j] == today.getDate()) {
	          cell.innerHTML = '<span style="color:#cc3300; font-weight:700;">' + arr[i][j] + "</span>";
	        } else {
	          cell.innerHTML = arr[i][j];
	        }
	      }
	    }
	  }
	}
</script>
<script>

$(".txt").on("keyup",function(e){
    if(e.keyCode == 13 && $(".txt").val() != ""){
      //Task에 입력 값 넣기
      var task = $("<div class='task'></div>").text($(".txt").val());
      //삭제버튼
      var del = $("<i class='icon ion-ios-trash'></i>").click(function(){
        var p = $(this).parent();
        p.fadeOut(function(){
          p.remove();
        })
      });
      
      //체크 버튼
      var check = $("<i class='icon ion-md-checkmark'></i>").click(function(){
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
</script>
<style>
body, html {
	margin: 0;
	font-family: 'Noto Serif KR', serif;
}
/* 달력  */
.no-drag {
-ms-user-select: none;
-moz-user-select: -moz-none; 
-webkit-user-select: none; 
-khtml-user-select: none; 
user-select:none;
}
 
#calendar {
	text-align: center;
}
#calendar thead {
	font-size: 16px;
	font-weight: 700;
	text-align: center;
}
#calendar td {
	text-align: center;
}
#calendar tbody td {
	width: 10px;
	height: 10px;
	padding: 5px;
	font-size: 12px;
	font-weight: 400;
}
#dateHead {
	font-size: 12px;
	font-weight: 700;
	text-align: center;
}
/* 달력 끝 */
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
	margin-top:200px;
	width : 550px;
    display : flex;
    flex-direction: column;
}

#check{
width : 264px;
height : 48px;
border : 1px solid skyblue;
background-color : rgba(0,0,0,0);
color : skyblue;
margin-right:105px;
padding : 5px;
border-radius : 5px;
align-self : center;

}
#check:hover{
color : white;
background-color:skyblue;
}
.textbox {
  display:flex;
  align-items : center;
  max-height: 60px;
  margin-left:80px;
  padding: 20px 8px 4px 8px;
  width: 500px;
  height: 60px;
  position: relative;
 }
 
input {
  font-family: 'Noto Serif KR', serif;
  outline: 0;
  border: 0;
  margin:20px;
  display: block;
  width:300px;
  height : 25px;
  font-size:1em;
}

.textbox input:focus {
border-bottom: solid 2px #bdbdbd;
}
.textbox input[type="text"],
.textbox input[type="email"]{
  width: 264px;
  padding: 8px 4px 6px 4px;
  font-size: 1.2em;
  background: rgba(0,0,0,0);
  color: rgba(0,0,0,0.67);
  border-bottom: 0px solid rgba(0,0,0,0.4);
}
.textbox input[type="text"]:disabled,
.textbox input[type="email"]:disabled{
  border-bottom: 2px dotted rgba(0,0,0,0.4);
}
.textbox input[type="text"]:disabled ~ label,
.textbox input[type="email"]:disabled ~ label{
  color: rgba(0,0,0,0.4);
}
.textbox input[type="text"]~ label,
.textbox input[type="email"] ~ label{
  font-size: 1.2em;
  color: rgba(0,0,0,0.67);
  display: block;
  position: absolute;
  top: 24px;
  left: 12px;
  pointer-events: none;
  margin-right: 12px;
  transition: all 0.2s;
}
.textbox input[type="text"]~ .error,
.textbox input[type="email"] ~ .error{
  position: absolute;
  bottom: -5px;
  left: 16px;
  color: rgba(0,0,0,0);
  font-size: 0.8em;
  pointer-events: none;
  transition: all 0.2s;
}
.textbox input[type="text"]~ .error:before,
.textbox input[type="email"] ~ .error:before{
  content: '';
  display: block;
  width: 0;
  height: 2px;
  background: #2196f3;
  position: absolute;
  top: -3px;
  left: -8px;
  margin-left: 132px;
  visibility: visible;
  transition: all 0.2s;
}
.textbox input[type="text"]:not([value=""]) ~ label,
.textbox input[type="email"]:not([value=""]) ~ label{
  font-size: 0.8em;
  top: 8px;
}
.textbox input[type="text"]:focus ~ label,
.textbox input[type="email"]:focus ~ label{
  font-size: 0.8em;
  top: 8px;
}
.textbox input[type="text"]:focus ~ .error:before,
.textbox input[type="email"]:focus ~ .error:before{
  width: 264px;
  margin: 0;
}
.textbox input[type="text"]:invalid:not(:focus):not([value=""]) ~ .error,
.textbox input[type="email"]:invalid:not(:focus):not([value=""]) ~ .error{
  color: #f44336;
}
.textbox input[type="text"]:invalid:not(:focus):not([value=""]) ~ .error:before,
.textbox input[type="email"]:invalid:not(:focus):not([value=""]) ~ .error:before{
  margin: 0;
  width: 264px;
  background: #f44336;
}
.textbox input[type="text"]:valid:not(:focus) ~ .error:before,
.textbox input[type="email"]:valid:not(:focus) ~ .error:before{
  margin: 0;
  width: 264px;
  background: #4caf50;
}
.error{
width:310px;
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
    <li><a href="#">게시물관리</a></li>
    <li><a href="admin_main.me">회원관리</a></li>
    <li><a href="admin_pay.me">이용권관리</a></li>
    <li><a href="#">책임분양</a></li>
 </ul>
</nav>
</div>
<div class="container">
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
<!-- 방문자 -->

<div id= "content">
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
</body>
</html>