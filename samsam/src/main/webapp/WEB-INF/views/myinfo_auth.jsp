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

.textbox {
  display: block;
  max-height: 60px;
  margin:0;
  padding: 20px 8px 4px 8px;
  width: 500px;
  height: 60px;
  position: relative;
  align-self : center;
 }
 
input {
  font-family: 'Noto Serif KR', serif;
  outline: 0;
  border: 0;
  margin:20px;
  display: block;
  width:270px;
  height : 25px;
  font-size:1em;
}
.auth{
align-self : center;
margin-right : 80px;
height:43px;
border : 1px solid skyblue;
background-color : rgba(0,0,0,0);
color : skyblue;
padding : 5px;
border-radius : 5px;
align-self : center;
}
.auth:hover{
color : white;
background-color:skyblue;
}

 
.textbox input:focus {
border-bottom: solid 2px #bdbdbd;
}
.textbox{
display:flex;
align-items : center;
}
.textbox input[type="button"] { 
display: inline-block; 
padding: .5em .75em; 
width:57px;
height:41px;
margin:0px;
color: #999; 
font-size: inherit; 
line-height: normal; 
vertical-align: middle; 
background-color: #fdfdfd; 
cursor: pointer; 
border: 1px solid #ebebeb; 
border-bottom-color: #e2e2e2; 
border-radius: .25em; 
} 
.textbox input[type="file"] { 
position: absolute; 
width: 1px; 
height: 1px; 
padding: 0; 
overflow: hidden; 
clip:rect(0,0,0,0); 
border: 0; 
} 

.textbox[name="button_1"] label[for="ex_filename"] { 
display: inline-block; 
padding: .5em .15em; 
width:50px;
height:28px;
color: #999; 
font-size: inherit; 
text-align:center;
line-height: normal; 
vertical-align: middle; 
background-color: #fdfdfd; 
cursor: pointer; 
border: 1px solid #ebebeb; 
border-bottom-color: #e2e2e2; 
border-radius: .25em; 
}
/* named upload */ 
.textbox .upload-name {
display: inline-block; 
padding: .5em .15em;  /* label의 패딩값과 일치 */ 
font-size: inherit; 
font-family: inherit; 
line-height: normal; 
vertical-align: middle; 
background-color: #f5f5f5; 
border: 1px solid #ebebeb; 
border-bottom-color: #e2e2e2; 
border-radius: .25em;
appearance: none; 
}
h6{
padding-left: 23px;
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
<label>사업장명</label><input id = "biz_com" name="biz_com" type="text" value ="자박">
</div>
<div class="textbox" name="button_1">
<label>관리번호</label>
<input id="biz_no" name="biz-no" type="password">
<input type = "button" value="확인" onclick="">
</div>
<div class="textbox" name="button_1">
<label>허가증</label>&nbsp;&nbsp;&nbsp;
<input class="upload-name" name="biz_img" value="파일선택" disabled="disabled">
<label for="ex_filename">첨부</label> <input type="file" id="ex_filename" class="upload-hidden">
</div>
<input class="auth" type = "button" value="인증하기" onclick="">
<h6>*인증완료까지 최대 3영업일이 소요될수 있습니다.</h6>
</form>
</div>
</body>
</html>