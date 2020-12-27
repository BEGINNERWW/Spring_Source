<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String email = (String)session.getAttribute("email");
System.out.println("email : "+ email);
System.out.println("session email : "+ session.getAttribute("email"));

if(session.getAttribute("email")!=null){
	email=(String)session.getAttribute("email");
}else{
	out.println("<script>");
	out.println("location.href='loginForm.me'");
	out.println("</script>");
}
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
}
.textbox {
  display: block;
  max-height: 48px;
  padding: 20px 8px 4px 8px;
  width: 264px;
  height: 48px;
  position: relative;
  align-self : center;
  
}
.textbox input[type="email"],
.textbox input[type="password"] {
  width: 256px;
  padding: 8px 4px 6px 4px;
  font-size: 1.2em;
  background: rgba(0,0,0,0);
  color: rgba(0,0,0,0.67);
  border-bottom: 0px solid rgba(0,0,0,0.4);
}

.textbox input[type="email"]:disabled,
.textbox input[type="password"]:disabled {
  border-bottom: 2px dotted rgba(0,0,0,0.4);
}

.textbox input[type="email"]:disabled ~ label,
.textbox input[type="password"]:disabled ~ label {
  color: rgba(0,0,0,0.4);
}

.textbox input[type="email"] ~ label,
.textbox input[type="password"] ~ label {
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

.textbox input[type="email"] ~ .error,
.textbox input[type="password"] ~ .error {
  position: absolute;
  bottom: -5px;
  left: 16px;
  color: rgba(0,0,0,0);
  font-size: 0.8em;
  pointer-events: none;
  transition: all 0.2s;
}

.textbox input[type="email"] ~ .error:before,
.textbox input[type="password"] ~ .error:before {
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

.textbox input[type="email"]:not([value=""]) ~ label,
.textbox input[type="password"]:not([value=""]) ~ label {
  font-size: 0.8em;
  top: 8px;
}

.textbox input[type="email"]:focus ~ label,
.textbox input[type="password"]:focus ~ label {
  font-size: 0.8em;
  top: 8px;
}

.textbox input[type="email"]:focus ~ .error:before,
.textbox input[type="password"]:focus ~ .error:before {
  width: 264px;
  margin: 0;
}

.textbox input[type="email"]:invalid:not(:focus):not([value=""]) ~ .error,
.textbox input[type="password"]:invalid:not(:focus):not([value=""]) ~ .error {
  color: #f44336;
}

.textbox input[type="email"]:invalid:not(:focus):not([value=""]) ~ .error:before,
.textbox input[type="password"]:invalid:not(:focus):not([value=""]) ~ .error:before {
  margin: 0;
  width: 264px;
  background: #f44336;
}

.textbox input[type="email"]:valid:not(:focus) ~ .error:before,
.textbox input[type="password"]:valid:not(:focus) ~ .error:before {
  margin: 0;
  width: 264px;
  background: #4caf50;
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
    <li><a href="myinfo_member.me">회원정보</a></li>
    <li><a href="#">작성글관리</a></li>
    <li><a href="#">판매허가번호인증</a></li>
 </ul>
</nav>
</div>
<form class = "content" action="myinfo_member.me" method="post">
<div class="textbox">
  <input id="email" name=email type="email" value=<%=email %> readonly/>
  <label for="email">아이디/이메일</label>
  <div class="error">
    Invalid email address
  </div>
</div>
<div class="textbox">
  <input id="password" name=pw required="" type="password" /><label for="password">비밀번호</label>
  <div class="error">
    Invalid password
  </div>
 </div>
 <br>
   <input type="submit" id="check" value="확인">
</div>
  </form>
</body>
</html>