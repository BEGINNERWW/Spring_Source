<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOME</title>
</head>
<body>
<h1>Hello world! File Upload!!</h1>
<form id="multiform" action = "fileUpload2.bo" method="post" enctype="multipart/form-data">
이름 : <input type="text" name= "name"/><br/><br/>
<!-- multiple="multiple" : 다중 파일 업로드를 위해서 사용 -->
파일 : <input type="file" name ="file" multiple="multiple"/><br/><br/>
	<input type="button" value="다중업로드1" onclick="fnAction('fileUpload1.bo')"/>
	<input type="button" value="다중업로드2" onclick="fnAction('fileUpload2.bo')"/>
</form>
<script type="text/javascript">
function fnAction(url){
	var frm = document.getElementById("multiform");
	frm.action = url;
	frm.submit();
}
</script>
</body>
</html>