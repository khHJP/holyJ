<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="title" />
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig/craig.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa0f4a31c85566db414a70bc9044491b"></script>

<style>
	#carouselExampleIndicators {
		margin: 0 auto;  width: 600px;
		height: 500px;  border-radius: 10px 10px 10px 10px;
	}
	
	.carousel-item {
		width: 600px;  height: 500px;
		border-radius: 10px 10px 10px 10px; border: 2px solid lightgray;
	}
	
	.w-100 { width: 600px; height: 500px; }
	
	carousel-control-prev-icon { background-color: black; }
	
	#crbigContainer { margin: 0 auto; width: 610px; height: 400px; }
	
	.btn-success {
		background-color: #28A745; color: white;
		font-weight: 400; float: right; font-size: 16px;
	}
	
	.btn-success:hover { background-color: green; }
	
	.btn-danger {
		background-color: #DC3545; margin-right: 0;
		color: white; font-weight: 400;
		float: right; font-size: 16px;
	}
	
	.btn-danger:hover { background-color: #B10009; }
	
	.btn-warning {
		background-color: #FEC106;
		margin-right: 0;
		margin-left: 10px;
		font-size: 16px;
		color: white;
		font-weight: 400;
	}
	
	.btn-warning:hover {
		background-color: #F7AF00;
		margin-left: 10px;
		font-size: 16px;
	}
	
	.btn-dark:hover { background-color: gray; color: white; }
	
	.btn-dark {
		margin-right: 0;
		margin-left: 10px;
		font-size: 16px;
		color: white;
		font-weight: 400;
	}
	
	#map { 	margin: 0 auto; }
	
	.bg-warning {   background-color: #56C271 !important; }
	#btnDelete:hover{ background-color: #6C757D !important; color:white !important;  }
	#btnUpdate:hover{ background-color: #FEC106 !important; color:black !important;  }
</style>

<br>
<%-- 수정 / 삭제하기 위로 올림 --%>
<sec:authentication property="principal" var="loginMember" />
<c:if test="${craigboard.member.memberId == loginMember.memberId  }">
	<h3 id="menu-toggle" style="width: 50px; margin-right: -50px;">Menu</h3>
	
	<ul id="menu">
		<li style="padding: 0">
			<button id="btnUpdate" type="button" class="btn btn-warning" style="float: right; margin-top: 10px; padding-bottom:10px; height:37px; background-color:white; color:black; vertical-align: middle; ">수정하기</button>
	  	</li>
	  	<li style="padding: 0">
			<button type="button" id="btnDelete" class="btn btn-dark" style="margin-top: 1px; margin-left:50px; float: right; padding-bottom:10px; height:37px; background-color:white; color:black; ">삭제하기</button>
	  	</li> 
	</ul>
</c:if>

<%-- img --%>
<c:if
	test="${fn:length(craigboard.attachments) >= 1 && craigboard.attachments[0].reFilename != null}">
	<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img class="d-block w-100"
					src="${pageContext.request.contextPath}/resources/upload/craig/${craigboard.attachments[0].reFilename}"
					alt="First slide">
			</div>
			<div class="carousel-item">
				<c:if test="${fn:length(craigboard.attachments) > 1 }">
					<img class="d-block w-100"
						src="${pageContext.request.contextPath}/resources/upload/craig/${craigboard.attachments[1].reFilename}"
						alt="Second slide">
				</c:if>
				<c:if
					test="${fn:length(craigboard.attachments) == 1 && craigboard.attachments[1].reFilename== null  }">
					<img class="d-block w-100"
						src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"
						alt="First slide">
				</c:if>
			</div>
			<div class="carousel-item">
				<c:if test="${fn:length(craigboard.attachments) > 2 && craigboard.attachments[2].reFilename != null  }">
					<img class="d-block w-100"
						src="${pageContext.request.contextPath}/resources/upload/craig/${craigboard.attachments[2].reFilename}"
						alt="Third slide">
				</c:if>
				<c:if
					test="${fn:length(craigboard.attachments) >= 1 && craigboard.attachments[2].reFilename== null  }">
					<img class="d-block w-100"
						src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"
						alt="First slide">
				</c:if>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
</c:if>

<%-- if no img --%>
<c:if test="${craigboard.attachments[0].reFilename== null}">
	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<img class="d-block w-100"
			src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"
			alt="First slide">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item">
				<img class="d-block w-100"
					src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"
					alt="First slide">
			</div>
		</div>
		<!-- inner -->
	</div>
</c:if>

<!--  Profile -->
<table id="crboProfiletbl">
	<thead>
		<tr>
		
		<!-- -------------------------------------------------------------------------------------------------------------- -->		
			<!-- Button trigger modal -->
			<%-- ■ 프사 --%>
			<td style="width: 60px">
			<button type="button" class="btn1 btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
				<c:if test="${craigboard.member.profileImg == null }">
					<img id="proimg" src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지">
				</c:if>
				<c:if test="${craigboard.member.profileImg != null }">
					<img id="proimg" src="${pageContext.request.contextPath}/resources/upload/profile/${craigboard.member.profileImg}";" alt="임시이미지">
				</c:if>
			</button>
			</td>
			
			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content" id="modal-content">
			      <div class="modal-header" id="modal-header">
				      <div>
					      <div style="display:flex;">
					        <img src="${pageContext.request.contextPath}/resources/upload/profile/${craigboard.member.profileImg}"  alt="프로필" name="profileImg" id="imagemodal">
					        <div>
					        <h4 class="modal-title1 fs-5" id="exampleModalLabel">
					        ${craigboard.member.nickname}
					        </h4>
					        </div>
					      </div>
			      	</div>
					     <h6>${craigboard.member.manner}℃</h6>
			        </div>
			      
			      <div class="modal-body" id="modal-body">
			      	<form:form name="salCriag1Frm" action="${pageContext.request.contextPath}/craig/mySalCraig1.do" method="GET">
				        <li>
				        <img src="${pageContext.request.contextPath}/resources/images/Cr.png" alt="" id="mypageimg"/>
				        <button type="submit" class="btn-list">중고거래</button>
				        <input type="hidden" name="memberId" value="${craigboard.writer}"/>
				        </li>
			        </form:form>
			      	<form:form name="myLocal1Frm" action="${pageContext.request.contextPath}/local/myLocal1.do" method="GET">
				      	<li>
				        <img src="${pageContext.request.contextPath}/resources/images/Lo.png" alt="" id="mypageimg"/>
					        <button type="submit" class="btn-list">동네생활</button>
					        <input type="hidden" name="memberId" value="${craigboard.writer}"/>
				        </li>
			        </form:form>
			      	<form:form name="myTogether1Frm" action="${pageContext.request.contextPath}/together/myTogether1.do" method="GET">
				        <li>
				        <img src="${pageContext.request.contextPath}/resources/images/To.png" alt="" id="mypageimg"/>
				        <button type="submit" class="btn-list">같이해요</button>
				        <input type="hidden" name="memberId" value="${craigboard.writer}"/>
				        </li>
			        </form:form>
			      	<form:form name="myManner1Frm" action="${pageContext.request.contextPath}/manner/myManner1.do" method="GET">
				        <li>
				        <img src="${pageContext.request.contextPath}/resources/images/Ma.png" alt="" id="mypageimg"/>
				        <button type="submit" class="btn-list">받은매너</button>
				        <input type="hidden" name="memberId" value="${craigboard.writer}"/>
				        </li>
			        </form:form>
			      </div>
			      <div class="modal-footer" id="modal-footer">
			        <button type="button" class="btn btn-secondary1" data-bs-dismiss="modal">Close</button>
			      </div>
			    </div>
			  </div>
			</div>
		<!-- --------------------------------------------------------------------------------------------- -->
			
		

			<td id="nickNdong"  colspan="5">${craigboard.member.nickname}<br>
				<span id="memberInfo"></span>
			</td>
						
			<%-- ■ 매너온도 --%>
			<td style="font-size: 16px; text-align: right; padding-right: 10px; width:320px;">
				<div class="manner-box" style="padding-top: 25px">
					<div class="temperature" style="text-align: right;">
						<span>${craigboard.member.manner}</span>
						<c:if test="${craigboard.member.manner lt 30}">
							<span style="color:#3AB0FF" >°C</span>
							<span style="position:relative; top:5px;" >😰</span>
							<div class="progress" style="width:80px; height: 10px; position: relative; left:195px; top: 5px">
							  <div class="progress-bar progress-bar-striped bg-info" role="progressbar" style="width: 30%; display: absolute;" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</c:if>
						<c:if test="${craigboard.member.manner ge 35 && craigboard.member.manner lt 50}">
							<span style="color: #56C271">°C</span>
							<span style="position:relative; top:5px;" >☺️</span>
							<div class="progress" style="width:80px; height: 10px; position: relative; left:195px; top: 5px;">
							  <div class="progress-bar bg-warning" role="progressbar" style="width: 65%; background-color:color: #56C271 !important; float: right; margin-right: 0" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
	
						</c:if>
						<c:if test="${craigboard.member.manner ge 50}">
							<span style="color: red">°C</span>
							<span style="position:relative; top:5px;" >😍</span>
							<div class="progress" style="width:80px; height: 10px; position: relative; left:195px; top: 5px">
							  <div class="progress-bar bg-danger" role="progressbar" style="width: 90%; margin-right: 0;" aria-valuenow="90" aria-valuemin="0" aria-valuemax="80"></div>
							</div>
							
						</c:if>
					</div>
				</div>
				<Br> <span>매너온도</span>
			</td>
		</tr>

		<tr style="height: 10px; border-bottom: 2px solid lightgray">
		</tr>
		
	</thead>
</table>

<!-- contents  -->
<div id="crbigContainer">
	<%-- CR1 || CR3 - 거래/나눔 --%>
	<c:if test="${craigboard.state == 'CR1'}">
		<span class="badge badge-success" style="height: 26px; font-size: 15px; text-align: center; vertical-align: middle;"> 예약중 </span>
	</c:if>
	<c:if test="${craigboard.state == 'CR3' && craigboard.price != 0  }">
		<span class="badge badge-secondary" style="height: 26px; font-size: 15px; text-align: center; vertical-align: middle;"> 거래완료 </span>
	</c:if>
	<c:if test="${craigboard.state == 'CR3' && craigboard.price == 0 && craigboard.categoryNo != 7  }">
		<span class="badge badge-secondary" style="height: 26px; font-size: 15px; text-align: center; vertical-align: middle;"> 나눔완료 </span>
	</c:if>
	
	<p id="titletd">${craigboard.title}</p>

<%-- sec 안써도됨 --%>
	<c:if test="${loginMember.memberId != craigboard.writer}">	
	<div> <%-- alert --%>
		<div id="likement" class="alert alert-warning alert-dismissible fade show" role="alert" style="position:absolute; top:780px; left:780px; width: 400px; display: none;" >
		  <span> 관심 목록에 추가되었어요!  
		  	<a style="margin-left: 50px; font-size: 15px;" href="${pageContext.request.contextPath}/craig/myWishCraig.do">관심목록보기</a></span> 
		  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		    <span aria-hidden="true">&times;</span>
		  </button>
		</div>
	</div>
	</c:if>
	<c:if test="${loginMember.memberId == craigboard.writer}">	
	<div> <%-- alert --%>
		<div id="likement" class="alert alert-warning alert-dismissible fade show" role="alert" style="position:absolute; top:780px; left:695px; width: 400px; display: none;" >
		  <span> 관심 목록에 추가되었어요!  
		  	<a style="margin-left: 50px; font-size: 15px;" href="${pageContext.request.contextPath}/craig/myWishCraig.do">관심목록보기</a></span> 
		  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		    <span aria-hidden="true">&times;</span>
		  </button>
		</div>
	</div>
	</c:if>


	<%--  like 테이블에서 지금 로그인한 멤버가 이 게시물을 좋아요 한 이력이 없다면 .. 걍여기다가 img끼워넣음될듯 ajax --%
	<%-- <c:if test="${}" 이 로그인멤버의 아이디&게시글 no가 wish테이블에 없다면 빈하트 아니 꽉찬하트  --%>
	<c:if test="${findCraigWish == 0 or findCraigWish == null}">
		<img  style="width: 40px; float: right; margin-right: 10px; margin-top: -50px; display: inline"
		class="hearts" src="${pageContext.request.contextPath}/resources/images/heart_empty.png" alt="임시이미지">
	</c:if>
	<c:if test="${findCraigWish == 1}">
		<img  style="width: 40px; float: right; margin-right: 10px; margin-top: -50px; display: inline"
		class="hearts" src="${pageContext.request.contextPath}/resources/images/heart_red.png" alt="heartfull">
	</c:if>

	<span>	<img src="${pageContext.request.contextPath}/resources/images/crtag.png"/></span>
	<span id="crcate" class="spcateNdate"></span> 
	<span class="spcateNdate" style="margin-left: 10px; margin-right: 10px">|</span>
	<span class="spcateNdate" style="margin-right: 30px">

		<fmt:parseDate value="${craigboard.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="date" /> 
		<fmt:formatDate value='${date}' pattern="yyyy년 MM월 dd일 a HH시 mm분"  type="both" dateStyle="full" timeStyle="full"  /> 등록
	</span>

	<c:if test="${craigboard.price > 0}">
		<p id="crPrice" style="margin-top: 8px;">
			<fmt:formatNumber pattern="#,###" value="${craigboard.price}" />원
		</p>
	</c:if>
	
	<c:if test="${craigboard.price == 0 && craigboard.categoryNo != 7 }">
		<p id="crPrice">나눔💚</p>
	</c:if>

	<div id="crContent" style="font-size: 17px; height: 200px">${craigboard.content}</div>

	<div style="margin-bottom: 10px; height: 90px; ">
		<span>관심 </span> <span id="spancrWish"></span> <span> · 채팅</span>
		<span id="spancrChat"></span> <span> · 조회 </span> <span id="spancrReadCount">${craigboard.hits}</span>

		<!-- ♣♣♣♣♣ 로그인한사람 = 글쓴이 아닐 경우 채팅하기 버튼 ♣♣♣♣♣  -->
		<sec:authentication property="principal" var="loginMember" />
		<c:if test="${craigboard.member.memberId != loginMember.memberId}">		
			<button type="button" class="btn btn-danger" id="reportBtn" style="display: inline-block; margin-top: -10px;">신고하기</button>
			<c:if test="${ craigboard.state != 'CR3' || ( craigboard.state =='CR3' && craigboard.buyer == loginMember.memberId )}">
				<button id="chatBtn" type="button" class="btn btn-success" style="display: inline-block; margin-top: -10px;">채팅하기</button>
			</c:if>	
		</c:if>	
		
		<!-- ♣♣♣♣♣ 로그인한사람 = 글쓴이  경우 채팅하기 버튼 ♣♣♣♣♣  -->
		<sec:authentication property="principal" var="loginMember" />
			<c:if test="${craigboard.member.memberId == loginMember.memberId}">
				<button id="writerChatBtn" type="button" class="btn btn-success" style="width:140px; display: inline-block; margin-top: -10px;">대화 중인 채팅방</button>
			<!-- ♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣  -->
			</c:if>	
	</div>
</div>

<hr style="width: 610px; margin: 0 auto; margin-top: 50px; margin-bottom: 30px; border: 1px solid lightgray" />

<div id="craigPlace">
	<p style="text-align: left">거래 희망 장소</p>
	<div id="map" style="width: 600px; height: 300px; border: none;"></div>
</div>

<%-- del --%>
<form:form id="craigDeleteFrm" name="craigDeleteFrm"  enctype ="multipart/form-data"  method="post"
	 action="${pageContext.request.contextPath}/craig/craigBoardDelete.do?${_csrf.parameterName}=${_csrf.token}"  >
	 <input type="hidden" name="no" id="delno" value="${craigboard.no}" >
</form:form>





<script>
window.addEventListener('load', () => {
	//load될때 가져와야될정보
	const memberInfo = document.querySelector("#memberInfo");
	
	$.ajax({
		url : `${pageContext.request.contextPath}/craig/getMyCraigDong.do`,
		method : 'get',
		dataType : 'json',
		data : { dongNo : '${craigboard.member.dongNo}'},
		success(data){
			console.log(data);
			memberInfo.innerHTML =   data.guName.guName + " " + data.dongName  ;
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


	//관심수 
	$.ajax({
		url : `${pageContext.request.contextPath}/craig/selectCraigWishOne.do`,
		method : 'get',
		data : {no : '${craigboard.no}'},
		dataType : 'json',
		success(data){
			console.log(data);
			const spancrWish = document.querySelector("#spancrWish");
			spancrWish.innerHTML = parseInt(data); 
		},
		error : console.log
	})	
	//채팅수
		$.ajax({
		url : `${pageContext.request.contextPath}/craig/selectCraigChrooms.do`,
		method : 'get',
		data : {no : '${craigboard.no}'},
		dataType : 'json',
		success(data){
			console.log(data);
			const spancrChat = document.querySelector("#spancrChat");
			spancrChat.innerHTML = parseInt(data); 
		},
		error : console.log
	})
	
});//end function
</script>


<script>
//거래희망장소

const latitude = '${craigboard.latitude}';
const longitude = '${craigboard.longitude}';
const placeDetail = '${craigboard.placeDetail}';

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


<!--  삭제 버튼 클릭시   -->
<div id="myModal" class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel" style="color: red"> 주의! </h5>
        <button type="button" class="close" data-dismiss="modal"  data-target="myModal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body"></br>
        정말 게시글을 삭제하시겠습니까 ?
      </br></br></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="statemodalcfm" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="delconfirm">확인</button>        
      </div>
    </div>
  </div>
</div>



<%-- 로그인한사람 = writer 일때 --%>
<sec:authentication property="principal" var="loginMember" />
<c:if test="${loginMember.memberId == craigboard.writer }">       
<script>

const updateBtn = document.querySelector("#btnUpdate");
const sale = "${craigboard.state}";

if(sale == 'CR3'){
	$(updateBtn).attr("disabled", true);
	$(updateBtn).css("cursor", 'not-allowed');

<%--일단버려
	$(updateBtn).remove();
	const li = document.querySelector("#menu li");
	
	const text = `<span class="d-inline-block" style="display:inline" tabindex="0" data-toggle="tooltip" title="판매완료로 게시글 수정불가">
		<button id="btnUpdate" type="button" class="btn btn-warning" style="pointer-events: none; float: right; margin-top: 10px; margin-bottom: 60px; margin-left: 50px; padding-bottom:20px; height:37px; background-color:white; color:black; vertical-align: middle; " disabled >수정하기</button>
			</span>`;
	$(li).prepend(text);
--%>		
} 


document.querySelector("#btnUpdate").addEventListener('click', (e) =>{
	console.log(e.target);
	const craigno = '${craigboard.no}'
	location.href = `${pageContext.request.contextPath}/craig/craigUpdate.do?no=\${craigno}`;
});




document.querySelector("#btnDelete").addEventListener('click', (e) =>{
	$('#myModal').modal('show');
});

document.querySelector("#delconfirm").addEventListener('click', (e) => {
	 document.craigDeleteFrm.submit();	
});


<!-- ★★★★★★★★★★★★  로그인한사람 나 == 글쓰니인경우  채팅방 들어가는 코드   ★★★★★★★★★★★★★ -->
document.querySelector("#writerChatBtn").addEventListener('click', (e) => {
	const craigNo = ${craigboard.no}

	const url = `${pageContext.request.contextPath}/chat/craigChatList.do?craigNo=\${craigNo}`;
	const name = "craigChatList";
	const spec = "width=500px, height=790px, scrollbars=yes";
	open(url, name, spec);
});
<!--  ★★★★★★★★★★★★   채팅방 들어가는 코드   ★★★★★★★★★★★★★★★★★★★ -->
</script>
</c:if>




<!-- ★★★★★★ 450번 라인부터 시작  -   로그인한사람 나 != 글쓰니가 아닐경우 !! '채팅하기' 버튼일 경우 채팅방 들어가는 코드 작성해주시면됩니다  ★★★★★★★-->
<sec:authentication property="principal" var="loginMember" />
<c:if test="${loginMember.memberId != craigboard.writer }">  
<script>
document.querySelector("#chatBtn").addEventListener('click', (e) => {
	const craigNo = ${craigboard.no}
	$.ajax({
		url : `${pageContext.request.contextPath}/chat/craigChat/\${craigNo}`,
		method : 'GET',
		dataType : "json",
		success(data){
			const {memberId, chatroomId} = data;
			
			const url = `${pageContext.request.contextPath}/chat/craigChat.do?chatroomId=\${chatroomId}&memberId=\${memberId}&craigNo=\${craigNo}`;
			const name = "craigChatroom";
			openPopup(url, name);
		},
		error : console.log
		});		

});

function openPopup(url, name){
	let win;
	win = window.open(url, name, 'scrollbars=yes,width=500,height=790,status=no,resizable=no');
	win.opener.self;
}


// 혜진추가 0402 - 채팅수 바로 증가
const spancrChat = document.querySelector("#spancrChat");

$( "#chatBtn" ).one( "click", function( event ) {
	const craigNo = ${craigboard.no};

	$.ajax({
	    url : "${pageContext.request.contextPath}/craig/findmeFromChat.do",
		method : 'get',
		data : {no : craigNo},
		dataType : 'json',
		success(data){
					console.log( "data : ", data  );
					console.log( data==1  );
					if(data == 1){
						spancrChat.innerHTML =  parseInt(spancrChat.innerHTML);						
					}
					else if(data ==0 ){
						spancrChat.innerHTML =  parseInt(spancrChat.innerHTML)+ parseInt(1);
					}

		},
		error : console.log
	});//end - ajax	
});


//신고
document.querySelector("#reportBtn").addEventListener('click', (e)=>{

	const reportedId = '${craigboard.writer}'; //게시글쓴사람
	const reportType = 'CR';
	const boardNo = '${craigboard.no}';

	console.log(reportType, boardNo, reportedId);
	
	location.href = '${pageContext.request.contextPath}/report/reportEnroll.do?reportType='+ reportType + '&boardNo=' + boardNo + '&reportedId=' + reportedId;

	
})
</script>	
</c:if>


<script>
// 매너온도 - 0327
	window.addEventListener('load', (e) => {
		const temperature = document.querySelector(".temperature span");
		console.log(temperature);
		
		if(temperature.innerText < 30) temperature.style.color = '#3AB0FF'; 
		else if(temperature.innerText >= 30 && temperature.innerText < 50) temperature.style.color = '#56C271'; 
		else if(temperature.innerText >= 50) temperature.style.color = '#F94C66'; 
		
	});

//수정/삭제 - 0327
	$.fn.extend({
	  
	  threeBarToggle: function(options){
	    
	    var defaults = {
	      color: 'black',
	      width: 30,
	      height: 25,
	      speed: 400,
	      animate: true
	    }
	    var options = $.extend(defaults, options); 
	    
	    return this.each(function(){
	      
	      $(this).empty().css({'width': options.width, 'height': options.height, 'background': 'transparent'});
	      $(this).addClass('tb-menu-toggle');
	      $(this).prepend('<i></i><i></i><i></i>').on('click', function(event) {
	        event.preventDefault();
	        $(this).toggleClass('tb-active-toggle');
	        if (options.animate) { $(this).toggleClass('tb-animate-toggle'); }
	        $('.tb-mobile-menu').slideToggle(options.speed);
	      });
	      $(this).children().css('background', options.color);
	    });
	    
	  },
	  
	  accordionMenu: function(options){
	    
		    var defaults = {
		      speed: 400
		    }
		    var options =  $.extend(defaults, options);
	
		    return this.each(function(){
		      
		      $(this).addClass('tb-mobile-menu');
		      var menuItems = $(this).children('li');
		      menuItems.find('.sub-menu').parent().addClass('tb-parent');
		      $('.tb-parent ul').hide();
		      $('.tb-parent > a').on('click', function(event) {
		        event.stopPropagation();
		        event.preventDefault();
		        $(this).siblings().slideToggle(options.speed);
		      });
		      
		    });
	  }//accordionMenu
	  
	  
	});
		
	$('#menu-toggle').threeBarToggle({color: 'green', width: 30, height: 25});
	$('#menu').accordionMenu();

</script>

<script>
// ■ 관심 
	document.querySelector(".hearts").addEventListener('click', (e) => {

		const img = e.target;
		console.log( img );

		const spancrWish = document.querySelector("#spancrWish")
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		
		$.ajax({
		    url : `${pageContext.request.contextPath}/craig/insertOrDeleteCraigWish.do`,
		    method : 'post',
		    headers,
		    data : { no : '${craigboard.no}',
		             memberId : '<sec:authentication property="principal.username" />'},  //1 또는 0을 받아야 insert or delete를 한다
		    dataType : 'json',
	           success(data){
		    	if(data == 1){
		    		img.src = `${pageContext.request.contextPath}/resources/images/heart_red.png`;
		    		spancrWish.innerHTML =  parseInt(spancrWish.innerHTML)+ parseInt(1);
		    		document.querySelector("#likement").style.display="inline";

		    	}
		    	else{
		    		img.src = `${pageContext.request.contextPath}/resources/images/heart_empty.png`;
		    		spancrWish.innerHTML =  parseInt(spancrWish.innerHTML) - parseInt(1);
		    		document.querySelector("#likement").style.display="none";
	
		    	}
		    },
		    error(jqxhr, textStatus, err ){
		        console.log(jqxhr, textStatus, err);
		    }   
		})//end-ajax   
	});//end of pushheart 
</script>




<%-------------------- 다른 판매 상품 -------------------------%>
<hr style="width: 610px; margin: 0 auto; margin-top: 60px; margin-bottom: 40px; border: 1px solid lightgray" />
<div id="othercraigDiv">
<h5 style="font-size: 18px;"> <span style="color:#28A745" >${craigboard.member.nickname}</span> 님의 다른 판매 상품</h5>
<span> ❗다른 판매 상품은 최대 2개까지 노출됩니다 </span>
	<c:if test="${othercraigs != null}">
	<table id="craigWholeListTbl" style="text-align: center; margin-left: -30px; margin-top: 20px">
		<tbody>
			<tr style="padding-bottom : 30px; margin-bottom : 30px; ">		
			  <c:forEach items="${othercraigs}" var="craig" varStatus="vs" begin="0" end="1">
			  	<td class="crnotd" data-crno="${craig.no}" style="width:200px; height: 380px; padding: 30px">
				<div class="explains" >
					<%-- img --%>
					<c:if test="${craig.attachments[0].reFilename != null}">
					    <a><img id="eachimg" style="display : inline-block; height : 200px; width:200px; border-radius: 10px" 
							    src="${pageContext.request.contextPath}/resources/upload/craig/${craig.attachments[0].reFilename}"/></a><br/>
					</c:if>
					<c:if test="${craig.attachments[0].reFilename==null}">
					    <a><img id="eachimg"  style="display : inline-block; height : 180px; width:200px;" 
							    src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/></a><br/>
					</c:if>
						<p id="crtitle" class="crpp" style="text-align: left; margin: 20px 0 10px 0;">${craig.title}</p>
					<c:if test="${craig.price > 0}">
						<p id="crprice" class="crpp" style="text-align: left; margin: 0px 0 10px 0; font-size:17px;"> <fmt:formatNumber pattern="#,###" value="${craig.price}" />원</p>
					</c:if>

					<c:if test="${craig.price == 0 && craig.categoryNo != 7 }">
						<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; font-size: 17px;">나눔💚</p>
					</c:if>
					</div>
				</td>
			</c:forEach>
			</tr>
		</tbody>
	</table>
	</c:if>
	<c:if test="${ othercraigs == null || othercraigs == '' || othercraigs[0] == null}">
		<table style="background-color: #f5f5f5; height: 250px; width:610px; margin-top: 40px; text-align: center; border-radius: 20px">
			<tbody>
			<th>	
			 아직 등록하신 다른 판매중인 상품이 없어요 😣
			</th>
			</tbody>
		</table>	
	</c:if>
		
</div>
<br><br><br><br>
<script>
//■ 상세페이지
	document.querySelectorAll("td[data-crno]").forEach( (td)=>{
		td.addEventListener('click', (e) => {
	
			const no = td.dataset.crno;
			console.log( no );
			location.href = "${pageContext.request.contextPath}/craig/craigDetail.do?no="+no;		
		})
	})
</script>

<%-- 와머지? 채팅에 이거 넣을려고 햇는디 ,,, 하지말까			<!-- ★★★★ 로그인한사람 = 일반사용자(no writer)일 경우 채팅하기 버튼 ★★★★★  
			<c:if test="${ craigboard.state != 'CR3' || ( craigboard.state =='CR3' && craigboard.buyer == loginMember.memberId )}"> --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
