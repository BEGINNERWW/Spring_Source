<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page session="true" %>
<%
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("id") == null){
		out.println("<script>");
		out.println("location.href='loginForm.do'");
		out.println("</script>");
	}
	String id= (String)session.getAttribute("id");
	String name=(String)session.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>web socket</title>
<script>
	var log= function(s){
		document.getElementById("output").textContent += (s+ "\n");
	}
	w = new WebSocket("ws://localhost:8080/springwebsocket2/broadcasting.do");
	w.onopen = function(){
		alert('WebSocket Connected');
	}
	w.onmessage = function(e){ //웹소켓에서 보낸 메세지를 전달 받음
		log(e.data.toString());
	}
	w.onclose = function(e){
		log("WebSocket Closed");
	}
	w.onerror = function(e){
		log('WebSocket error : ' + e.data);
	}
	
	window.onload = function(){
		document.getElementById("send_button").onclick = function(){
		var input = document.getElementById("input").value;
		w.send("<%=id%>" + ">" + input); //웹소캣 객체에서 서버로 전달
		document.getElementById("input").value = "";
		}
	}
</script>
</head>
<body>
	<input type="text" id ="input" placeholder="input message" size = '55'/>
	<button id="send_button"> SEND</button>
	대화명 : <%=id %>
	<p/>
	<textarea id="output" readonly rows= "30" cols="80"></textarea>
</body>
</html>