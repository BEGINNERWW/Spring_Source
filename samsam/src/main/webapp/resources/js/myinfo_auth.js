$(document).ready(function(){
	   var fileTarget = $('.textbox .upload-hidden');

	    fileTarget.on('change', function(){
	        if(window.FileReader){
	            // 파일명 추출
	            var filename = $(this)[0].files[0].name;
	        } 

	        else {
	            // Old IE 파일명 추출
	            var filename = $(this).val().split('/').pop().split('\\').pop();
	        };

	        $(this).siblings('.upload-name').val(filename);
	    });
	});
	
$(document).ready(function() {
	$(".check").click(function(event) { //정적데이터는 이벤트 처리를 바로 가능하나 동적이면 on을 사용하여 처리
		var biz_no = $('#biz_no').val();
		var biz_com= $('#biz_com').val();
		console.log($('#biz_no').val());
		jQuery.ajax({ // $.ajax 와 동일한 표현
				url : '/samsam/biz_check.do',
				type : 'POST',
				data : {"biz_no" : biz_no,
					"biz_com" : biz_com }, //서버로 보낼 데이터
				/* (참고) 파일 첨부시 필요함
				- cache : false 로 선언시 ajax로통신 중 cache가 남아서 갱신된 데이터를 받아오지 못할 경우를 대비
				- contentType : false 로 선언시 content-Type 헤더가 multipart/form-data로 전송되게 함
				- processData : false로 선언시 formData를 string으로 변환하지 않음
				*/
				dataType : 'json', //서버에서 보내줄 데이터 타입
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(result) {
					    $('.error').text("")
						if(result.res == "OK"){
						    $('.error').html("허가증을 업로드하고 인증하기를 클릭하세요")
						}
						else if (result.res == "dont") {
							swal("","이미 등록된 판매허가번호입니다. 다시 확인해주세요.","error");
						} else {
							console.log(result.res);
							console.log("업데이트 실패!!");
							$('.error').text("관리번호를 다시 확인해주세요")
						}
				},
				error : function() {
						alert("ajax 통신 실패!!!");
				}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
});

function formsubmit(){
	if($("#biz_com").val() != "" && $("#biz_no").val() != "" && $("#ex_filename").val() !=""){
		if($(".error").text() =="허가증을 업로드하고 인증하기를 클릭하세요"){
			content.submit();
		}
		else{
			console.log($("#biz_com").val() + "biz_no :" + $("#biz_no").val() + "file : "+ $("#ex_filename").val())
			console.log($(".error").text())
			swal("","모든 항목을 입력해주세요.","info");
			
		}
	}else{	
		swal("","모든 항목을 입력해주세요.","info");
	}
}