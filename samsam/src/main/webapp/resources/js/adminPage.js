$(document).ready(function(){
    //$('classNAME or element').hover(A, B);
    $('ul li a').hover(
      function(event){
        $(this).addClass('hover');
      },
      function(){
        $(this).removeClass('hover');
      }
    );
  });

// To do List 
$(document).ready(function(){
	
	jQuery.ajax({ // $.ajax 와 동일한 표현
		url : '/samsam/todo_select.do',
		type : 'POST',
		dataType : 'json', //서버에서 보내줄 데이터 타입
		contentType : 'application/json;charset=utf-8',
		success : function(map) {
			console.log(map);
			if(map.todolist != null){
			$.each(map.todolist, function(index, item){
			//Task에 입력 값 넣기
			   var task = $("<div class='task'></div>").text(item.to_do);
			//삭제버튼
			   var del = "<i class='fas fa-trash-alt'></i>"
			//체크 버튼
			   var check = "<i class='fas fa-check'></i>"
			      
			      //Task에 삭제 & 체크 버튼 추가하기
			      task.append(del,check)
			if(item.status == "MustDo"){  
			      //할일 목록에 추가
			      $(".notdone").append(task); 
			}else if(item.status =="Done"){
				  $(".done").append(task); 
			}
			})//each
			}//if
		},
		error : function() {
			console.log("todo select ajax실패!!!");
		}
	});	
	
$(".txt").on("keyup",function(e){
    if(e.keyCode == 13 && $(".txt").val() != ""){
    	console.log("text: "+ $('.txt').val())
    	var data = {
    		"to_do" : $('.txt').val(),
    		}
    	console.log(data);
    	jQuery.ajax({ // $.ajax 와 동일한 표현
    		url : '/samsam/todo_insert.do',
    		type : 'POST',
    		data : JSON.stringify(data), //서버로 보낼 데이터
    		dataType : 'json', //서버에서 보내줄 데이터 타입
    		contentType : 'application/json;charset=utf-8',
    		success : function(map) {
    			console.log(map.result);
    		},
    		error : function() {
    			console.log("todo insert ajax실패!!!");
    		}
    	});	
    	
      //Task에 입력 값 넣기
      var task = $("<div class='task'></div>").text($(".txt").val());
      //삭제버튼
      var del = "<i class='fas fa-trash-alt'></i>"
      
      //체크 버튼
      var check = "<i class='fas fa-check'></i>"
      
      //Task에 삭제 & 체크 버튼 추가하기
      task.append(del,check)
	  
      //할일 목록에 추가
      $(".notdone").append(task);
      
      //입력 창 비우기
      $(".txt").val("");
    }
  });
  
  $(document).on('click', '.fa-check', function(e){
  	console.log($(this).parent('.task').text())
  	var data = {
        		"to_do" : $(this).parent('.task').text(),
        	 	}
        	console.log(data);
        	jQuery.ajax({ // $.ajax 와 동일한 표현
        		url : '/samsam/todo_update.do',
        		type : 'POST',
        		data : JSON.stringify(data), //서버로 보낼 데이터
        		dataType : 'json', //서버에서 보내줄 데이터 타입
        		contentType : 'application/json;charset=utf-8',
        		success : function(map) {
        			console.log(map.result);
        		},
        		error : function() {
        			console.log("todo done ajax실패!!!");
        		}
        	});
    console.log("체크 p : " + $(this).parent());

     var p = $(this).parent();
		 p.fadeOut(function(){
		       $(".done").append(p);
		       p.fadeIn();
		 })
		 $(this).remove();
  })//체크클릭
  
  $(document).on('click', '.fa-trash-alt', function(e){
   	$(this).parent('.task').text()
  	var data = {
          		"to_do" : $(this).parent('.task').text(),
          		}
          	console.log(data);
          	jQuery.ajax({ // $.ajax 와 동일한 표현
          		url : '/samsam/todo_delete.do',
          		type : 'POST',
          		data : JSON.stringify(data), //서버로 보낼 데이터
          		dataType : 'json', //서버에서 보내줄 데이터 타입
          		contentType : 'application/json;charset=utf-8',
          		success : function(map) {
          			console.log(map.result);
          		},
          		error : function() {
          			console.log("todo delete ajax실패!!!");
          		}
          	});	
    console.log("삭제 p : " + $(this).parent());
    var p = $(this).parent();
	    p.fadeOut(function(){
	     p.remove();
	    })
  })//삭제클릭
  
});//투두리스트끝
//달력
var today = new Date();
var finall = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
if (today.getFullYear() % 4 == 0 && (today.getFullYear() % 100 != 0 || today.getFullYear() % 400 == 0)) {
  finall = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
}
function prev() {
  today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
  makeArray();
}
function next() {
  today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
  makeArray();
}
function makeArray() {
  var first = new Date(today.getFullYear(), today.getMonth(), 1);
  var day = 1;
  var cal = new Array(6);
  cal.fill(" ");
  var j = first.getDay();
  for (let i = 0; i < 6; i++) {
   	 cal[i] = new Array(7);
     cal[i].fill(" ");
    for (j; j < 7; j++) {
     cal[i][j] = day++;
     if (day > finall[today.getMonth()] + 1) cal[i][j] = " ";
    }
    j = 0;
  }
  arrayToTable(cal);
}

function arrayToTable(arr) {
	  document.getElementById("monthTable").innerHTML =
	    "<span>" +
	    today.getFullYear() +
	    "</span> " +
	    "<span style='font-weight:800; color:#cc3300'>" +
	    (today.getMonth() < 9 ? "0" + (((today.getMonth() - 1) % 12) + 2) : ((today.getMonth() - 1) % 12) + 2) +
	    "</span> ";
	  var calendar = document.getElementById("calendar").getElementsByTagName("tbody")[0];
	  if (calendar.rows.length > 2)
	    for (let i = 0; i < 6; i++) {
	      calendar.deleteRow(-1);
	    }
	  for (let i = 0; i < 6; i++) {
	    var row = calendar.insertRow();
	    for (let j = 0; j < 7; j++) {
	      cell = row.insertCell();
	      if (arr[i][j] != undefined) {
	        if (today.getMonth() == new Date().getMonth() && today.getFullYear() == new Date().getFullYear() && arr[i][j] == today.getDate()) {
	          cell.innerHTML = '<span style="color:#cc3300; font-weight:700;">' + arr[i][j] + "</span>";
	        } else {
	          cell.innerHTML = arr[i][j];
	        }
	      }
	    }
	  }
	};
