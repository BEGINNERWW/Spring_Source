$(document).ready(function(){
$('#login').on('click', function(e){
      $('#logout').show();
	  $('#mypage').show();
	  $('#login').hide();
	  $('#signin').hide();
  });
}) //헤더 상단 로그인 체인지

$(document).ready(function(){
$('#logout').on('click', function(e){
       $('#logout').hide();
	   $('#mypage').hide();
	   $('#login').show();
	   $('#signin').show();
	});
}) //헤더 상단 로그아웃 체인지
