$(document).ready(function() {

	$("#check").click(function(event) { //정적데이터는 이벤트 처리를 바로 가능하나 동적이면 on을 사용하여 처리
		$('#result').empty();
		if($('#fromDate').val() == null) { 
			 $('#fromDate').val('')
		}
		if($('#toDate').val() == null) { 
			 $('#toDate').val('')
		}
		var temp ="";
		var temp1 ="";
		var temp2 ="";
		var temp3 ="";
		
		//체크박스 체크확인
		if($('input:checkbox[name="member_grade1"]').is(":checked") ==  true){
			temp1 = $('input:checkbox[name="member_grade1"]').val();	
		};
		if($('input:checkbox[name="member_grade2"]').is(":checked") ==  true){
			temp2 = $('input:checkbox[name="member_grade2"]').val();
		};	
		if($('input:checkbox[name="member_grade3"]').is(":checked") ==  true){
			temp3 = $('input:checkbox[name="member_grade3"]').val();
		};
		if(temp1 == null && temp2 == null && temp3 == null) { 
			temp = "대기";
		}
		
		var data = {
			"fromDate" : $('#fromDate').val(),
			"toDate" : $('#toDate').val(),
			"member_grade" : temp,
			"member_grade1" : temp1,
			"member_grade2" : temp2,
			"member_grade3" : temp3,
			"keyword" : $('#keyword').val()
		}
		var params = $("#content").serialize(); // .serialize() : 주어진 데이터를 키, 밸류 값을 짝지어(직렬화) 가져온다
		console.log(data);
		jQuery.ajax({ // $.ajax 와 동일한 표현
				url : '/samsam/search_member.do',
				type : 'POST',
				data : JSON.stringify(data), //서버로 보낼 데이터
				dataType : 'json', //서버에서 보내줄 데이터 타입
				contentType : 'application/json;charset=utf-8',
				success : function(mvo) {
					$('#result').empty();
				
					$.each(mvo, function(index, item){
						console.log(item.signdate);
			
						$('#result').html($('#result').html()+'<tr><td><a href="javascript:void(0);" onclick="member_detail(this);" value = "'+ item.email+'">' + item.grade+'</td></a><td class="email"><a href="javascript:void(0);" onclick="member_detail(this);" value = "'+ item.email+'">' + item.email +'</td></a><td><a href="javascript:void(0);" onclick="member_detail(this);" value = "'+ item.email+'">' + item.nick +'</td></a><td><a href="javascript:void(0);" onclick="member_detail(this);" value = "'+ item.email+'">' + item.local + '</td></a><td><a href="javascript:void(0);" onclick="member_detail(this);" value = "'+ item.email+'">'
								 + item.signdate + '</td></a><td><a href="javascript:void(0);" onclick="member_detail(this);" value = "'+ item.email+'">' + item.wcount +'</td></a></tr>')
					});
					
					var app = "<tr><td class='tb-bottom' colspan = 6><input type='button' class ='before-btn' value = '이전'><input type='button' class = 'after-btn' value = '다음'></td></tr>"
					$("#result").append(app);
					$("#result").slice(10).hide();

				},
				error : function() {
						alert("ajax 통신 실패!!!");
				}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	
}); //레디
var count = 10;
var page = 0;
$(document).on("click", ".before-btn",function(event) {
	if(count > 10){
		count -= 10
		page -= 1
		$("#result").slice(page*10,count).show();
	}
	else{
		swal("","첫 페이지 입니다.","info")
	}
	event.preventDefault();
});

$(document).on("click", ".after-btn",function(event) {
	count += 10
	page += 1
	$("#result").slice(page*10,count).show();
	if($("#result").length <= count){
		console.log($("#result").length)
		swal("","마지막 페이지 입니다.","info")
	}
	event.preventDefault();
});


function member_detail(obj) {
	
	function fieldsetDisable()  {
		  const fieldset = document.getElementById('btn_fieldset');
		  if($('.status').val() == "완료" || $('.status').val() == "미제출" ){
		  fieldset.disabled = true;
		  }
	}
	
	var email = $(obj).attr('value');
	console.log("제발 " + email)
	$.ajax({
		url : '/samsam/member_detail.do',
		type : 'POST',
		data : JSON.stringify(email), //서버로 보낼 데이터
		dataType : 'json', //서버에서 보내줄 데이터 타입
		contentType : 'application/json;charset=utf-8',
		success : function(map) {
			console.log("map : " + map)
			$('.modal-detail').val("");
			$('.w-table').empty();
			$('.b-table').empty();
			$('.c-table').empty();
			$('#biz_com').empty("");
			$('#biz_no').empty(""); 
			$('#biz_img').empty("");
			
			$('#email').val(map.MemberVO.email);
			$('#nick').val(map.MemberVO.nick);
			$('#phone').val(map.MemberVO.phone);
			$('#local').val(map.MemberVO.local);
			$('#grade').val(map.MemberVO.grade);
			$('#wcount').val(map.MemberVO.wcount);
			
			if(map.Biz_memberVO != null){
			$('#biz_com').html(map.Biz_memberVO.biz_com);
			$('#biz_no').html(map.Biz_memberVO.biz_no);
			$('#biz_img').html(map.Biz_memberVO.biz_img);
						
			if(map.Biz_memberVO.status == 0){
				console.log("map.Biz_membeerVO.status : " + map.Biz_memberVO.status )
				$('.status').val("완료");
				fieldsetDisable();
			}
			else if($('#biz_com').val() == "" && $('#biz_no').val() == "" && $('#biz_img').val() ==""){
				$('.status').val("미제출");
				fieldsetDisable();
			}
			}else{
				$('.status').val("미제출");
				fieldsetDisable();
			}
			
			if(map.Boardlist != null && map.Boardlist != ""){
			$.each(map.Boardlist, function(index, item){
				console.log("map.Boardlist : " + map.Boardlist);
				var date = item.write_date.substr(0,10)
				$('.b-table').html($('.b-table').html()+'<tr class="result-table-row"><td class="result-table-cell"><a href="#">'+ item.num+'</a></td><td class="result-table-cell"><a href="#">' + item.subject+'</a></td><td class="result-table-cell"><a href="#">' + date +'</a></td></tr>')
			});//map.Boardlist each
			}else{
				$('.b-table').html($('.b-table').html()+'<tr class="result-table-row"><td colspan="3" class="result-table-cell">작성글이 없습니다</td></tr>')	
			}
			
			if(map.Commentlist != null && map.Commentlist != ""){
			$.each(map.Commentlist, function(index, item){
				var date = item.write_date.substr(0,10)
				$('.c-table').html($('.c-table').html()+'<tr class="result-table-row"><td class="result-table-cell"><a href="#">'+ item.content+'</a></td><td class="result-table-cell"><a href="#">' + date+'</a></td></tr>')
			}); //map.Commentlist each
			}else{
				$('.c-table').html($('.c-table').html()+'<tr class="result-table-row"><td colspan="2" class="result-table-cell">작성댓글이 없습니다</td></tr>')	
			}
			
			$('.b-table .result-table-row').slice(5).hide();
			$('.c-table .result-table-row').slice(5).hide();
			$('#detail-form').modal('show');
			
			/*$.each(map, function(index, item){
				console.log(index)
				console.log(item)
				if(item.email != null || item.biz_email != null || item.content != null || item.no != null){
					$('#email').val(item.email);
					$('#nick').val(item.nick);
					$('#phone').val(item.phone);
					$('#local').val(item.local);
					console.log(item.local + item.grade)
					$('#grade').val(item.grade);
					$('#wcount').val(item.wcount);
					
					$('#biz_com').html(item.biz_com);
					$('#biz_no').html(item.biz_no);
					$('#biz_img').html(item.biz_img);
					
					if(item.status == "0"){
						$('.status').val("완료");
						fieldsetDisable();
					}
					if($('#biz_com').val() == "" && $('#biz_no').val() == "" && $('#biz_img').val() ==""){
						$('.status').val("미제출");
						fieldsetDisable();
					}
					console.log("어레이 인덱스 :" + index + " map.item :" + item)
				}
				$('#detail-form').modal('show');
			//	})//each
			});//each
			$.each(map.Boardlist, function(index){
				console.log(map.Boardlist)
				$('.b-table').html($('.b-table').html()+'<div class="result-table-row">'+ index.num+'<div class="result-table-cell"><a href="#">' + index.subject+'</a></div><div class="result-table-cell">' + index.write_date +'</div>')
			})
				
			$.each(map.Commentlist, function(index){
				console.log(map.Commentlist)
				$('.c-table').html($('.c-table').html()+'<div class="result-table-row"><a href="#">'+ index.content+'</a><div class="result-table-cell">' + index.write_date+'</div>')
			})		*/	
		},
		error : function() {
				alert("ajax 통신 실패!!!");
		}
	})//ajax
}//회원상세
$(document).on("click", ".auth_confirm", function(event){
	var email = $('#email').val();
	$.ajax({
		url : '/samsam/auth_confirm.do',
		type : 'POST',
		data : JSON.stringify(email), //서버로 보낼 데이터
		dataType : 'json', //서버에서 보내줄 데이터 타입
		contentType : 'application/json;charset=utf-8',
		success : function(result) {
			if(result.res == 1){
				$('.status').val("완료");
			}
			else{
				$('.status').val("업데이트실패");
			}
				
		},
		error : function() {
				alert("ajax 통신 실패!!!");
		}
	})//ajax
	
}) //모달 완료 버튼
$(document).on("click", ".auth_return", function(event){
	var email = $('#email').val();
	$.ajax({
		url : '/samsam/auth_return.do',
		type : 'POST',
		data : JSON.stringify(email), //서버로 보낼 데이터
		dataType : 'json', //서버에서 보내줄 데이터 타입
		contentType : 'application/json;charset=utf-8',
		success : function(result) {
			if(result.res == 1){
				$('.status').val("반려");
			}
			else{
				$('.status').val("삭제실패");
			}
		},
		error : function() {
				alert("ajax 통신 실패!!!");
		}
	})//ajax
		
}) //모달 반려 버튼