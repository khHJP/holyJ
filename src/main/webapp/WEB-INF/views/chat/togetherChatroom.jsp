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
					<div class="together_info">
						<span class="together_title">${together.title}</span> 
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
	
			<!-------------- 채팅방 메시지내용 start  ------------>
			<div id="message-container" class="messages scrollarea" style="overflow-y: scroll;">
				<ul class="list-unstyled">
					<c:forEach items="${togetherMsgs}" var="togetherMsg">
						<!-- java.util.Date 빈등록  -->
						<jsp:useBean id="sentTime" class="java.util.Date"/>
						<!---------- 내가 보낸 메시지일때 -->
						<c:if test="${chatUser.memberId == togetherMsg.writer}">
							<jsp:setProperty name="sentTime" property="time" value="${togetherMsg.sentTime}"/>
							<!-- 채팅인 경우 -->
							<c:if test="${togetherMsg.type == 'CHAT'}">
								<li class="replies">
									<p>${togetherMsg.content}</p>	
									<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="a hh:mm"/></span>
								</li>
							</c:if>
							<!-- 첨부파일인 경우 -->
							<c:if test="${togetherMsg.type == 'FILE'}">
								<li class="replies">
									<div class="attachFile">
										<img class="attachImg" src="${pageContext.request.contextPath}/resources/upload/chat/together/${togetherMsg.content}" alt="" />
									</div>
									<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="a hh:mm"/></span>
								</li>
							</c:if>		
						</c:if>
						
						<!------------- 다른사람이 보낸 메시지일때 -->
						<c:if test="${chatUser.memberId != togetherMsg.writer}">
							<jsp:setProperty name="sentTime" property="time" value="${togetherMsg.sentTime}"/>
							<c:set var="otherUser" ></c:set>
							<c:forEach items="${chatMembers}" var="chatMember">
								<c:if test="${chatMember.memberId == togetherMsg.writer}">
									<!-- 채팅인 경우 -->
									<c:if test="${togetherMsg.type == 'CHAT'}">
										<li class="sent">
											<img class="profImg" src="${pageContext.request.contextPath}/resources/upload/profile/${chatMember.profileImg}" alt="">
											<p>${togetherMsg.content}</p>	
											<span class="msg_time"><fmt:formatDate value="${sentTime}" pattern="a hh:mm"/></span>
										</li>
									</c:if>
									<!-- 첨부파일인 경우 -->
									<c:if test="${togetherMsg.type == 'FILE'}">
										<li class="sent">
											<img class="profImg" src="${pageContext.request.contextPath}/resources/upload/profile/${chatMember.profileImg}" alt="">
											<div class="attachFile">
												<img class="attachImg" src="${pageContext.request.contextPath}/resources/upload/chat/together/${togetherMsg.content}" alt="" />
											</div>
											<span class="msg_time attach"><fmt:formatDate value="${sentTime}" pattern="a hh:mm"/></span>
										</li>
									</c:if>
								</c:if>
							</c:forEach>
						
						</c:if>
					</c:forEach>
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

// 채팅방번호 (게시글번호)
const chatroomNo = '${together.no}'
// 로그인한 사용자 아이디
const memberId = '${chatUser.memberId}';
// 로그인한 사용자 객체
const chatUser = '${chatUser}';

// 로그인한 사용자 프로필이미지
const profImg = '${chatUser.profileImg}';


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
        url : '${pageContext.request.contextPath}/chat/togetherChatAttach',
        processData : false,
        contentType : false, 
        data : formData,
        dataType: "json",
        type : "POST",
        success(data){
        	console.log("첨부파일 전송시입니다");
   			const {profileImg, attach} = data;
	        const payload = {
	        	chatroomNo : '${together.no}',
             	writer : '<sec:authentication property="principal.username"/>',
             	content : attach.reFilename,
             	sentTime : Date.now(),
             	type : 'FILE',
             	prof : profileImg
            }
	    	stompClient.send(`/app/togetherChat/${together.no}`, {}, JSON.stringify(payload));
            
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

	
	// 2. payload : TogetherMsg와 규격 맞춤
	const payload = {
		chatroomNo : '${together.no}',
		writer : '<sec:authentication property="principal.username"/>',
		content : msg.value,
		sentTime : Date.now(),
		type : 'CHAT',
		prof : '${chatUser.profileImg}'
	};
	
	// 3. 전송
	stompClient.send(`/app/togetherChat/${together.no}`, {}, JSON.stringify(payload));
	msg.value = '';
	msg.focus();
}); 
	
/********************* 구독 *************************/
stompClient.connect({}, (frame) => {
	
	stompClient.subscribe("/app/togetherChat/${together.no}", (message) => {		
		// content type 헤더에 담기
		const {'content-type' : contentType} = message.headers;
		
		// 받아온 json 구조분해할당
		const {writer, content, sentTime, type, prof} = JSON.parse(message.body);
		const time = convertTime(new Date(sentTime)); // jquery Date으로 변경 + 12시간 변환함수
		
		const chatMembers = '${chatMembers}';
		
		
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
			}/*** ------- 내가 보낸 메시지 end ------- ***/
				
			/*** ------- 상대방이 보낸 메시지 start ------- ***/
			if(memberId != writer){
				
				// 프로필이미지 조회해오기
				$.ajax({
					url : `${pageContext.request.contextPath}/chat/findTogetherMember.do`,
					method : 'GET',
					data : {writer},
					headers,
					dataType: "json",
					success(data){
						const otherImg = data.profileImg;		
						
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
					 	else {
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
						// 메시지창 끌어올리기
						$('#message-container').scrollTop($('#message-container')[0].scrollHeight);
					},
					error : console.log
				});
				

	
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