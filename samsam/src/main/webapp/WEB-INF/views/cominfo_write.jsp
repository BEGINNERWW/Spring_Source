<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.project.samsam.member.MemberVO"%>
<%@ page import="com.project.samsam.member.Biz_memberVO"%>
<%@ page import="com.project.samsam.member.Adopt_BoardVO"%>
<%@ page import="com.project.samsam.member.BoardlistVO"%>
<%@ page import="com.project.samsam.member.CommentListVO"%>


<%
	String email = (String) session.getAttribute("email");

	if (session.getAttribute("email") == null){
		out.println("<script>");
		out.println("location.href='loginForm.me'");
		out.println("</script>");
	}
	ArrayList<BoardlistVO> boardlist = (ArrayList<BoardlistVO>)request.getAttribute("b_list");
	ArrayList<CommentListVO> commentlist = (ArrayList<CommentListVO>)request.getAttribute("c_list");

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
<script>
$(document).ready(function(){
    var start = 5;
    
	$(".board").slice(5).hide(); 

	$("#check1").click(function(e){
		e.preventDefault();
    	start += 5;
		$(".board").slice(0,start).show();
   	
		if($(".board").length <= start){
			$(".error1").html("더이상 표시할 내용이 없습니다.");
    	};
	});
	
	$(".comment").slice(5).hide(); 

	$("#check2").click(function(e){
		e.preventDefault();
    	start += 5;
		$(".comment").slice(0,start).show();
   	
		if($(".comment").length <= start){
			$(".error2").html("더이상 표시할 내용이 없습니다.");
    	};
	});
});
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
#check1:hover,
#check2:hover{
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

.error1, .error2{
font-size: 0.9em;
color : red;
padding-left: 0px;
text-align : left;
}

<!-- 댓글 작성글 선택 -->

#ud_tab {
    max-width: 600px;
    width: 90%;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    height: 300px;
}
#ud_tab input[type="radio"] {
    display: none;
}
#ud_tab label {
    display: block;
    float: left;
    width: 23.3333%;
    color: #000000;
    font-size: 20px;
    padding: 5%;
    font-weight: normal;
    text-decoration: none;
    text-align: center;
    cursor: pointer;
    background: #ffffff;
}
#ud_tab .ud_content {
    background: #fff;
    width: 90%;
    display: none;
    padding: 5%;
    float: left;
}

#ud_tab [id^="tab"]:checked + label {
	border-bottom :  3px solid  skyblue;
    background:  #ffffff;
    color:  #000000;
}
#tab1:checked ~ #ud_tab-content1,
#tab2:checked ~ #ud_tab-content2 {
    display: block;
}

 table {
    width: 100%;
    border-top: 1px solid #c2c2d6;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #c2c2d6;
    padding: 10px;
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
<div id="ud_tab">

  <input type="radio" name="ud_tabs" id="tab1" checked>
  <label for="tab1">작성글</label>

  <input type="radio" name="ud_tabs" id="tab2">
  <label for="tab2">작성댓글</label>

  <div id="ud_tab-content1" class="ud_content">
  <table>
  	<thead>
  		<tr><th>글번호</th><th>제목</th><th>작성일</th></tr>
  	</thead>
  	<tbody>
    <% 
    	if(boardlist != null){
    		for(BoardlistVO b_list : boardlist){	
    %>
    	<tr class = "board">
    		<td><%=b_list.getNum() %></td>
    		<td><%=b_list.getSubject() %></td>
    		<fmt:formatDate var="formatDate" value="<%=b_list.getWrite_date()%>" pattern="yyyy-MM-dd"/>
    		<td>${formatDate}</td>
    	</tr>
    <% }}%>
    </tbody>
   </table>
   <input type="button" id="check1" value="더보기"><br>
   <div class="error1">
  </div>
  </div>
  <div id="ud_tab-content2" class="ud_content">
    <table>
  	<thead>
  		<tr><th>내용</th><th>작성일</th></tr>
  	</thead>
  	<tbody>
    <% 
    	if(commentlist != null){
    		for(CommentListVO c_list : commentlist){	
    %>
    	<tr class = "comment">
    		<td><%=c_list.getContent() %></td>
    		<fmt:formatDate var="formatDate" value="<%=c_list.getWrite_date()%>" pattern="yyyy-MM-dd"/>
    		<td>${formatDate}</td>
    	</tr>
    <% }}%>
    </tbody>
   </table>
   <input type="button" id="check2" value="더보기">
   <br>
    <div class="error2">
  </div>
  </div>
</div>
</form>
</div>
</body>
</html>