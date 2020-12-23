<%@ page language = "java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset ="utf-8" http-equiv = "X-UA-Compatible" content="IE=ege"/>
<!-- 반응형 웹 관련 작업 -->
<title>여러 마커 제어하기</title>
</head>
<body>
<div id="map" style="width:100%; height:350px;"></div>
<p>
<button onclick="hideMarkers()">마커 숨기기</button>
<button onclick="showMarkers()">마커 보이기</button>
</p>
<em>클릭한 위치에 마커 표시</em>

<script type="text/javascript" src = "http://dapi.kakao.com/v2/maps/sdk.js?appkey=54e8c53a0ce5cbe7c2b2766c4030cb21"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
mapOption = { 
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//지도를 클릭했을때 클릭한 위치에 마커를 추가하도록 지도에 클릭이벤트를 등록합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
// 클릭한 위치에 마커를 표시합니다 
addMarker(mouseEvent.latLng);             
});

//지도에 표시된 마커 객체를 가지고 있을 배열입니다
var markers = [];

//마커 하나를 지도위에 표시합니다 
addMarker(new kakao.maps.LatLng(33.450701, 126.570667));

//마커를 생성하고 지도위에 표시하는 함수입니다
function addMarker(position) {

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: position
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 생성된 마커를 배열에 추가합니다
markers.push(marker);
}

//배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
function setMarkers(map) {
for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
}            
}

//"마커 보이기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에 표시하는 함수입니다
function showMarkers() {
setMarkers(map)    
}

//"마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
function hideMarkers() {
setMarkers(null);    
}

</script>

</body>
</html>