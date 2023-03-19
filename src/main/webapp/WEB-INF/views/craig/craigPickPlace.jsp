<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--  taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 추가해야됨 나중에 -->

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>${param.pageTitle}</title>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig2.css" >
</head>
<body>
	<h3 style="margin-top: 20px; margin-bottom: 5px"> 이웃과 만나서<br> 거래하고 싶은 장소를 선택해 주세요 🥒</h3>
	<p style="margin: 0">만나서 거래할 때는 누구나 찾기 쉬운 공공장소가 좋아요.</p>
	
	<hr>
	<form name="placeEnroll" method="post" action="`${pageContext.request.contextPath}/craig/craigEnroll.do">
	<div id="map" style="width:500px;height:300px; border: 1px solid green; margin: auto"></div> 				
		<hr>
		<p style="margin-bottom: 8px; margin-left: 20px">선택한 곳의 장소명을 입력해주세요 </p>
		<input type="text" style="margin-left: 20px" class="formtext" name="placeDetail" id="placeDetail" placeholder="예 ) 강남역 1번 출구, 오이빌딩 앞" />
		<input type="hidden"  name="latitude" id="platitude" value="" />
		<input type="hidden"  name="longitude" id="longitude" value=""  />

		<div id="clickLatlng" style="font-size: 13px">
		</div>

		<input style="margin-left : 180px" class ="inputbuttons"  type="button" id="placeCancel" value="취소" onclick="history.go(-1);"/>		
		<input  style="margin-left : 30px" class ="inputbuttons"  type="button"  id="placeEnroll"  value="등록" onclick="setTimeout( ()=> { setParentText()}, 500)" />
	</form>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa0f4a31c85566db414a70bc9044491b"></script>
	<script>
	//geo
	let curlatitude;
	let curlongitude;
    var latitudevalue ="";
 
	window.addEventListener('load', () => {
		getUserLocation();
		
     });
     
	//success
    function success({ coords, timestamp }) {
         curlatitude = coords.latitude;   // 지금 위도
         curlongitude = coords.longitude; // 지금 경도
         
 	     console.log("righthere", `\${curlatitude}` );
         
 		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	       center: new kakao.maps.LatLng( `\${curlatitude}`, `\${curlongitude}`), // 지도의 중심좌표
	       level: 3 // 지도의 확대 레벨
		};
	   
	    
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성
		
		// 지도를 클릭한 위치에 표출할 마커
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시
		marker.setMap(map);

		//내태그위경도--x
	    let lati = document.querySelector("#platitude");

	    
		// 지도에 클릭 이벤트를 등록 => 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		    var resultDiv = document.getElementById('clickLatlng'); 
		    resultDiv.innerHTML = message;
		    
		    latitudevalue = `\${latlng.getLat()}`;
		    
		    $("#platitude").attr('value', latitudevalue);
		    $("#longitude").attr('value', `\${latlng.getLng()}`);
		    
		    console.log( document.querySelector("#platitude") ); //잘나오냐
		    console.log( document.querySelector("#longitude") );
		}); //end 카카오

	   };//end success

	    function getUserLocation() {
	        if (!navigator.geolocation) {
	            throw "위치 정보가 지원되지 않습니다. 거래 희망 장소의 기준위치는 임의의 위치로 지정됩니다.";
	        }
	        navigator.geolocation.getCurrentPosition(success);

      	}
	</script>
	
	
	<script> 
    function setParentText(){ //to parent
	
      	opener.document.getElementById("placeDetail").value = document.getElementById("placeDetail").value
      	opener.document.getElementById("latitude").value = document.getElementById("platitude").value
      	opener.document.getElementById("longitude").value = document.getElementById("longitude").value
      	opener.document.getElementById("map").innerHTML = document.getElementById("map").innerHTML
      	
      	
      	
      	window.close();
    };
    
	</script>
	
</body>
</html>