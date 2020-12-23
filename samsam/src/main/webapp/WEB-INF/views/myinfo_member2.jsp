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
$(".textbox input").attr("value", "");
$(".textbox input").attr("onkeyup", "this.setAttribute('value', this.value);");

function check(){
	
}
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
padding : 5px;
border-radius : 5px;
align-self : center;

}
#check:hover{
color : white;
background-color:skyblue;
}
input {
  font-family: 'Noto Serif KR', serif;
  outline: 0;
  border: 0;
  display: block;
  height : 40px;
  font-size:1em;
}
.textbox {
  display: block;
  max-height: 60px;
  padding: 20px 8px 4px 8px;
  width: 264px;
  height: 60px;
  position: relative;
  align-self : center;
  
}
.textbox input:focus {
border-bottom: solid 2px #bdbdbd;
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
    <li><a href="#">책임분양관리</a></li>
    <li><a href="#">회원정보</a></li>
    <li><a href="#">작성글관리</a></li>
    <li><a href="#">판매허가번호인증</a></li>
 </ul>
</nav>
</div>
<form class = "content">
<div class="textbox">
<label>아이디/이메일</label>&nbsp;&nbsp;  
<input id="email" required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i" type="text" autofocus/>
</div>
<div class="textbox">
<label>비밀번호</label>&nbsp;&nbsp;<input id="pw" type="password">
</div>
<div class="textbox">
<label>이름</label>&nbsp;&nbsp;<input id="name" type="text" readonly>
</div>
<div class="textbox">
<label>닉네임</label>&nbsp;&nbsp;<input id="nick" type="text">
</div>
<div class="textbox">
<label>휴대폰번호</label>&nbsp;&nbsp;<input id="phone" type="text">
</div>
<div class="textbox">
<label>지역</label>&nbsp;&nbsp;<input id="local" type="text">
</div><br>
<button id="check" type = "button" onclick="dddd">회원정보수정 </button>
</form>
</div>
</body>
</html>