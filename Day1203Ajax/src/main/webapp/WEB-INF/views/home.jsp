<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<meta charset="utf-8">
	<title>데이터 베이스 연동</title>
	<style type="text/css">
		form{
		width:500px;
		margin:10px auto;
		}
		ul{
		padding: 0;
		margin: 0;
		list-style:none;
		}
		ul li{
		padding : 0;
		margin: 0 0 10px 0;
		}
		label{
		width:150px;
		float:left;
		}
		table{
		border:1px solid gray;
		width:500px;
		margin:0 auto;
		border-collapse: collapse;
		}
		td{
		border: 1px solid gray;
		}
	</style>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js">
	</script>
	<script type="text/javascript">
	//목록
	function selectData(){
		$('#output').empty(); //table 내부 내용을 제거(초기화)
		
		$.ajax({ //ajax 처리를 위한 제이쿼리 형식
			url: '/ajax/getPeopleJSON.do',
			//type:'POST', // form 양식을 통해서 데이터를 전달할때 쓰는 경우,,
			//dataType : 'json', // 서버에서 보내줄 데이터타입 >> key, value 구조로 되어있음
			/*
			{
				"employees" : [
					{
						"name" : "Surim", // 단일로 봤을때 {"키" : "값"} 
						"lasName": "Son"
					},
					{
						"name" : "Someone",
						"lastName" : "Huh"
					}
				]
			}
			키 "employees" 안에 값이 여럿 들어있을때 [] 배열구조로 생성  
			*/
			contentType: 'application/x-www-form-urlencoded:charset=utf-8',
			success: function(data){ //data >> getPeopleJSON.do에서 리턴된 데이터 값
				$.each(data, function(index, item){ //index 호출된 데이터(List<PeopleVO>), item 데이터의 요소(PeopleVO)
					var output='';
					  output += '<tr>';
			          output += '<td width = "80px">' + item.id + '</td>';
			          output += '<td width = "80px">' + item.name + '</td>';
			          output += '<td width = "80px">' + item.job + '</td>';
			          output += '<td width = "80px">' + item.address + '</td>';
			          output += '<td width = "80px">' + item.bloodtype + '</td>';
			          output += '<td width = "100px"><a href ="/ajax/getPeopleJSON.do" class="updateform_data" id=' + item.id + '>수정</a> &nbsp;&nbsp';
			          output += '<a href="/ajax/deletePeople.do" class="delete_data" id=' + item.id + '>삭제</a></td>';
			          output += '</tr>';
			          console.log("output:" + output); //F12 개발자도구에서 볼수 있음 (dom 구조로 확인가능) 동적인 내용은 소스보기에서 볼수 없음
			          $('#output').append(output); //추가
				});
			},
			error:function(){
				alert("ajax통신 실패!!!");
			}
		}); //ajax 끝
	}//페이지 로딩되고 제일 먼저 시작되는 함수(onload와 같은개념)
	$(document).ready(function(){ 
		$("#input_data").click(function(event){ //정적데이터는 이벤트 처리를 바로 가능하나 동적이면 on을 사용하여 처리
			var params = $("#insert_form").serialize(); // .serialize() : 주어진 데이터를 키, 밸류 값을 짝지어(직렬화) 가져온다
			alert(params);
			jQuery.ajax({ // $.ajax 와 동일한 표현
				url : '/ajax/insertPeople.do', 
				type :'POST',
				data : params, //서버로 보낼 데이터
				/* (참고) 파일 첨부시 필요함
				 	- cache : false 로 선언시 ajax로통신 중 cache가 남아서 갱신된 데이터를 받아오지 못할 경우를 대비
				 	- contentType : false 로 선언시 content-Type 헤더가 multipart/form-data로 전송되게 함
				 	- processData : false로 선언시 formData를 string으로 변환하지 않음
				*/
				contentType:'application/x-www-form-urlencoded;charset=utf-8',
				dataType: 'json', //서버에서 보내줄 데이터 타입
				success: function(retVal){
					if(retVal.res =="OK"){
						//데이터 성공일때 이벤트 작성
						selectData();
						//초기화
						$('#id').val('');
						$('#name').val('');
						$('#job').val('');
						$('#address').val('');
						$('#bloodtype').val('');
					}else{
						alert("Insert Fail!!!");
					}
				},
				error:function(){
					alert("ajax 통신 실패!!!");
				}
			});
			//기본 이벤트 제거
			event.preventDefault();
		});
		$(document).on('click', '.delete_data', function(event){
			jQuery.ajax({
				url: $(this).attr("href"),
				//type: 'POST',
				data : {'id' : $(this).attr("id")},
				contentType:'application/x-www-form-urlencoded;charset=utf-8',
				dataType:'json',
				success: function(retVal){
					alert(retVal);
					if(retVal.res =="OK"){ //데이터 성공일때 이벤트 작성
						console.log("AAAAAAA");
						selectData();
					}else{
						alert("Delete Fail!!!");
					}					
				},
				error:function(){
					alert("ajax 통신 실패!!!");
				}
			});
			//기본 이벤트 제거
			event.preventDefault();
		});//delete end
		selectData();
	});//ready end
	
	$(document).on('click','.updateform_data', function(event){
		$('#output').empty();
		
		var id = $(this).attr("id");
		$.ajax({
			url : $(this).attr("href"),
			type : 'POST',
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			dataType: 'json',
			success : function(data){
				$.each(data, function(index, item){
					var output = '';
					if(id != item.id){
						output += '<tr align="center">';
						output += '<td width="80">'+ item.id + '</td>';
						output += '<td width="80">'+ item.name + '</td>';
						output += '<td width="80">'+ item.job + '</td>';
						output += '<td width="80">'+ item.address + '</td>';
						output += '<td width="80">'+ item.bloodtype + '</td>';
						output += '<td width="100"><a href="/ajax/getPeopleJSON.do" class = "update_data" id='+ item.id + '>수정</a> &nbsp;&nbsp;';
				        output += '<a href="/ajax/deletePeople.do" class="delete_data" id=' + item.id + '>삭제</a></td>';
				        output += '</tr>';
					}
					else{
						output += '<tr align="center">';
						output += '<td width="80"><input type="hidden" size ="4" name="id" value="'+ item.id + '">'+ item.id + '</td>';
						output += '<td width="80"><input type="text" size ="4" name="name" value="'+ item.name + '"></td>';
						output += '<td width="80"><input type="text" size ="4" name="job" value="'+ item.job + '"></td>';
						output += '<td width="80"><input type="text" size ="4" name="address" value="'+ item.address + '"></td>';
						output += '<td width="80"><input type="text" size ="4" name="bloodtype" value="'+ item.bloodtype + '"></td>';
						output += '<td width="100"><a href="/ajax/updatePeople.do" class = "update_data" id='+ item.id + '>수정</a> &nbsp;&nbsp;';
				        output += '<a href="#" onclick="selectData()">목록</a></td>';
				        output += '</tr>';
					}
					$('#output').append(output);
				});//each 함수
			},//성공
			error : function(){
				alert("update form ajax 통신 실패");
			}
		});//ajax end
		event.preventDefault();
	});//onclick end
	
	$(document).on('click','.update_data', function(event){
		var params = $("#update_form").serialize();
		$.ajax({
			url : $(this).attr("href"),
			type : 'POST',
			data : params,
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			dataType: 'json',
			success : function(retVal){
				if(retVal.res =="OK"){
					selectData();
				}
				else{
					alert("update fail!!");
				}
			},
			error : function(){
				alert("update ajax 실패");
			}
		});//ajax 끝
		event.preventDefault();
	});//update 끝
	</script>
</head>
<body>
<form id="insert_form" method="post">
	<fieldset>
		<legend>데이터 추가</legend>
		<ul>
			<li>
				<label for="id">아이디</label>
				<input type="text" name="id" id="id">
			</li>
			<li>
				<label for="name">이름</label>
				<input type="text" name="name" id="name">
			</li>	
			<li>
				<label for="job">직업</label>
				<input type="text" name="job" id="job">
			</li>	
			<li>
				<label for="address">주소</label>
				<input type="text" name="address" id="address">
			</li>	
			<li>
				<label for="bloodtype">혈액형</label>
				<input type="text" name="bloodtype" id="bloodtype">
			</li>	
			<li>
				<input type="button" value="추가" id="input_data">
			</li>
		</ul>
	</fieldset>
</form>
<form id="update_form" method="post">
	<table id="output"></table>
</form>
</body>
</html>
