<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

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
	href="${pageContext.request.contextPath }/resources/css/chat/chatroom.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
	<c:if test="${memberId != craig.writer}">
		<div class="chat h-100">
			<div class="card" style="min-height: 760px; max-height: 100%; min-width: 500px;">
				<!-- 채팅방 헤더 start -->
				<div class="card-header msg_head align-top">
					<div class="d-flex bd-highlight">
						<div class="user_info">
							<span class="nickname">${otherUser.nickname}</span> 
							<span class="manner badge bg-success">${otherUser.manner}</span>
						</div>
						<!-- 메뉴버튼 이미지  -->
						<svg id="action_menu_btn" class="bi bi-three-dots-vertical"
							width="24" height="24" role="img"
							xmlns="http://www.w3.org/2000/svg" fill="currentColor"
							viewBox="0 0 16 16">
						<path
								d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z" />
					</svg>
					</div>
					<!-- 메뉴버튼 토글시  -->
					<div class="action_menu">
						<ul>
							<li>신고하기</li>
							<li>채팅방 나가기</li>
						</ul>
					</div>
				</div>
				<!-- 채팅방 헤더 end -->

				<!-- 게시글정보 start -->
				<div id="craig_bar">
					<div class="craig_info_wrap">
			
						<c:if test="${craigImg[0] == null}">	
							<img style="width: 60px; height: 60px;" src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png" alt="" />
						</c:if>
						<c:if test="${craigImg[0] != null}">
							<img style="width: 60px; height: 60px;" src="${pageContext.request.contextPath}/resources/upload/craig/${craigImg[0].reFilename}"alt="" />
						</c:if>
						<div class="craig_text">
							<p class="craig_status">
								<c:choose>
									<c:when test="${craig.state eq 'CR1'}">
								예약중
								</c:when>
									<c:when test="${craig.state eq 'CR2'}">
								판매중
								</c:when>
									<c:when test="${craig.state eq 'CR3'}">
								판매완료
								</c:when>
								</c:choose>
							</p>
							<p class="craig_name">${craig.title}</p>
							<span class="price"> <fmt:formatNumber
									value="${craig.price}" pattern="#,###" />원
							</span>
						</div>
					</div>
					<button type="button" class="btn btn-outline-secondary">약속잡기</button>
				</div>
				<!-- 게시글정보 end -->

				<!-- 채팅방 메시지내용 start  -->
				<div id="message-container" class="messages scrollarea"
					style="overflow-y: scroll;">
					<ul class="list-unstyled">
						<c:forEach items="${craigMsgs}" var="craigMsg">
							<!-- java.util.Date 빈등록  -->
							<jsp:useBean id="sentTime" class="java.util.Date">
								<jsp:setProperty name="sentTime" property="time" value="${craigMsg.sentTime}"/>
							</jsp:useBean>
							<!-- 내가 보낸 메시지일때 -->
							<c:if test="${memberId == craigMsg.writer}">
	
								<li class="replies">
									<p>${craigMsg.content}</p>	
									<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="hh:mm a"/></span>
								</li>
							</c:if>
							<!-- 다른사람이 보낸 메시지일때 -->
							<c:if test="${memberId != craigMsg.writer}">
								<li class="sent">
									<img src="/oee/resources/upload/profile/${otherUser.profileImg}" alt="">
									<p>${craigMsg.content}</p>	
									<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="hh:mm a"/></span>
								</li>
							</c:if>
						</c:forEach>

					</ul>
				</div>
				<!-- 채팅방 메시지내용 end  -->
				<div class="message-input">
					<div class="wrap">
						<input type="text" id="msg" placeholder="메시지 보내기"> <i
							class="fa fa-paperclip attachment" aria-hidden="true"></i>
						<button id="sendBtn" type="button">
							<svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
								width="20" height="20" fill="currentColor"
								class="bi bi-send-fill" viewBox="0 0 16 16">
	  				<path
									d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z" />
				</svg>
						</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	<sec:authorize access="isAuthenticated()">
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"
			integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw=="
			crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"
			integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g=="
			crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<script>
const ws = new SockJS(`http://\${location.host}${pageContext.request.contextPath}/stomp`);
const stompClient = Stomp.over(ws);

// 채팅방아이디 
const chatroomId = '${chatroomId}';
const memberId = '${memberId}';

/* 메시지 전송하기 */
document.querySelector("#sendBtn").addEventListener("click", (e) => {
	// 1. input에 작성한 메세지내용 가져오기
	const msg = document.querySelector("#msg");
	console.log(msg.value);
	if(!msg.value) return; // 메시지 없을시 return 
	
	// 2. payload : CraigMsg와 규격 맞춤
	const payload = {
		chatroomId,
		writer : '<sec:authentication property="principal.username"/>',
		content : msg.value,
		sentTime : Date.now(),
		type : 'CHAT'
	};
	
	// 3. 전송
	stompClient.send(`/app/craigChat/${chatroomId}`, {}, JSON.stringify(payload));
	msg.value = '';
	msg.focus();
}); 
	
stompClient.connect({}, (frame) => {
	/* 구독하기  */	
	stompClient.subscribe(`/app/craigChat/${chatroomId}`, (message) => {
		console.log(`/app/craigChat/${chatroomId} : `, message);
		
		// 받아온 json 구조분해할당
		const {writer, content, sentTime, type} = JSON.parse(message.body);
		const now = convertTime(new Date(sentTime)); // jquery Date으로 변경 + 12시간 변환함수
		
		// 채팅내용 화면에 뿌리기
		const ul = document.querySelector("#message-container ul");
		
		/* 채팅 보낸사람이 로그인한 사용자인지 상대방인지 분기  */
		if(memberId == writer)
		ul.innerHTML += `
			<li class="replies">
			<p>\${content}</p>	
			<span class="msg_time">\${now}</span>
		</li>
		`;
	});
});

/* 채팅시간 12시간으로 변환하는 함수 */
function convertTime(now){
	let hour = now.getHours();
	const min = now.getMinutes();
	let daynight;
		
	if (hour < 12){
		daynight = '오전';
	} 
	else {
		switch(hour){
		case 12 :
			daynight = '오후';
			break;
		default :
			daynight = '오후';
			hour -= 12;
			hour = '0' + hour;
			break;
		}
	} 
	const convertedTime = hour + ':' + min + ' ' + daynight;
	return convertedTime;
}
	

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

	</script>
	</sec:authorize>
</body>
</html>