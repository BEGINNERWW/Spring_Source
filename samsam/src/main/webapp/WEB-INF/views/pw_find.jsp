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
    <li><a href="#">책임분양관리</a></li>
    <li><a href="#">회원정보</a></li>
    <li><a href="#">작성글관리</a></li>
    <li><a href="#">판매허가번호인증</a></li>
 </ul>
</nav>
</div>
<form class = "content" action="pw_auth.me" method="post">
<div class="textbox">
  <label for="text">이름</label>
  <input id="text" name=name required="" type="text" />
   <div class="error">
    이름을 입력하세요
  </div>
 </div>
<div class="textbox">
  <label for="email">이메일</label>
  <input id="email" name=email required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i" type="email" />
  <div class="error">
    유효하지 않은 이메일주소 입니다
  </div>
</div>
 <br>
   <input type="submit" id="check" value="비밀번호찾기">
</div>
</form>
</div>
</body>
</html>