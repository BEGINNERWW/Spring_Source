<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<title>클릭한 위치에 마커 표시하기</title>
</head>
<body>
<div id="map" style="width:100%; height : 350px;"></div>
<p><em>지도를 클릭해주세요!</em>
<div id="clickLatlng"></div>

<script type="text/javascript" scr="http://dapi.kakao.com/v2/maps/sdk.js?appkey=f34d88650a9dc9c52fdba0b4b2b08a47">
</script>
<script>
var mapContainer = document.getElementById('map'), // 지도 표시할 div
	mapOption = {center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3 // 지도 확대레벨
	};
	console.log(mapOption);
//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 지도 클릭 위치에 표시할 마커
var marker = new kakao.maps.Marker({
	//지도 중심좌표에 마커 생성
	position : map.getCenter()
});
//지도에 마커 표시
marker.setMap(map);

//지도에 클릭 이벤트 등록
//지도를 클릭하면 마지막 파라미터로 넘어온 함수 호출
kakao.maps.event.addListener(map, 'click', function(mouseEvent){
	//클릭한 위도, 경도 정보를 가져옵니다
	var latlng = mouseEvent.latLng;
	
	//마커 위치를 클릭한 위치로 옮깁니다
	marker.setPosition(latlng);
	
	var message ='클릭한 위치의 위도는' + latlng.getLat() + ' 이고 ';
	message += '경도는 ' + latlng.getLng() + '입니다';
	
	var resultDiv = doucment.getElementById('clickLatlng');
	resultDiv.innerHTML = message;
});
	
</script>
</body>
</html>