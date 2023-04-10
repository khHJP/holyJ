<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> <%-- 혜진 0406 추가  --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.pageTitle}</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
	integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chat/chatroom.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1f728657c1f1828a75b9c549d4888eb1"
    ></script>
	<style> #buyerconfirm:hover{	background-color: #19722e !important; }</style>   
</head>
<body>
	<div class="chat w-100 h-100">
		<div class="card">
			<!-------- 채팅방 헤더 start -------->
			<div class="card-header msg_head align-top">
				<div class="d-flex bd-highlight">
					<div class="user_info">
						<span class="nickname">${otherUser.nickname}</span> 
						<span class="manner badge bg-success">${otherUser.manner}</span>
					</div>
					<!-- 메뉴버튼 이미지  -->
					<svg id="action_menu_btn" class="bi bi-three-dots-vertical" width="24" height="24" role="img" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16">
						<path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z" />
					</svg>
				</div>
					<!-- 메뉴버튼 토글시  -->
					<div class="action_menu">
						<ul>
							<li id="craigReport" data-toggle="modal" data-target="#reportModal">신고하기</li>
							<li id="craigExit">채팅방 나가기</li>
						</ul>
					</div>
					<!----------- 신고 Modal start ------------->
					<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="reportModalLabel">사용자 신고</h5>
					      </div>
					      <div class="modal-body" style="height: 335px;">
							<form:form name="userReportFrm" class="report-box">
								<c:forEach items="${reasonList}" var="reason" varStatus="vs">
										<div class="form-check">
											<input type="checkbox" name="reasonNo" class="form-check-input" id="${reason.reportType}${vs.count}" 
												   value="${reason.reasonNo}" data-report-type="${reason.reportType}" onclick='checkOnlyOne(this)'>
											<label class="form-check-label" for="${reason.reportType}${vs.count}">${reason.reasonName}</label>
										</div>
								</c:forEach>
								<input type="hidden" name="writer" value="${loginMember.memberId}">
								<input type="hidden" name="reportedMember" value="${info.reportedId}">
								<input type="hidden" name="reportType" value="${info.reportType}">
								<input type="hidden" name="reportPostNo" value="${info.boardNo}">
							</form:form>
					      </div>
					      <div class="modal-footer ">
					        <button id="saveReport" type="button" class="btn btn-primary" style="position: relative; z-index: 10;">신고하기</button>
					      </div>
					    </div>
					  </div>
					</div>	
					<!------------ 신고 Modal end ------------->
			</div>
			<!------- 채팅방 헤더 end ------------>
	
			<!------- 게시글정보 start ----------->
			<div id="craig_bar">
				<div class="craig_info_wrap"> 
					<!-- 게시글 썸네일 이미지 start -->
					<c:if test="${craigImg[0] == null}">	
						<img style="width: 60px; height: 60px;" src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png" alt="" />
					</c:if>
					<c:if test="${craigImg[0] != null}">
						<img style="width: 60px; height: 60px;" src="${pageContext.request.contextPath}/resources/upload/craig/${craigImg[0].reFilename}"alt="" />
					</c:if>
					<!-- 게시글 썸네일 이미지 end -->
					<div class="craig_text">
						<p class="craig_status">
							<c:choose>
								<c:when test="${craig.state eq 'CR1'}">예약중</c:when>
								<c:when test="${craig.state eq 'CR2'}">판매중</c:when>
								<c:when test="${craig.state eq 'CR3'}">판매완료</c:when>
							</c:choose>
						</p>
						<p class="craig_name">${craig.title}</p>
						<span class="price"> <fmt:formatNumber value="${craig.price}" pattern="#,###" />원</span>
					</div>
				</div>
				<div class="btnWrap">
					<!-- 예약중일때  -->
					<c:if test="${craig.state eq 'CR1'}">
						<!-- 로그인중인 사용자가 예약자일때 / 게시글 작성자일때 -->
						<c:if test="${memberId == craig.buyer || memberId == craig.writer}">
							<!-- 약속잡기 안했을때  -->
							<c:if test="${meeting == null}">
								<button id="meeting" type="button" class="btn btn-outline-secondary"  data-toggle="modal" data-target="#meetingModal">약속잡기</button>	
								<button id="meetingPlace" type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#locationModal" style="display: none;">장소공유</button>				
							</c:if>
							<!-- 약속잡기 했을때 -->
							<c:if test="${meeting != null}">
								<button id="meetingDate" type="button" class="btn  btn-success" >${meetingDate}</button>	
								<!-- 장소공유 안했을때 -->
								<c:if test="${meeting.longitude == null || meeting.longitude == '' }">
									<button id="meetingPlace" type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#locationModal">장소공유</button>													
								</c:if>								
							</c:if>
						</c:if>
					
						<!-- 예약자가 아닐때 -->
						<c:if test="${memberId != craig.buyer && memberId != craig.writer}">
							<button type="button" class="btn btn-success" >예약중</button>
						</c:if>
					</c:if >		
					<!-- 판매중일때  -->
						<c:if test="${craig.state eq 'CR2'}">
							<button id="meeting" type="button" class="btn btn-outline-secondary"  data-toggle="modal" data-target="#meetingModal">약속잡기</button>			
						</c:if>
					<!-- 판매완료일때  -->	
					<c:if test="${craig.state eq 'CR3'}">
						<button type="button" class="btn btn-dark" > 판매완료 </button> 
<%-- 분기 --%>				<c:if test="${ ( mydonemanner.mannerNo == null &&  memberId == craig.writer)  || ( mydonemanner.mannerNo == null &&  memberId == craig.buyer)   }">
							<button id="sendreview" class="btn btn-outline-secondary" style="width: 88px; margin-left:10px; padding-left :5px; padding-right :5px" >후기보내기</button>
						</c:if>
					</c:if>
				</div> <!-- btnWrap end -->
			</div>	<!-- craig_bar end -->	
						
<%-- ★★★★★★★★★    ε=ε=ε=(~￣▽￣)~  혜진 거래후기보내기 시작   ε=ε=ε=(~￣▽￣)~  ★★★★★★★★★ --%>		
			<%-- 1) 거래후기보내기 modal start(혜진) --%>
			<%--  최초 거래후기보내기 클릭시 뜨는멘트    --%>
			<div id="myModal" class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel" style="color: black"> 후기 보내기 </h5>
			        <button type="button" class="close" data-dismiss="modal"  data-target="myModal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
					 <c:if test="${memberId == craig.buyer }">  <!--  로그인한사람 나 = 구매자일경우  -->
					 	${otherUser.nickname}님과 상품을 거래하셨나요?
					 </c:if>
			
					 <c:if test="${memberId ==  craig.writer   }">	<!--  로그인한사람 나 = 판매자일경우  -->					 
					 	${otherUser.nickname}님과 상품을 거래하셨나요?
					 </c:if>
			      	</br></br>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" id="statemodalcfm" data-dismiss="modal">취소</button>
			        <button type="button" class="btn btn-primary" id="buyerconfirm" style="background-color: #2a9944;">예,거래했어요! </button>        
			      </div>
			    </div>
			  </div>
			</div>

			<%--  2) 거래후기보내기 모달시작   --%>
			<div class="modal fade" id="mySecondModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle"> 🥒후기 보내기 </h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
		      	<%--======   매너평가(거래후기보내기) ======= --%>
				       		<form:form id="craigMannerFrm" name="craigMannerFrm"   method="post" 
					       		 action="${pageContext.request.contextPath}/manner/craigMannerEnroll.do"  >
						       						       	
				 				<input type="hidden" class="form-control" name="chatroomId" id="chatroomId" value="${chatroomId}" required>					
				 				<input type="hidden" class="form-control" name="craigNo" id="craigNo" value="${craig.no}" required>				
				 				<input type="hidden" class="form-control" name="writer" id="writer" value="${memberId}" required>				
				
								<p style="margin-bottom:-13px;" >${chatUser.nickname}님,<p>
					    		<c:if test="${memberId == craig.buyer }">
									<input type="hidden" class="form-control" name="recipient" id="recipient" value="${craig.writer}" required>
									<p>${otherUser.nickname}님 과의 거래가 어떠셨나요? <p>
						 		</c:if>	 
					     	 	<c:if test="${memberId ==  craig.writer   }">
									<input type="hidden" class="form-control" name="recipient" id="recipient" value="${craig.buyer}" required>
									<p>${otherUser.nickname}님 과의 거래가 어떠셨나요? <p>
						 		</c:if>
									<p style="color:gray; font-size: 14px; margin-top: 30px;">거래 후기는 나만 볼 수 있어요. <p>	 
					
								<div id="bigMannerDiv" style="display: flex;  justify-content: space-around;">	<%-- 필수선택값  --%>			
									<div>
										<img class="mannerimages" src="${pageContext.request.contextPath}/resources/images/bad.png" alt="" /><br>
										<input type="checkbox" class="mannerbox" name="prefer" id="MA1" value="MA1" onclick="checkOnlyOne(this)"> <label for="MA1"> 별로예요 </label>
									</div>	 
									<div>
										<img class="mannerimages"  src="${pageContext.request.contextPath}/resources/images/good.png"    alt="" /><br>
										<input type="checkbox" class="mannerbox" name="prefer" id="MA2" value="MA2" onclick="checkOnlyOne(this)" ><label for="MA2"> 좋아요 </label>
									</div>	 
									<div>
										<img class="mannerimages"  src="${pageContext.request.contextPath}/resources/images/best.png"    alt="" /><br>					
										<input type="checkbox" class="mannerbox" name="prefer" id="MA3" value="MA3" onclick="checkOnlyOne(this)"   > <label for="MA3"> 최고예요💚 </label>
									</div>		 
								</div>		 
								
								<div id="compliDiv">
									<p> 어떤 점이 좋았나요 ? </p>
									<input type="checkbox" class="complibox" name="compliment" id="COM1" value="COM1" onclick="checkCom(this)" > <label for="COM1"> 제가 있는 곳까지 와서 거래했어요. </label><br>
									<input type="checkbox" class="complibox" name="compliment" id="COM2" value="COM2" onclick="checkCom(this)" > <label for="COM2"> 응답이 빨라요. </label><br>
									<input type="checkbox" class="complibox" name="compliment" id="COM3" value="COM3" onclick="checkCom(this)" > <label for="COM3"> 친절하고 매너가 좋아요. </label><br>
									<input type="checkbox" class="complibox" name="compliment" id="COM4" value="COM4" onclick="checkCom(this)" > <label for="COM4"> 시간 약속을 잘 지켜요. </label><br>
								</div>
							</form:form>	
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal"> 취소 </button>
			        <button type="button" class="btn btn-primary" style="background-color: green" id="sendMannerFormbtn" > 후기 보내기 </button>
			      </div>
			    </div>
			  </div>
		</div><%-- end --%>
			<c:if test="${craig.state eq 'CR3' &&  mydonemanner.mannerNo == null}">
			<script>
				 //1) 거래했냐 ? 						 
				document.querySelector("#sendreview").addEventListener('click', (e)=>{
					$('#myModal').modal('show');
				});
				 
				//2) 했다 ~ 
				document.querySelector("#buyerconfirm").addEventListener('click', (e) => {
					$('#myModal').modal('hide'); //원래꺼 닫어
					$('#mySecondModal').modal('show');
				});
				
				//  체크박스 
				const checkOnlyOne = ( input ) => { 
					const checkboxes = document.getElementsByName("prefer");
					checkboxes.forEach( (cb) => {
					  cb.checked = false;		  
					})
			  	
			  		input.checked = true;
				};
				
				const checkCom = ( input ) => { 
			  		const complibox = document.getElementsByName("compliment");
					
			  		if($('input').is(":checked")){
			  			console.log("체크된상태");
			  			
			  			complibox.forEach( (other) => {
			  				if(other != input){
			  					other.checked = false;	
			  				}		  
						});	
			  		}
			  		console.log("선택된애 : ", input);
				};
				
				//  유효성검사 후 폼 전송  
				document.querySelector("#sendMannerFormbtn").addEventListener('click', (e) => {
					
					const checkboxes = document.getElementsByName("prefer");
					const prefer = document.querySelectorAll("[name=prefer]");
					let type;
					
					checkboxes.forEach((preferType) => {
						if(preferType.checked == true){
							type = preferType;
						}
					});
					
					if(type == null){
						alert("거래 선호도를 반드시 하나는 선택해주셔야해요 !");
						return false;
					}
					else{
						document.craigMannerFrm.submit();
					 	setTimeout( () => window.close(), 2500 );	
					}
					
				});//end 
			</script>
			</c:if>
			
<!--  msg - alert    -->
<div id="successModal" class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel" style="color: black"> 🥒매너평가완료 </h5>
        <button type="button" class="close" data-dismiss="modal"  data-target="myModal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        </br>거래 후기를 성공적으로 보냈습니다 💚
      </br></br></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="statemodalcfm" data-dismiss="modal">확인</button>     
      </div>
    </div>
  </div>
</div>	
<c:if test="${not empty msg}">
	<script>
	$('#successModal').modal('show');
	</script>
</c:if>		
<%-- <%-- ★★★★★★★★★    ε=ε=ε=(~￣▽￣)~ 혜진 거래후기보내기  끝   ε=ε=ε=(~￣▽￣)~  ★★★★★★★★★ --%>			


			<!----------- 약속잡기 Modal start ------------->
			<div class="modal fade" id="meetingModal" tabindex="-1" aria-labelledby="meetingModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="meetingModalLabel">약속잡기</h5>
			      </div>
			      <div class="modal-body" style="height: 270px;">
			        <div id="meetingWrap" >
						<!-- datePicker 넣을 div -->
						<div id="datePicker" class="d-flex justify-content-center"></div>
						<div id="timeWrap" class="d-flex justify-content-center" style="margin-top: 220px;">
							<form id="timeForm">
								<input type="time" name="time" id="time"/>
							</form>			
						</div>	
					</div>
			      </div>
			      <div class="modal-footer ">
			        <button id="saveMeeting" type="button" class="btn btn-primary">약속 등록</button>
			      </div>
			    </div>
			  </div>
			</div>
			<!------------ 약속잡기 Modal end -------------->
			
			<!----------- 위치공유 Modal start ------------->
			<div class="modal fade" id="locationModal" tabindex="-1" aria-labelledby="locationModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="locationModalLabel">장소공유</h5>
			      </div>
			      <div class="modal-body" style="height: 400px;">
						<div id="map" style="width:450px;height:400px;"></div>
						<input type="text" id="placeName" placeholder="장소명을 입력해주세요"/>
			      </div>
			      <div class="modal-footer ">
			        <button id="savePlace" type="button" class="btn btn-primary" style="position: relative; z-index: 10;">장소등록</button>
			      </div>
			    </div>
			  </div>
			</div>
			<!------------ 위치공유 Modal end ------------->
			
		<!----------------------------- 게시글정보 end ------------------------------>
	
			<!-------------- 채팅방 메시지내용 start  ------------>
			<div id="message-container" class="messages scrollarea" style="overflow-y: scroll;">
				<ul class="list-unstyled">
					<c:forEach items="${craigMsgs}" var="craigMsg">
						
						<!-- java.util.Date 빈등록  -->
						<jsp:useBean id="sentTime" class="java.util.Date"/>
						
						<!---------- 내가 보낸 메시지 start ----------->
						<c:if test="${memberId == craigMsg.writer}">
							<jsp:setProperty name="sentTime" property="time" value="${craigMsg.sentTime}"/>
							
							<!-- 채팅인 경우 -->
							<c:if test="${craigMsg.type == 'CHAT'}">
								<li class="replies">
									<p>${craigMsg.content}</p>	
									<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="a hh:mm"/></span>
								</li>
							</c:if>
							
							<!-- 첨부파일인 경우 -->
							<c:if test="${craigMsg.type == 'FILE'}">
								<li class="replies">
									<div class="attachFile">
										<img class="attachImg" src="${pageContext.request.contextPath}/resources/upload/chat/craig/${craigMsg.content}" alt="" />
									</div>
									<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="a hh:mm"/></span>
								</li>
							</c:if>
							
							<!-- 예약인 경우 -->
							<c:if test="${craigMsg.type == 'BOOK'}">
								<li class="book"> 
									<div>
										<span>${chatUser.nickname} 님이 ${craigMsg.content} 에 약속을 만들었어요.<br>약속은 꼭 지켜주세요!</span>								
									</div>
								</li>
							</c:if>
							
							<!-- 장소인 경우 -->
							<c:if test="${craigMsg.type == 'PLACE'}">
								<li class="replies">
									<div id="placeMap" onload="placeMap.relayOut();"></div>
									<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="a hh:mm"/></span>
								</li>
							</c:if>
						</c:if>
						<!---------- 내가 보낸 메시지 end ----------->
						
						<!---------- 남이 보낸 메시지 start ----------->
						<c:if test="${memberId != craigMsg.writer}">
							<jsp:setProperty name="sentTime" property="time" value="${craigMsg.sentTime}"/>
							
							<!-- 채팅인 경우 -->
							<c:if test="${craigMsg.type == 'CHAT'}">
								<li class="sent">
									<img class="profImg" src="${pageContext.request.contextPath}/resources/upload/profile/${otherUser.profileImg}" alt="">
									<p>${craigMsg.content}</p>	
									<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="a hh:mm"/></span>
								</li>
							</c:if>
							
							<!-- 첨부파일인 경우 -->
							<c:if test="${craigMsg.type == 'FILE'}">
								<li class="sent">
									<img class="profImg" src="${pageContext.request.contextPath}/resources/upload/profile/${otherUser.profileImg}" alt="">
									<div class="attachFile">
										<img class="attachImg" src="${pageContext.request.contextPath}/resources/upload/chat/craig/${craigMsg.content}" alt="" />
									</div>
									<span class="msg_time attach"><fmt:formatDate value="${sentTime}" pattern="a hh:mm"/></span>
								</li>
							</c:if>
							
							<!-- 예약인 경우 -->
							<c:if test="${craigMsg.type == 'BOOK'}">
								<li class="book"> 
									<div>
										<span>${otherUser.nickname} 님이 ${craigMsg.content} 에 약속을 만들었어요.<br>약속은 꼭 지켜주세요!</span>								
									</div>
								</li>
							</c:if>
							
							<!-- 장소인 경우 -->
							<c:if test="${craigMsg.type == 'PLACE'}">
								<li class="sent">
									<div id="placeMap" onload="placeMap.relayOut();"></div>
									<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="a hh:mm"/></span>
								</li>
							</c:if>
						</c:if>
						<!---------- 남이 보낸 메시지 end ----------->
					</c:forEach> <!-- forEach end -->
				</ul>
			</div>
			<!-------------- 채팅방 메시지내용 end  -------------->
			
			<!-------------- 메시지 입력창 start  --------------->
			<div class="card-footer">
				<div class="message-input">
					<input type="text" id="msg" placeholder="메시지 보내기">
					<i id="attachClip" class="fa fa-paperclip attachment" aria-hidden="true"></i>					
					<button id="sendBtn" type="button">
						<svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
							width="20" height="20" fill="currentColor"
							class="bi bi-send-fill" viewBox="0 0 16 16">
	 						<path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z" />
						</svg>
					</button>
				</div>
				<!-------------- 메시지 입력창 end --------------->
				<!-- 첨부파일 start  -->
				<div id="fileWrap" class="custom-file" style="display: none;">
					<input type="file" class="custom-file-input" name="upFile" id="upFile" multiple>
		    		<label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
				</div>
				<!-- 첨부파일 end  -->	
			</div>
		</div> <!-- div.card end -->
	</div> <!-- div.chat end  -->

<sec:authorize access="isAuthenticated()">

<!-- stomp, sockjs -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"
	integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"
	integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!----------- script 시작  ---------->
<script>
const ws = new SockJS(`http://\${location.host}${pageContext.request.contextPath}/stomp`);
const stompClient = Stomp.over(ws);

// 채팅방아이디 
const chatroomId = '${chatroomId}';
// 로그인한 사용자 아이디
const memberId = '${memberId}';
// 로그인한 사용자 객체
const chatUser = '${chatUser}';
// 로그인한 사용자 동
const dong = '${dong}';
// 로그인한 사용자 프로필이미지
const profImg = '${chatUser.profileImg}';
// 상대방 프로필이미지
const otherImg = '${otherUser.profileImg}';
// 상대방 객체
const otherUser = '${otherUser}';

// csrf 토큰  
const csrfHeader = "${_csrf.headerName}";
const csrfToken = "${_csrf.token}";
const headers = {};
headers[csrfHeader] = csrfToken;


/********************* 사용자 신고 *************************/
/* 체크박스 제어 */
const checkOnlyOne = (element) => {
  
  const checkboxes = document.getElementsByName("reasonNo"); // reasonNo -> NodeList
  
  checkboxes.forEach((cb) => {
    cb.checked = false; // 모든 체크박스 체크 해제
  })
  
  element.checked = true; // element: onclick(this) 적어놓은 태그 
};

/* 유효성 검사 */
document.querySelector("#saveReport").addEventListener('click', (e) => {
	
	const reportTypes = document.querySelectorAll("[name=reasonNo]");
	let type;
	let reasonNo;
	
	console.log(reportTypes);
	reportTypes.forEach((reportType) => {
		if(reportType.checked == true){
			type = reportType.dataset.reportType;
			reasonNo = reportType.value;
		}
	});
	
	if(type == null){
		alert("사유를 선택해주세요.");
		return false;
	} else {
		if(confirm('신고하시겠습니까?')){
			$("#reportModal").modal('hide'); // 모달 감추기	 
			// USER_REPORT insert처리 
		    $.ajax({
		        headers,
		        url : '${pageContext.request.contextPath}/report/chat/userReportEnroll.do',
		        dataType : 'json',
		        data : {
		        	writer: '${chatUser.memberId}',
					reasonNo: reasonNo,
					reportedMember: '${otherUser.memberId}'
		        },
		        type : "POST",
		        success(){
		        },
		        error: console.log
		    });   
			alert("신고 완료되었습니다.");
		    $('.action_menu').toggle(); // 메뉴토글 닫기
		}
	}	
});


/********************* 장소공유 관련 *************************/
var container = document.getElementById('map');
var map;

let meetingLat;
let meetingLon;

$(document).ready(function(){
	if(navigator.geolocation){
		// 현위치 가져오기
		navigator.geolocation.getCurrentPosition(function(position){
			let lat = position.coords.latitude; // 위도
			let lon = position.coords.longitude; // 경도

			const options = {
					center: new kakao.maps.LatLng(lat,lon),
					level: 2
			}
			map = new kakao.maps.Map(container, options); // map 생성
			
			// marker 생성
			var marker = new kakao.maps.Marker({
				position: map.getCenter()
			});
			marker.setMap(map);
			
			// 지도 클릭 마커표시 이벤트 
			kakao.maps.event.addListener(map, 'click', function(mouseEvent){
			    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
			    
				// 클릭한 위도, 경도
				var latlng = mouseEvent.latLng;
				
				meetingLat = latlng.getLat(); // 위도
				meetingLon = latlng.getLng(); // 경도 
				
	            // 마커를 클릭한 위치에 표시
	            marker.setPosition(latlng);
	 
	            var iwPosition = mouseEvent.latLng;
	            
	            document.querySelector("#savePlace").addEventListener('click', (e) => {
					const placeName = document.querySelector("#placeName").value;
					console.log(placeName);

					// 인포윈도우 내용   
					var iwContent = 
						`<div style="padding:5px;">
							\${placeName}<br><a href="https://map.kakao.com/link/to/\${placeName},\${meetingLat},\${meetingLon}" style="color:blue" target="_blank">길찾기</a>
						</div>`;
					
					// 인포윈도우 생성
					var infowindow = new kakao.maps.InfoWindow({
					    position : iwPosition, 
					    content : iwContent 
					});
					
					infowindow.open(map, marker); 
	            }); // 장소등록 끝
				
			}); // 마커표시 끝
			
			
		}); // 현위치 가져오기 끝
		
		
	} // if 끝
	else {
		// 현위치를 알수없을때는 사용자 정보에서 동을 가져와 입력 
		let lon = ${dong.longitude};
		let lat = ${dong.latitude};
		
		const options = {
			center: new kakao.maps.LatLng(lat,lon),
			level: 2
		}
		map = new kakao.maps.Map(container, options);
	} // else 끝
	
});


// 모달열릴때 지도 크기조절
$("#locationModal").on('shown.bs.modal', function(){
	 map.relayout();
});

// 장소채팅 로드 
window.onload = function(){
	const placeMsg = '${placeMsg}';
	
	if(placeMsg != null){
		const placeCont = '${placeMsg.content}';
		
		let chatLat = placeCont.split(',')[0];
		let chatLon = placeCont.split(',')[1];
		let chatPlaceName = placeCont.split(',')[2];
		
		console.log(placeCont.split(',')[2]);
		
		
		$(document).ready(function(){
			var placeContainer = document.getElementById('placeMap');
			var placeMap;
		
			const options = {
					center: new kakao.maps.LatLng(chatLat, chatLon),
					level: 2
			}
			placeMap = new kakao.maps.Map(placeContainer, options); // map생성
			
			// marker 생성
			var placeMarker = new kakao.maps.Marker({
				position: new kakao.maps.LatLng(chatLat, chatLon)
			});
			placeMarker.setMap(placeMap);
			
			// 인포윈도우 내용   
			var chatIwContent = 
				`<div style="padding:5px;">
					\${chatPlaceName}<br><a href="https://map.kakao.com/link/to/\${chatPlaceName},\${chatLat},\${chatLon}" style="color:blue" target="_blank">길찾기</a>
				</div>`;
			
			// 인포윈도우 생성
			var chatInfowindow = new kakao.maps.InfoWindow({
			    position : new kakao.maps.LatLng(chatLat, chatLon), 
			    content : chatIwContent  
			});
			
			chatInfowindow.open(placeMap, placeMarker); 
		
		});
		
		
	};
		
		
}



// 장소등록
document.querySelector("#savePlace").addEventListener('click', (e) => {
	const placeName = document.querySelector("#placeName").value;
	console.log(placeName);
	// 장소명 미입력시
	if (placeName == ""){
		alert("장소명을 입력해주세요");
		return;
	}
	
	let meetingPlace = meetingLat + ',' + meetingLon + ',' + placeName;
	
	// craig_meeting에서 해당 행 update 처리
    $.ajax({
        headers,
        url : '${pageContext.request.contextPath}/craigMeeting/enrollMeetingPlace',
        data : {
			no: '${craig.no}', meetingLat, meetingLon
        },
        type : "POST",
        success(){
			// 장소 메시지 전송 처리
	        const payload = {
	        	chatroomId,
             	writer : '<sec:authentication property="principal.username"/>',
             	content : meetingPlace,
             	sentTime : Date.now(),
             	type : 'PLACE',
            }
	        stompClient.send(`/app/craigChat/${chatroomId}`, {}, JSON.stringify(payload));

			// 장소공유 버튼 감추기    
			$("#meetingPlace").css({
				"display" : "none"
			}); 
			
			$("#locationModal").modal('hide'); // 모달 감추기	 
        },
        error: console.log
    });   
});


/********************* 약속잡기 관련 *************************/
// meetingDate 변수 선언
let meetingDate;

/* Datepicker */
$(function(){
	$("#datePicker").datepicker({
	    maxViewMode: 1,
	    language: "ko",
	    todayHighlight: true,
	    startDate: '-0d',
	    endDate: '+7d',
	    autoclose: true
	})
	.on("changeDate", function(e){
		console.log(e);
		meetingDate = e.date;
	
	})
	$('.datepicker').css({
		"position" : "absolute",
		"z-index" : "100",
		"background-color" : "white",
		"border" : "1px solid black",
		"margin-left" : "10px"
	});
	$('.datepicker table').css({
		"margin" : "0 auto"
	});
});


/* 예약 */
document.querySelector("#saveMeeting").addEventListener('click', (e) => {
	const frm = document.querySelector("#timeForm");
	const time = frm.time.value; // 19:12
	
	const dateBtn = document.querySelector("#meetingDate");
	const placeBtn = document.querySelector("#meetingPlace");
	
	
	/* 대화이력 조회 start */
	 $.ajax({
	        headers,
	        url : '${pageContext.request.contextPath}/chat/criagMsgCnt',
	        data : {chatroomId},
	        dataType: "json",
	        type : "GET",
	        success(data){
	  			
	        	// 채팅방 대화이력 없을때
	        	if(data == 0){
	        		console.log("메시지없음");
	        		alert("상대방과 대화한 후에 약속을 잡을 수 있어요.");
	        		frm.reset(); // 시간폼 초기화
	        		$("#datePicker").datepicker("clearDates"); // datepicker 초기화
	        		$("#meetingModal").modal('hide'); // 모달 감추기	
	        		
	        	} else {
	        	// 채팅방 대화이력 있을때
	        		if(!time){
	        			alert("시간을 선택해주세요.");
	        		}
	        		else if(!meetingDate){
	        			alert("날짜를 선택해주세요.");
	        		}
	        		else{
	        			// meetingDate의 시간을 사용자가 입력한 값으로 바꿔준다 // Wed Apr 12 2023 19:12:00 GMT+0900 (한국 표준시)
	        			meetingDate.setHours(time.substring(0, 2));
	        			meetingDate.setMinutes(time.slice(-2)); 
	        			
	        			
	        			// date버튼 html용 
	        			let mon = meetingDate.getMonth() + 1;
	        			let day = meetingDate.getDate();
	        			const weekday = ['일', '월', '화', '수', '목', '금', '토'];
	        			let week = weekday[meetingDate.getDay()];
	        			let times = convertTime(meetingDate);
	        			
	        			let dateHtml = mon + '/' + day + '(' + week + ') ' + times;
	        			console.log(dateHtml);
	        			
	        			// 07:19 
	        			// hours가 10보다 작다면 앞에 0, 
	        			// 오전 12시는 0 으로 찍힘 
	        			

	        			// 2023-04-12 19:12 형식으로 변환
	        			let date = meetingDate.getFullYear() + '-' 
	        						+ ( (meetingDate.getMonth() + 1) < 9 ? 
	        								"0" + (meetingDate.getMonth() + 1) : (meetingDate.getMonth() + 1)) + '-'
	        						+ ( (meetingDate.getDate()) < 10 ? 
	        								"0" + (meetingDate.getDate()) : (meetingDate.getDate()) ) + ' '
	        						+ ( (meetingDate.getHours()) < 10 ?
	        								"0" + (meetingDate.getHours()) : (meetingDate.getHours()) ) + ':' 
	        						+ ( meetingDate.getMinutes() < 10 ? 
	        								"0" + (meetingDate.getMinutes()) : (meetingDate.getMinutes()));
	        			meetingDate = date;
	        		
	        			
	        		/* 중고거래 예약 테이블에 행 추가 */
	        	    $.ajax({
	        		        headers,
	        		        url : '${pageContext.request.contextPath}/craigMeeting/enrollMeeting',
	        		        data : {
	        					chatroomId, memberId, meetingDate
	        		        },
	        		        type : "POST",
	        		        success(data){
	        					
	        		        	// 약속 메시지 보내기
	        			        const payload = {
	        				        	chatroomId,
	        			             	writer : '<sec:authentication property="principal.username"/>',
	        			             	content : dateHtml,
	        			             	sentTime : Date.now(),
	        			             	type : 'BOOK',
	        			            }
	        				        stompClient.send(`/app/craigChat/${chatroomId}`, {}, JSON.stringify(payload));
	        		        	
	        		        },
	        		        error: console.log
	        		    });  
	        		
	        				
	        			document.querySelector(".btnWrap").innerHTML += `
	        				<button id="meetingDate" type="button" class="btn btn-success">\${dateHtml}</button>
	        				<button id="meetingPlace" type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#locationModal">장소공유</button>
	        			`

	        			$("#meeting").css({
	        				"display" : "none"
	        			}); 	
	        			
	        			$(".craig_status").html("예약중");
	        			
	        			$("#meetingModal").modal('hide'); // 모달 감추기	        	
	        		
	        		} /* else절 끝*/
	
	        	} /* success 끝 */
	    	
	        },
	        error: console.log
		  
 		});  /* 대화이력 조회 end */
});





/********************* 첨부파일 관련 *************************/
document.querySelector("#sendBtn").addEventListener("click", (e) => {

    const formData = new FormData();
    const file = document.querySelector("#upFile").files[0];
    console.log(file);    
    formData.append("file", file);
    formData.append("memberId", memberId);

    if(!file) return;
    
    
    // 2. 첨부파일 가져오기
    $.ajax({
        headers,
        url : '${pageContext.request.contextPath}/chat/craigChatAttach',
        processData : false,
        contentType : false, 
        data : formData,
        dataType: "json",
        type : "POST",
        success(data){
        	console.log("첨부파일 전송시입니다");
   			const {profileImg, attach} = data;
	        const payload = {
	        	chatroomId,
             	writer : '<sec:authentication property="principal.username"/>',
             	content : attach.reFilename,
             	sentTime : Date.now(),
             	type : 'FILE',
             	prof : profileImg
            }
	        stompClient.send(`/app/craigChat/${chatroomId}`, {}, JSON.stringify(payload));
            
        },
        error: console.log
    });    
    
    const fileInput = document.querySelector("#upFile");
    
	$('#fileWrap').toggle(); // 파일토글 닫기
	const label = fileInput.nextElementSibling;
	fileInput.value = ''; // 파일 초기화 
	label.innerHTML = '파일을 선택하세요'	; // 라벨 초기화
	
	
});


document.querySelector("#upFile").addEventListener("change", (e) => {
	const file = e.target.files[0];
	const label = e.target.nextElementSibling;
	
	if(file) // 업로드된 파일이 있다면
		label.innerHTML = file.name; // label에 file이름 작성
		
	else
		label.innerHTML = '파일을 선택하세요'	;
});


/********************* 일반 메시지 전송 *************************/
document.querySelector("#sendBtn").addEventListener("click", (e) => {
	// 1. input에 작성한 메세지내용 가져오기
	const msg = document.querySelector("#msg");
	if(!msg.value) return; // 메시지 없을시 return 
	
	// 2. payload : CraigMsg와 규격 맞춤
	const payload = {
		chatroomId,
		writer : '<sec:authentication property="principal.username"/>',
		content : msg.value,
		sentTime : Date.now(),
		type : 'CHAT',
		prof : '${chatUser.profileImg}'
	};
	
	// 3. 전송
	stompClient.send(`/app/craigChat/${chatroomId}`, {}, JSON.stringify(payload));
	msg.value = '';
	msg.focus();
}); 
	
/********************* 구독 *************************/
stompClient.connect({}, (frame) => {
	
	stompClient.subscribe("/app/craigChat/${chatroomId}", (message) => {		
		// content type 헤더에 담기
		const {'content-type' : contentType} = message.headers;
		
		// 받아온 json 구조분해할당
		const {writer, content, sentTime, type, prof} = JSON.parse(message.body);
		const time = convertTime(new Date(sentTime)); // jquery Date으로 변경 + 12시간 변환함수
		
		
		const ul = document.querySelector("#message-container ul");

		if(contentType){
			
			/*** ------- 내가 보낸 메시지 start ------- ***/
			if(memberId == writer){
				
				/* 메시지 유형이 chat */
				if( type == 'CHAT'){
					ul.innerHTML += `
					<li class="replies">
						<p>\${content}</p>	
						<span class="msg_time">\${time}</span>
					</li>
					`;
				} 
				
				/* 메시지 유형이 file */
				else if ( type == 'FILE'){
					const li = document.createElement("li");
					li.classList.add("replies");
	
					const div = document.createElement("div");
					div.classList.add("attachFile");
					
					const img = document.createElement("img");
					img.classList.add("attachImg");
					img.src = `${pageContext.request.contextPath}/resources/upload/chat/craig/\${content}`;
					div.append(img);
	
					const span = document.createElement("span");
					span.classList.add("msg_time");
					span.innerHTML = `\${time}`;
					
					li.append(div, span);
					ul.append(li);
				}
				
				/* 메시지 유형이 place */
				else if ( type == 'PLACE'){
					const li = document.createElement("li");
					li.classList.add("replies");
	
					const div = document.createElement("div");
					div.id = "placeMap";
					div.setAttribute("onload", "placeMap.relayout();");
		
					const span = document.createElement("span");
					span.classList.add("msg_time");
					span.innerHTML = `\${time}`;
					
					li.append(div, span);
					ul.append(li);	
			
					// content에서 위/경도, 장소명 가져오기
					let places = content.split(',');
					const meetingLat = places[0];
					const meetingLon = places[1];
					const placeName = places[2];
					
					console.log(meetingLat);
					console.log(meetingLon);
					console.log(placeName);
					
			   		 // 장소채팅용 map 
			        var placeMapContainer = document.getElementById("placeMap"),
			        	mapOption = {
			        	center : new kakao.maps.LatLng(meetingLat, meetingLon),
			        	level: 2
			        };
			   		var placeMap = new kakao.maps.Map(placeMapContainer, mapOption);
			    	
			   		// 마커
			   		var placeMarker = new kakao.maps.Marker({
			    		position: new kakao.maps.LatLng(meetingLat, meetingLon)
			    	});
			    	
			    	placeMarker.setMap(placeMap);
			    	
					// 인포윈도우 내용   
					var iwContent = 
						`<div style="padding:5px;">
							\${placeName}<br><a href="https://map.kakao.com/link/to/\${placeName},\${meetingLat},\${meetingLon}" style="color:blue" target="_blank">길찾기</a>
						</div>`;
					
					// 인포윈도우 생성
					var infowindow = new kakao.maps.InfoWindow({
					    position : new kakao.maps.LatLng(meetingLat, meetingLon), 
					    content : iwContent 
					});
					
					infowindow.open(placeMap, placeMarker); 
				}
				
				/* 메시지 유형이 book*/
				if( type == 'BOOK'){
					const myNick = '${chatUser.nickname}';
					ul.innerHTML += `
					<li class="book"> 
						<div>
							<span>\${myNick} 님이 \${content} 에 약속을 만들었어요.<br>약속은 꼭 지켜주세요!</span>
						</div>
					</li>
					`;
				}
			}/*** ------- 내가 보낸 메시지 end ------- ***/
				
			/*** ------- 상대방이 보낸 메시지 start ------- ***/
			if(memberId != writer){
	
				/* 메시지 유형이 chat */
				if( type == 'CHAT'){
					const li = document.createElement("li");
					li.classList.add("sent");
	
					const img = document.createElement("img");
					img.classList.add("profImg");
					img.src = `${pageContext.request.contextPath}/resources/upload/profile/\${otherImg}`;
					
					const p = document.createElement("p");
					p.innerHTML = `\${content}`;
					
					const span = document.createElement("span");
					span.classList.add("msg_time");
					span.innerHTML = `\${time}`;
					
					li.append(img, p, span);
					ul.append(li);
				} 

				/* 메시지 유형이 file */
				else if ( type == 'FILE'){
					const li = document.createElement("li");
					li.classList.add("sent");
	
					const img = document.createElement("img");
					img.classList.add("profImg");
					img.src = `${pageContext.request.contextPath}/resources/upload/profile/\${otherImg}`;
					
					const div = document.createElement("div");
					div.classList.add("attachFile");
					
					const sentImg = document.createElement("img");
					sentImg.classList.add("attachImg");
					sentImg.src = `${pageContext.request.contextPath}/resources/upload/chat/craig/\${content}`;
					div.append(sentImg);
	
					const span = document.createElement("span");
					span.classList.add("msg_time");
					span.classList.add("attach");
					span.innerHTML = `\${time}`;
					
					li.append(img, div, span);
					ul.append(li);
				}
				/* 메시지 유형이 place */
				else if ( type == 'PLACE'){
					const li = document.createElement("li");
					li.classList.add("sent");
		
					const img = document.createElement("img");
					img.classList.add("profImg");
					img.src = `${pageContext.request.contextPath}/resources/upload/profile/\${otherImg}`;
					
					const div = document.createElement("div");
					div.id = "placeMap";
					div.setAttribute("onload", "placeMap.relayout();");
		
					const span = document.createElement("span");
					span.classList.add("msg_time");
					span.innerHTML = `\${time}`;
					
					li.append(img, div, span);
					ul.append(li);	
			
					// content에서 위/경도, 장소명 가져오기
					let places = content.split(',');
					const meetingLat = places[0];
					const meetingLon = places[1];
					const placeName = places[2];
					
					console.log(meetingLat);
					console.log(meetingLon);
					console.log(placeName);
					
			   		 // 장소채팅용 map 
			        var placeMapContainer = document.getElementById("placeMap"),
			        	mapOption = {
			        	center : new kakao.maps.LatLng(meetingLat, meetingLon),
			        	level: 2
			        };
			   		var placeMap = new kakao.maps.Map(placeMapContainer, mapOption);
			    	
			   		// 마커
			   		var placeMarker = new kakao.maps.Marker({
			    		position: new kakao.maps.LatLng(meetingLat, meetingLon)
			    	});
			    	
			    	placeMarker.setMap(placeMap);
			    	
					// 인포윈도우 내용   
					var iwContent = 
						`<div style="padding:5px;">
							\${placeName}<br><a href="https://map.kakao.com/link/to/\${placeName},\${meetingLat},\${meetingLon}" style="color:blue" target="_blank">길찾기</a>
						</div>`;
					
					// 인포윈도우 생성
					var infowindow = new kakao.maps.InfoWindow({
					    position : new kakao.maps.LatLng(meetingLat, meetingLon), 
					    content : iwContent 
					});
					
					infowindow.open(placeMap, placeMarker); 
					
					// 장소공유 버튼 감추기    
					$("#meetingPlace").css({
						"display" : "none"
					}); 
				}
				/* 메시지 유형이 book*/
				if( type == 'BOOK'){
					const otherNick = '${otherUser.nickname}';
					ul.innerHTML += `
					<li class="book"> 
						<div>
							<span>\${otherNick} 님이 \${content} 에 약속을 만들었어요.<br>약속은 꼭 지켜주세요!</span>
						</div>
					</li>
					`;
					
					document.querySelector(".btnWrap").innerHTML += `
						<button id="meetingDate" type="button" class="btn btn-success">\${content}</button>
						<button id="meetingPlace" type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#locationModal">장소공유</button>
						`

					$("#meeting").css({
						"display" : "none"
					}); 	
		
					$(".craig_status").html("예약중");
				}
			}/*** ------- 상대방이 보낸 메시지 end ------- ***/
		
		}
		// 메시지창 끌어올리기
		$('#message-container').scrollTop($('#message-container')[0].scrollHeight);
	}); // 구독 끝 
});



/********************* 채팅방 나가기 *************************/
document.querySelector("#craigExit").addEventListener("click", (e) => {
	$.ajax({
		url : `${pageContext.request.contextPath}/chat/updateDel.do?memberId=\${memberId}&chatroomId=\${chatroomId}`,
		method : 'POST',
		headers,
		success(data){
			
		},
		error : console.log,
		complete(){
			window.close();
		}
	});
});




/* 채팅시간 12시간으로 변환하는 함수 */
function convertTime(now){
	let hour = now.getHours();
	let min = now.getMinutes();
	let daynight;
	
	console.log(hour + "시간찍어"); // 11
	if (hour < 12){
		daynight = '오전';
		
		if(hour == '0'){
			daynight = '오전';
			hour = '12';
		}
	}
	else {
		daynight = '오후';
		hour -= 12;
		
		if (hour < 10){
			hour = '0' + hour;
		}
	} 

	if (min < 10){
		min = '0' + min;
	}
	
	const convertedTime = daynight + ' ' + hour + ':' + min + ' ';
	return convertedTime;
}

/* 첨부파일 버튼 토글 */
$('i').click(function(){
	$('#fileWrap').toggle();
});

/* 채팅방 메뉴버튼 토글  */
$(document).ready(function(){
	$('#action_menu_btn').click(function(){
		$('.action_menu').toggle();
	});
});

		
/* 채팅방 스크롤 최하단 고정  */		
$(document).ready(function(){
	$('#message-container').scrollTop($('#message-container')[0].scrollHeight);
});

/* 팝업창크기  */
$(document).ready(function(){
	const wid = $(document).outerWidth();
	const hei = $(document).outerHeight() + 60;
	console.log(hei);
	window.resizeTo(wid, hei);
});

/* 버튼 보이기설정 */
$(document).ready(function(){
	$("#meetingDate").css({
		"display" : "block"
	});
});



</script>
</sec:authorize>

</body>
</html>