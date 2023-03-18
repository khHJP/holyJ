<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig.css" />
<style>
#tbl-craig-enroll-board{
   border: 1px solid black;
   width : 600px;
   height : 600px;
   margin: 0 auto;   
}

#craigEnrollFrm{
   width : 600px;
   height : 600px;
   margin: 0 auto;  
}
</style>
	<form id="craigEnrollFrm"
		name="craigEnrollFrm"
		enctype ="multipart/form-data"
		method="post">
		<table id="tbl-craig-enroll-board" >
			<tbody>
				<tr>	
					<th>사진첨부</th>
					<td></td>
				</tr>
				<tr>
					<th>글 제목</th>
					<td><input class="inputtext" type="text" name="title" placeholder="제목을 입력해주세요." required /></td>
				</tr>
				<tr>				
					<th>카테고리</th>
					<td><input type="checkbox" name="category"></td>
				</tr>
				<tr>				
					<th>￦ 가격</th>
					<td><input type="number"  class="inputtext" name="price" />      <input type="checkbox">나눔 </td>
				</tr>
				<tr>				
					<th>내용</th>
					<td><textarea id="content"></textarea></td>
				</tr>
				</tbody>
		</table>
			<div>
				<span>거래희망장소     </span><button id="pickPlace">장소선택</button></th>
				<div id="map" style="width:300px;height:350px;"></div>				
			</div>
			
			<div>						
				<p>위/경도나올부분</p>
				<div id="clickLatlng"></div>
		 	</div>
		 	
	</form>
	<br><br><br><br>	
	
	
	<script>
	//	장소고르기
	document.querySelector("#pickPlace").addEventListener('click', (e) => {

	});
	</script>	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa0f4a31c85566db414a70bc9044491b"></script>

	<script>
	//onload 해서 지금 내 근처 위치 좌표 가져와서 이걸로 기본 위치 지정하면 될거같은데 ?
			
	window.addEventListener('load', () => {
		getUserLocation();
		
		//geo
		let curlatitude;
		let curlongitude;
		
	    function success({ coords, timestamp }) {
	         curlatitude = coords.latitude;   // 지금 위도
	         curlongitude = coords.longitude; // 지금 경도
	         
	         alert(`위도: \${curlatitude}, 경도: \${curlongitude}`);
	     };
	     
	  	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = { 
	        center: new kakao.maps.LatLng(37.541501, 127.1285397), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
   		};
		
	    function getUserLocation() {
	        if (!navigator.geolocation) {
	            throw "위치 정보가 지원되지 않습니다. 거래 희망 장소의 기준위치는 임의의 위치로 지정됩니다.";
	        }
	        navigator.geolocation.getCurrentPosition(success);
	      }
		
	})
	


 	
	

  	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = { 
	        center: new kakao.maps.LatLng(37.541501, 127.1285397), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
    };

	//카카오api
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new kakao.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() 
	}); 
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    
	    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
	    message += '경도는 ' + latlng.getLng() + ' 입니다';
	    
	    var resultDiv = document.getElementById('clickLatlng'); 
	    resultDiv.innerHTML = message;
	    
	});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>