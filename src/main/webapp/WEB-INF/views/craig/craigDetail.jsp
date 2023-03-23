<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa0f4a31c85566db414a70bc9044491b"></script>

<%--
<style>
	dl, ol, ul { text-align: center; margin-top: 5px; margin-bottom: 0;}
	a { text-decoration:none !important }
	a:hover { text-decoration:none !important }
	.notice-wrap, .non-login {margin-top: 5px;}
	button, input, optgroup, select, textarea { margin: 0; font-family: 'Arial', sans-serif; font-size: 14px; font-weight: 600; }	
	
	.w-100{
		width: 30%! important;
		border : 1px solid black
	}
--%>
<style>
#carouselExampleIndicators{
	margin: 0 auto; width: 600px;
 	height : 500px;	border-radius: 10px 10px 10px 10px;
}

.carousel-item{
	width: 600px; height : 500px;
	border-radius: 10px 10px 10px 10px; border: 2px solid lightgray;
}

.w-100{ width: 600px; height : 500px; }

carousel-control-prev-icon{ background-color: black;}
#crbigContainer { margin: 0 auto; width :610px; height: 400px; }

.btn-success{	background-color: #28A745;	color: white; font-weight: 400; float:right; font-size: 16px;}
.btn-success:hover{	background-color: green;}

.btn-danger{ background-color:#DC3545; margin-right :0; color: white; font-weight: 400; float:right; font-size: 16px; }
.btn-danger:hover{	background-color: #B10009;}
.btn-warning{ background-color: #FEC106; margin-right :0; margin-left: 10px; font-size: 16px; color : white;  font-weight: 400;   }
.btn-warning:hover{ background-color: #F7AF00; margin-left: 10px; font-size: 16px;  }
.btn-dark{ background-color: black; font-size: 16px; color : white; font-weight: 400; float:right;  }
.btn-dark:hover{ background-color: gray; font-size: 16px; color : white; }
#map{ margin: 0 auto;}
</style>
<br>
<c:if test="${fn:length(craigboard.attachments) >= 1 && craigboard.attachments[0].reFilename != null}">
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>  
   </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/upload/craig/${craigboard.attachments[0].reFilename}" alt="First slide">
    </div>
    <div class="carousel-item">
    <c:if test="${fn:length(craigboard.attachments) > 1 }">
      <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/upload/craig/${craigboard.attachments[1].reFilename}" alt="Second slide">
    </c:if>
    <c:if test="${fn:length(craigboard.attachments) == 1 && craigboard.attachments[1].reFilename== null  }">
      <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png" alt="First slide">
    </c:if>  
    </div>
    <div class="carousel-item">
    <c:if test="${fn:length(craigboard.attachments) > 2  }">
      <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/upload/craig/${craigboard.attachments[2].reFilename}" alt="Third slide">
 	</c:if>
    <c:if test="${fn:length(craigboard.attachments) == 1 && craigboard.attachments[2].reFilename== null  }">
      <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png" alt="First slide">
    </c:if>  
    </div>  
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
</c:if>

<c:if test="${craigboard.attachments[0].reFilename== null}">
<%-- <p>${fn:length(craigboard.attachments)}</p> --%>
 <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
   <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png" alt="First slide">
   <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="1" ></li>
   </ol>
  <div class="carousel-inner">
    <div class="carousel-item">
      <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png" alt="First slide">
    </div>
  </div><!-- inner -->
</div>
</c:if>

<!--  Profile -->
<table id="crboProfiletbl">
	<thead>
		<tr>
			<td style="width:60px">
			<c:if test="${craigboard.member.profileImg == null }">
				<img id="proimg" src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지"></td>
			</c:if>
			<!--  프사있으면 나올 거 난중에 추가하기  -->
			<td id="nickNdong" colspan="5">${craigboard.member.nickname}<br>
							<span id="memberInfo"></span></td>
			<td style="font-size: 16px; text-align: right; padding-right: 10px">${craigboard.member.manner}°C <Br>
											<span >매너온도</span></td>
		</tr>
		<tr style="height: 10px; border-bottom: 2px solid lightgray">
		</tr>
	</thead>
</table>
<!-- contents -->
<div id="crbigContainer">
	<p id="titletd" >${craigboard.title}</p>
	
	<!-- like 테이블에서 지금 로그인한 멤버가 이 게시물을 좋아요 한 이력이 없다면 .. 걍여기다가 img끼워넣음될듯 ajax -->	
	<span id="craigWishimg">
	<img id="heart_empty" style="width : 40px; float: right; margin-right: 10px; margin-top:-50px; display: inline" class="hearts" src="${pageContext.request.contextPath}/resources/images/heart_empty.png" alt="임시이미지"></td>	
	</span>
	
	<span  id="crcate"  class="spcateNdate" ></span> <span  class="spcateNdate" style="margin-left: 10px; margin-right: 10px" >|</span>
	<span class="spcateNdate" style="margin-right: 30px">   
		<fmt:parseDate value="${craigboard.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="date" />
		<fmt:formatDate value='${date}' pattern="yyyy년 MM월 dd일" /> 등록</span>
	<c:if test="${craigboard.price > 0}">
		<p id="crPrice"><fmt:formatNumber pattern="#,###" value="${craigboard.price}" />원</p>
	</c:if>
	<c:if test="${craigboard.price == 0 && craigboard.categoryNo != 7 }">
		<p id="crPrice">나눔💚</p>
	</c:if>
	<div id="crContent" style="font-size: 17px; height: 200px">	${craigboard.content} </div>
	
	<div style="margin-bottom: 10px;  height: 100px">	
		<span>관심</span>  <span id="spancrWish"></span>   <span> | 채팅</span> <span id= "spancrChat" ></span>  <span> | 조회 </span> <span id="spancrReadCount" ></span>
		<button type="button" class="btn btn-danger" style="display:inline-block; margin-top: -10px  ;"> 신고하기 </button>
		

		
		<!-- ★★★★ 채팅하기 버튼 ★★★★★  -->
		<button type="button" class="btn btn-success" style="display:inline-block; margin-top: -10px  ;"> 채팅하기 </button>
		<!-- ★★★★ 채팅하기 버튼 ★★★★★  -->


	</div>
</div>
<hr style="width:610px; margin: 0 auto; margin-top : 30px; margin-bottom:30px;  border: 1px solid lightgray" />

<div id="craigPlace">
	<p style="text-align: left">거래 희망 장소</p>
	<div id="map" style="width:600px; height:300px; border: none;"></div> 

<sec:authentication property="principal" var="loginMember"/>
<c:if test="${craigboard.member.memberId == loginMember.memberId}">
	<button id="btnUpdate" type="button" class="btn btn-warning" style="float: right; margin-top : 20px;"> 수정하기 </button>
	<button type="button" class="btn btn-dark" style="margin-left: 30px; margin-right: -1px;  margin-top : 20px; float: right"> 삭제하기 </button>		
</c:if>
</div>




<script>
window.addEventListener('load', () => {
	
	const memberInfo = document.querySelector("#memberInfo");
	
	$.ajax({
		url : `${pageContext.request.contextPath}/craig/getMyCraigDong.do`,
		method : 'get',
		dataType : 'json',
		data : { dongNo : '${craigboard.member.dongNo}'},
		success(data){
			memberInfo.innerHTML =   data.dongName  ;
		},
		error : console.log
	});
	
	const crcate = document.querySelector("#crcate");
	$.ajax({
		url : `${pageContext.request.contextPath}/craig/getMyCraigCategory.do`,
		method : 'get',
		dataType : 'json',
		data : { categoryNo : '${craigboard.categoryNo}'},
		success(data){
			console.log( data );
			
			const nm =  data.categoryName;
			if(nm == '삽니다'){
				crcate.innerHTML = `<b>\${nm}</b>`  ;
				$("#crcate").css("color","red");
			}else{
				crcate.innerHTML = nm  ;
			}
		},
		error : console.log
	});
	
});
</script>

<script>
//거래희망장소
const latitude = '${craigboard.latitude}'
const longitude = '${craigboard.longitude}'
const placeDetail = '${craigboard.placeDetail}'

var mapContainer = document.getElementById('map'), // 지도div 
   mapOption = { 
       center: new kakao.maps.LatLng(latitude, longitude), // 중심좌표
       level: 3 
   };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성

var markerPosition  = new kakao.maps.LatLng(latitude, longitude);  // 마커가 표시될 위치

var marker = new kakao.maps.Marker({ // 마커생성
    position: markerPosition
});

// 지도위에 마커 
marker.setMap(map);

var iwContent = `<div style="padding:5px; padding-left:20px; font-size:14px; text-align:center;">
					\${placeDetail}<br><a href="https://map.kakao.com/link/to/\${placeDetail},\{latitude},\{longitude}" style="color:blue" target="_blank">길찾기</a>
				 </div>`,
    iwPosition = new kakao.maps.LatLng(latitude, longitude); //

var infowindow = new kakao.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
});
  
infowindow.open(map, marker); 
</script>

<script>
document.querySelector("#btnUpdate").addEventListener('click', (e) =>{
	console.log(e.target);
	const craigno = '${craigboard.no}'
	location.href = `${pageContext.request.contextPath}/craig/craigUpdate.do?no=\${craigno}`;
});
</script>
























<!-- ★★★★★★ 250번 라인부터 시작  -   채팅방 들어가는 코드 작성해주시면됩니다  ★★★★★★★ -->
<script>


















</script>
<!-- ★★★★★★   채팅방 들어가는 코드   ★★★★★★★ -->



<br><br><br><br><br><br><br><br><br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>