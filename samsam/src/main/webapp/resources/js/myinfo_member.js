	function isSame() {
		console.log("pw:" + $('#pw').val() + "pw2:" + $('#pw2').val())
		if ($('#pw').val() != '' && $('#pw2').val() != '') {
			if ($('#pw').val() == $('#pw2').val()) {
				$('#same').html('비밀번호가 일치합니다.');
				$('#same').css("color", "blue");
			} else {
				$('#same').html('비밀번호가  일치하지 않습니다');
				$('#same').css("color", "red");
			}
		}
	}
	
		$(document).ready(function() {
			function btn_disable(){
				var check_btn = document.getElementById('check');
				if($('#pw').val() == "" || $('#pw2').val() == ""){
					check_btn.disabled = true;
				}else if($('#same').val() == "비밀번호가  일치하지 않습니다"){
					check_btn.disabled = true;
				}
				else{
					check_btn.disabled = false;
				}
			}
			btn_disable();

			$('#pw2').keyup(function () {
				btn_disable();
			});
		$("#check").click(function(event) { //정적데이터는 이벤트 처리를 바로 가능하나 동적이면 on을 사용하여 처리
			if($('#pw').val().length >= 6 && $('#pw').val().length <=15){
				console.log("pw 길이 " + $('#pw').val().length)
			if($('#pw').val() == $('#pw2').val()){
				console.log("true")
			var params = $(".content").serialize(); // .serialize() : 주어진 데이터를 키, 밸류 값을 짝지어(직렬화) 가져온다
			console.log(params);
			jQuery.ajax({ // $.ajax 와 동일한 표현
					url : '/samsam/myinfo_update.do',
					type : 'POST',
					data : params, //서버로 보낼 데이터
					/* (참고) 파일 첨부시 필요함
					- cache : false 로 선언시 ajax로통신 중 cache가 남아서 갱신된 데이터를 받아오지 못할 경우를 대비
					- contentType : false 로 선언시 content-Type 헤더가 multipart/form-data로 전송되게 함
					- processData : false로 선언시 formData를 string으로 변환하지 않음
					*/
					dataType : 'json', //서버에서 보내줄 데이터 타입
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(result) {
							if (result.res == "OK") {
								//데이터 성공일때 이벤트 작성
								swal("","회원정보가 수정되었습니다.","success");
							} else {
								console.log("업데이트 실패!!");
							}
					},
					error : function() {
						swal("","ajax 통신 실패!!!","error");
					}
			});
			//기본 이벤트 제거
			event.preventDefault();
			}}});
	});