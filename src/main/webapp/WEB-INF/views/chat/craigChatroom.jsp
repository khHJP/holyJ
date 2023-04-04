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
		<div class="chat">
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
							<li id="craigReport">신고하기</li>
							<li id="craigExit">채팅방 나가기</li>
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
							<jsp:useBean id="sentTime" class="java.util.Date"/>
							<!-- 내가 보낸 메시지일때 -->
							<c:if test="${memberId == craigMsg.writer}">
								<jsp:setProperty name="sentTime" property="time" value="${craigMsg.sentTime}"/>
								<c:if test="${craigMsg.type == 'CHAT'}">
									<li class="replies">
										<p>${craigMsg.content}</p>	
										<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="hh:mm a"/></span>
									</li>
								</c:if>
								<c:if test="${craigMsg.type == 'FILE'}">
									<li class="replies">
										<div class="attachFile">
											<img class="attachImg" src="${pageContext.request.contextPath}/resources/upload/chat/craig/${craigMsg.content}" alt="" />
										</div>
										<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="hh:mm a"/></span>
									</li>
								</c:if>
							</c:if>
							<!-- 다른사람이 보낸 메시지일때 -->
							<c:if test="${memberId != craigMsg.writer}">
								<jsp:setProperty name="sentTime" property="time" value="${craigMsg.sentTime}"/>
								<li class="sent">
									<img class="profImg" src="${pageContext.request.contextPath}/resources/upload/profile/${otherUser.profileImg}" alt="">
									<p>${craigMsg.content}</p>	
									<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="hh:mm a"/></span>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				<!-- 채팅방 메시지내용 end  -->
				
				<div class="message-input">
	
					<input type="file" class="custom-file-input" name="upFile" id="upFile" multiple>
		    		<label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		    		<button style="position: relative; z-index: 1000; background-color: black;" id="upFileBtn">사진보내기</button>

						<input type="text" id="msg" placeholder="메시지 보내기">
						<i class="fa fa-paperclip attachment" aria-hidden="true"></i>					
						<button id="sendBtn" type="button">
							<svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
								width="20" height="20" fill="currentColor"
								class="bi bi-send-fill" viewBox="0 0 16 16">
	  						<path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z" />
							</svg>
						</button>
				</div>
			</div>
		</div>

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

/************************ 메시지관련 시작 *************************/
const ws = new SockJS(`http://\${location.host}${pageContext.request.contextPath}/stomp`);
const stompClient = Stomp.over(ws);

// 채팅방아이디 
const chatroomId = '${chatroomId}';
const memberId = '${memberId}';
const profImg = '${chatUser.profileImg}';

// csrf 토큰  
const csrfHeader = "${_csrf.headerName}";
const csrfToken = "${_csrf.token}";
const headers = {};
headers[csrfHeader] = csrfToken;

/* 채팅방 나가기 */
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


/* 첨부파일 선택 버튼 */
document.querySelector("i").addEventListener("click", (e) => {
	const div = document.querySelector(".custom-file")
	if(div.style.display == "none"){
		div.style.display = "block";	
	} else {
		div.style.display = "none";
	}
});


document.querySelector("#upFile").addEventListener("change", (e) => {
	const file = e.target.files[0];
	const label = e.target.nextElementSibling;
	
	if(file) // 업로드된 파일이 있다면
		label.innerHTML = file.name; // label에 file이름 작성
		
	else
		label.innerHTML = '파일을 선택하세요'	;
});


/* 첨부파일 전송시 */
document.querySelector("#upFileBtn").addEventListener('click', (e) => {

    const formData = new FormData();
    const file = document.querySelector("#upFile").files[0];
    console.log(file);    
    formData.append("file", file);
    formData.append("memberId", memberId);

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
    
});

/* 메시지 전송하기 */
document.querySelector("#sendBtn").addEventListener("click", (e) => {
	e.preventDefault();
	
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
	
stompClient.connect({}, (frame) => {
	/* 구독하기  */	
	stompClient.subscribe(`/app/craigChat/${chatroomId}`, (message) => {
		console.log(`/app/craigChat/${chatroomId} : `, message);
		
		// 받아온 json 구조분해할당
		const {writer, content, sentTime, type, prof} = JSON.parse(message.body);
		const time = convertTime(new Date(sentTime)); // jquery Date으로 변경 + 12시간 변환함수
		
		// 채팅내용 화면에 뿌리기
		const ul = document.querySelector("#message-container ul");
		
		/* 메시지 보낸사람이 로그인한 사용자인지 상대방인지 분기  */
		/* 내 메시지 */
		/* 메시지 유형이 chat */
		if(memberId == writer){
			console.log(type);
			
			if( type == 'CHAT'){
				ul.innerHTML += `
				<li class="replies">
					<p>\${content}</p>	
					<span class="msg_time">\${time}</span>
				</li>
				`;
			} 
			if (type == 'FILE'){
				const li = document.createElement("li");
					li.classList.add("replies");

				const div = document.createElement("div");
					div.classList.add("attach");
				const img = document.createElement("img");
					img.src = `${pageContext.request.contextPath}/resources/upload/chat/craig/\${content}`;
				div.append(img);
				
				const p = document.createElement("p");
					p.innerHTML = `\${content}`;
				const span = document.createElement("span");
					span.classList.add("msg_time");
					span.innerHTML = `\${time}`;
				li.append(div, p, span);
				ul.append(li);
			}
		}
		// 메시지 Type이 file일때
		
		
		
		/* 상대방이 보낸 메시지 */
		if(memberId != writer){
			const li = document.createElement("li");
			li.classList.add("sent");
			const img = document.createElement("img");
			img.src = `${pageContext.request.contextPath}/resources/upload/profile/\${prof}`;
			const p = document.createElement("p");
			p.innerHTML = `\${content}`;
			const span = document.createElement("span");
			span.classList.add("msg_time");
			span.innerHTML = `\${time}`;
			
			li.append(img, p, span);
			ul.append(li);			
		}	

		$('#message-container').scrollTop($('#message-container')[0].scrollHeight);
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
	



	</script>
	</sec:authorize>
</body>
</html>