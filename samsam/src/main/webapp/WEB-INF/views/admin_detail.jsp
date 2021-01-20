<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.project.samsam.member.MemberVO"%>
<%@ page import="com.project.samsam.board.JJABoardVOto"%>
<%@ page import="com.project.samsam.board.JJABoardVO"%>
<%@ page import="com.project.samsam.board.JJWarningVO"%>
<%@ page import="com.project.samsam.board.JJCommentVO"%>

<% String email=(String) session.getAttribute("email"); 
/* 
  if (session.getAttribute("email")==null){
                    out.println("<script>");
                    out.println("location.href='loginForm.me'");
                    out.println("</script>");
                    
                    */

      MemberVO vo = (MemberVO)request.getAttribute("vo");
      JJABoardVOto bvo = (JJABoardVOto)request.getAttribute("bvo");

      ArrayList<JJWarningVO> w_docList = (ArrayList<JJWarningVO>)request.getAttribute("w_docList");
      ArrayList<JJWarningVO> w_coList = (ArrayList<JJWarningVO>)request.getAttribute("w_coList");
      JJWarningVO w_count = (JJWarningVO)request.getAttribute("w_count");

      ArrayList<JJCommentVO> cList = (ArrayList<JJCommentVO>)request.getAttribute("cList");
      JJCommentVO cvo = (JJCommentVO)request.getAttribute("covo");
	//어드민 게시글 뷰
	
	//어드민 게시글 뷰 모달

          // 클래스 변수이름 = (클래스)request.getAttribute("모델로 저장한 이름");
          // int b_no = 변수이름.getB_no();

          //email.toUpperCase();
          //<%= email.toUpperCase() 
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<link href="resources/img/title.png" rel="shortcut icon" type="image/x-icon">
<title>삼삼하개</title>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300&display=swap"
	rel="stylesheet">
<!-- 어드민페이지 -->
<link href="resources/css/admin_sidebar.css" rel="stylesheet">
<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
	integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA=="
	crossorigin="anonymous" />
<!-- 제이쿼리 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"
	integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg=="
	crossorigin="anonymous"></script>

<link href="resources/css/modal.css" rel="stylesheet" />
<link href="resources/css/ad_boardDetail.css" rel="stylesheet" />
<script src="resources/js/admin_Bdetail.js"></script>

<!-- 모달 플러그인 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<!-- 달력 -->
<link href="resources/css/datepicker.min.css" rel="stylesheet"
	type="text/css" media="all">
<script type="text/javascript" src="resources/js/datepicker.js"
	charset="UTF-8"></script>
<!-- Air datepicker js -->
<script type="text/javascript" src="resources/js/datepicker.ko.js"
	charset="UTF-8"></script>
<!-- Air datepicker js -->

<script >
	function war_detail(obj){
		var setData= {
				"number" : $(obj).attr('ww_no'),
		}
		
		
		console.log(setData.number)
	
		$.ajax({
			url : '/samsam/ad_w_detail.do',
			type : 'POST',
			data: JSON.stringify(setData),
			
			dataType: 'json',
			contentType : 'application/json;charset=utf-8',
			success : function(map){
				console.log(map);
				$('input').val("");
				//신고자
				$('#ww_no').val(map.wvo.w_no);
				$('#ww_email').val(map.wvo.w_email);
				$('#ww_date').val(map.wvo.w_date);
				$('#ww_reason').val(map.wvo.w_reason);  
				$('#ww_status').val(map.wvo.w_status);  
				
				//코멘트 작성자
				if(map.covo != null){
				$('#cc_comment').val(map.covo.co_content);
				$('#cc_email').val(map.covo.co_email);
				$('#cc_nick').val(map.covo.co_nick);
				}
				
				$('#w_detail_form').modal('show');
				alert("2222222");
				},//success
			error:function(){
				console.log("ajax 통신 실패");
			}
		})	//ajax
		
		//기본 이벤트 제거
		event.preventDefault();		
	}//war_detail
	</script>
	
<script>

	//w_status : 디폴트 1 = 대기
	//				   2 = 유지
	//				   3 = 숨김
$(document).on("click",'.auth_hide',function(event){
	var data ={
			w_no: $('#ww_no').val(),
			w_note: $('#ww_note').val(),
			w_status : $('.auth_hide').val()
	}
	console.log(data);
	alert("AAAAAAA");
	$.ajax({
		url : '/samsam/w_authOrder.do',
		type: 'POST',
		data : JSON.stringify(data),
		dataType : 'json',
		contentType : 'application/json;charset=utf-8',
		
		success : function(result) {
			alert("CCCCC");
			/*
		}
		if(result.res == 1){
			$('.status').val("숨김")
		}
		else{
			$('.status').val("업데이트실패");	
		}
		*/
		}, //success
		error : function() {
			alert("ajax 통신 실패!!!");
		}
		
		
	});
	event.preventDefault();
	
	})
$(document).on("click",'.auth_keep',function(event){
	var data ={
			w_no: $('#ww_no').val(),
			w_note: $('#ww_note').val(),
			w_status : $('.auth_keep').val()
	}
	$.ajax({
		url : '/samsam/w_authOrder.do',
		type: 'POST',
		data : JSON.stringfy(data),
		dataType : 'json',
		contentType : 'application/json;charset=utf-8',
		
		success : function(result) {
		if(result.res ==1){
			$('.status').val("유지")
		}
		else{
			$('.status').val("업데이트실패");	
		}
		}, //success
		error : function() {
			alert("ajax 통신 실패!!!");
	}
	});
	event.preventDefault();
	
})


</script>

<style>

<!-- 댓글 작성글 선택 -->
.ad_detail_contents {
display: flex;
width: 500px;
}
#ud_tab {
    max-width: 600px;
    width: 500px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    height: 300px;
}
#ud_tab input[type="radio"] {
    display: none;
}
#ud_tab label {
    display: block;
    float: left;
    width: 23.3333%;
    color: #000000;
    font-size: 20px;
    padding: 5%;
    font-weight: normal;
    text-decoration: none;
    text-align: center;
    cursor: pointer;
    background: #ffffff;
}
#ud_tab .ud_content {
    background: #fff;
    width: 90%;
    display: none;
    padding: 5%;
    float: left;
}

#ud_tab [id^="tab"]:checked + label {
	border-bottom :  3px solid  skyblue;
    background:  #ffffff;
    color:  #000000;
}
#tab1:checked ~ #ud_tab-content1,
#tab2:checked ~ #ud_tab-content2 {
    display: block;
}

/* 유지/숨김 버튼 */
.auth_hide,
.auth_keep {
    width:100px;
    background-color: #f8585b;
    border: none;
    color:#fff;
    padding: 15px 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    cursor: pointer;
}

/* 모달*/
.modal_w_view{
	display: flex;
}

</style>

</head>

<body>
	<div class="body_content">

		<header id="header">
			<div class="d-flex flex-column">
				<div class="profile">
					<h1 class="text-light">
						<a href="#" class="onMember"> </a>
					</h1>
				</div>
				<div class="admin_inout">
					<button type="button" class="grade">ADMIN</button>
					<button type="button" class="grade"
						onclick="location.href='logout.me'">LOGOUT</button>
				</div>

				<ul>
					<li><a href="adminboard.do" class="nav-menu"><i
							class="far fa-clipboard menu"></i><span class="a-menu">
								게시물관리</span></a></li>
					<li><a href="admin_main.me" class="nav-menu"><i
							class="fas fa-users menu"></i><span class="a-menu"> 회원관리</span></a></li>
					<li><a href="admin_pay.me" class="nav-menu"><i
							class="fas fa-ticket-alt menu"></i><span class="a-menu">
								이용권관리</span></a></li>
					<li><a href="adminfree_auth.me" class="nav-menu"><i
							class="fas fa-dog menu"></i><span class="a-menu"> 책임분양</span></a></li>
				</ul>
			</div>
		</header>

<div class="main_content">
	<!-- 메인컨텐트 -->

	<div class="container">
		<div class="ad_detail_contents">
			<!-- 글 -->

			<div class="navbar table">
				<div class="tableRow">
					<div class="tableCell">${bvo.doc_subject}></div>
				</div>
				<div class="tableRow">
					<div class="tableCell">${bvo.category }</div>
					<div class="tableCell">${vo.email }</div>
					<div class="tableCell">${vo.nick }</div>
				</div>
				<div class="tableRow">
					<div class="tableCell">${bvo.doc_no}</div>
					<div class="tableCell">${bvo.c_date }</div>
					<div class="tableCell">${bvo.readcount }</div>
				</div>
			</div>
			<!-- nav -->

			<div class="board_content">${bvo.c_content}</div>
			<!-- 내용 -->

			<div class="comment_list">
				<div class="comment_sur">
					<h4>comment box</h4>
					<span class="co_count"> ${cvo.co_count} </span>
				</div>

				<div class="comment_cont">
                   <div class="co_tableRow">
                   <c:forEach items ="${cList }" var ="colist">
                       <div class="coCell"> ${colist.co_content}
                       </div>
                       <span class="coCell">  ${colist.co_nick} </span>
                       <span class="coCell">   ${colist.co_date} </span>
                     </div>
                     </c:forEach>        
                </div>
           </div><!-- comment_list  -->

        </div>
        <!-- ad_board_content끝 -->

         <div class="ad_detail_contents">
           <!-- 신고목록 -->

           <div class="w_navbar">
             <!-- 신고 bar 1. 신고 건수  2. 토글: 글, 댓글  &  -->
             <div class="w_count">
               <h3>신고리스트 </h3>   ${wvo.w_count }
             </div>
              </div>
             <div class="w_btnlist">
             
				<div id="ud_tab">

  <input type="radio" name="ud_tabs" id="tab1" checked>
  <label for="tab1">작성글</label>

  <input type="radio" name="ud_tabs" id="tab2">
  <label for="tab2">작성댓글</label>

  <div id="ud_tab-content1" class="ud_content">
  <table>
  	<thead>
  		<tr><th>글번호</th><th>제목</th><th>작성일</th></tr>
  	</thead>
  	<tbody>
    <% 
    	if(w_docList != null){
    		for(JJWarningVO doc_list : w_docList){	
    %>
    	<tr class = "board">
    		<td><%=doc_list.getW_email() %></td>
    		<td><%=doc_list.getW_reason() %></td>
    		<fmt:formatDate var="formatDate" value="<%=doc_list.getW_date() %>" pattern="yyyy-MM-dd"/>
    		<td>${formatDate}</td>
    		<td><button id="modal_open_btn" onclick="war_detail(this)" ww_no = '<%=doc_list.getW_no()%>' value="상세보기" >상세보기</button></td>
    	</tr>
    <% }}%>
    </tbody>
   </table>
   <div class="error1">
  </div>
  </div>
  <div id="ud_tab-content2" class="ud_content">
    <table>
  	<thead>
  		<tr><th>내용</th><th>작성일</th></tr>	
  	</thead>
  	<tbody>
    <% 
    	if(w_coList != null){
    		for(JJWarningVO c_list : w_coList){	
    %>
    	<tr class = "comment">
    		<td><%=c_list.getW_email() %></td>
    		<td><%=c_list.getW_reason() %></td>
    		<fmt:formatDate var="formatDate" value="<%=c_list.getW_date()%>" pattern="yyyy-MM-dd"/>
    		<td>${formatDate}</td>
    		<td><button id="modal_open_btn"  rel="modal:open" onclick="war_detail(this)" ww_no ='<%=c_list.getW_no()%>'>상세보기</button></td>
    	</tr>
    <% }}%>
    </tbody>
   </table>
   <br>
    <div class="error2">
  </div>
  </div>
</div>
               
 </div><!-- w_btnlist -->
          

           
         </div>
         <!-- ad_detail_contents 끝 -->

       </div>
       <!-- container 끝 -->


    </div><!-- 메인컨텐트 끝 -->

    </div><!-- 바디컨텐트 -->

     <!-- 모달 내용 -->
     <form id="w_detail_form" class="modal">

       <div class="modal_w_view">
       		<div class="w_info">
       			<div class="w_reason">
       				<label>신고번호</label><input type="hidden" id ="ww_no" readonly >
       				<label>신고자</label><input type="text" id ="ww_email" readonly >
					<label>닉네임</label><input type="text" id ="ww_date" readonly >
					<label>신고사유</label><input type="text" id ="ww_reason" readonly>       			
					<label>상태</label><input type="text" id ="ww_status" readonly>       			
       			</div>
       			<div class="w_co_cont">
       				<label>댓글내용</label><input type="text" id ="cc_comment" readonly> 
       				<label>작성자</label><input type="text" id ="cc_email" readonly> 
       				<label>닉네임</label><input type="text" id ="cc_nick" readonly> 
       			</div>
       		</div>
       		<div class="w_info">
       			<div class="auth_write">
       				<input type="text" class="w_note" placeholder="처리 내용을 입력하세요">
       			</div>
       			<div class="auth_btn">
       				<fieldset id ="btn_fieldset">
					<button class ="auth_hide" value="숨김">숨김</button> 
					<button class="auth_keep" value="유지">유지</button>
					</fieldset>
       			</div>
       		</div>
       
       </div><!-- modal_w_view -->
         

     </form>
     <!-- #modal 끝 -->
     
   </body>

   </html>