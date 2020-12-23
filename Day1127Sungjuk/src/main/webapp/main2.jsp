<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String hakbun =null;

if(session.getAttribute("hakbun")!=null){
	hakbun=(String)session.getAttribute("hakbun");
}else{
	out.println("<script>");
	out.println("location.href='loginform.me'");
	out.println("</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리 시스템 메인 페이지</title>
</head>
<body align = "center">
<h3><%=hakbun %> 로 로그인하셨습니다.</h3><br><br>
<%if(hakbun.equals("admin")){%>
<a href = "memberlist.me"> 관리자모드 접속(학생목록 보기)</a><br><br>
<a href = "sungjuklist.me"> 관리자모드 접속(성적목록 보기)</a>

<%} else{%>
<a href = "memberinfo.me"> 내정보 및 성적열람 </a>
<%} %>

</body>
</html>