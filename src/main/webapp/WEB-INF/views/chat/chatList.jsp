<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나의채팅방" name="title" />
</jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chat/myChatList.css" />
<main id="chatWrap" class="d-flex flex-nowrap">
	<div id="prof-bar" class="d-flex flex-column flex-shrink-0 bg-light"
		style="width: 4.5rem;">
		<a href="${pageContext.request.contextPath}/member/myPage.do"
			class="d-block p-3 link-dark text-decoration-none"> <img
			src="${pageContext.request.contextPath}/resources/upload/profile/${member.profileImg}"
			alt="" style="width: 100%;">
		</a>
		<ul class="nav nav-pills nav-flush flex-column mb-auto text-center">
			<li class="nav-item"><a id="craigBtn" href="#"
				class="nav-link py-3 border-bottom rounded-0" data-toggle="tooltip"
				data-placement="right" aria-label="craigChatList" title="중고거래">
					<svg xmlns="http://www.w3.org/2000/svg" id="craigChat"
						fill="currentColor" viewBox="0 0 16 16" class="bi bi-cart"
						width="24" height="24" role="img" aria-label="craigChatList">
          	<path
							d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
          </svg>
			</a></li>
			<li class="nav-item"><a id="togetherBtn" href="#"
				class="nav-link py-3 border-bottom rounded-0" data-toggle="tooltip"
				data-placement="right" aria-label="togetherChatList" title="같이해요">
					<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor"
						id="togetherChat" class="bi bi-people-fill" viewBox="0 0 16 16"
						width="24" height="24" role="img" aria-label="togetherChatList">
        	<path
							d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z" />
          </svg>
			</a></li>
		</ul>
	</div>


	<div id="chatList"
		class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white"
		style="width: 380px;">
		<div id="nickname"
			class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
			<span>${member.nickname}</span>
		</div>
		<!-- 채팅목록 start  -->
		<div id="chatWrapper"
			class="list-group list-group-flush border-bottom scrollarea"></div>
	</div>

 	<div id="chatLog" class="h-auto d-flex flex-column align-items-stretch flex-shrink-0 bg-white">
 	</div>
</main>


<!----------- script 시작  ---------->

<script>
const member = '${member}';

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
})

/* tooltip클릭시 고정되는것 숨김 */
document.querySelector("#prof-bar").addEventListener('click', (e) => {
	const $a = $("ul li a");
	$a.tooltip('hide');
})

//csrf 토큰  
const csrfHeader = "${_csrf.headerName}";
const csrfToken = "${_csrf.token}";
const headers = {};
headers[csrfHeader] = csrfToken;

/* 중고거래 채팅 클릭 */
document.querySelector("#craigBtn").addEventListener("click", (e) => {
	const chatWrapper = document.querySelector("#chatWrapper");
	
	chatWrapper.innerHTML = ''; // 초기화
	
	// 비동기로 조회
	$.ajax({
		url: `${pageContext.request.contextPath}/chat/findMyCraigChat.do`,
		method : 'GET',
		data : {
		memberId : '${member.memberId}'
		},
		headers,
		dataType: "json",
		success(chatList){
		
			console.log(chatList);
			for(let i = 0; i < chatList.length; i++){
				console.log(chatList[i]);
				
				const chatroomId = chatList[i].chatroomId;
				const craigNo = chatList[i].craigNo;
				const craigTitle = chatList[i].craigTitle;
				const chatCont = chatList[i].lastChat.content;
				let cont = chatCont.substr(0, 10) + ` …`;
				
				
				console.log(chatroomId);	
				
				if(chatList[i].lastChat.type == 'CHAT'){
					chatWrapper.innerHTML += `
					      <a data-chatroom-id="\${chatroomId}" data-craig-no="\${craigNo}" href="#" class="list-group-item list-group-item-action py-3 lh-sm" aria-current="true">
					        <div class="chatList-wrap" class="d-flex w-100 align-items-center justify-content-between">
					        	<div class="forTitle">
							        <span>\${craigTitle}</span>
					        	</div>		
					        	 <img src="${pageContext.request.contextPath}/resources/upload/profile/\${chatList[i].chatWriter.profileImg}" alt="프로필이미지"/>
					        	<div class="chatList-header">
					        		       <strong class="mb-1">\${chatList[i].chatWriter.nickname}</strong>
							        <div class="last-chatting small">\${cont}</div>
					        	</div>
					        </div>
					      </a>	
						`;
				}
				
				else if(chatList[i].lastChat.type == 'FILE'){
					chatWrapper.innerHTML += `
					      <a data-chatroom-id="\${chatroomId}" data-craig-no="\${craigNo}" href="#" class="list-group-item list-group-item-action py-3 lh-sm" aria-current="true">
					        <div class="chatList-wrap" class="d-flex w-100 align-items-center justify-content-between">
					        	<div class="forTitle">
							        <span>\${craigTitle}</span>
					        	</div>		
					        	 <img src="${pageContext.request.contextPath}/resources/upload/profile/\${chatList[i].chatWriter.profileImg}" alt="프로필이미지"/>
					        	<div class="chatList-header">
					        		       <strong class="mb-1">\${chatList[i].chatWriter.nickname}</strong>
							        <div class="last-chatting small" style="color: #7FB77E;">(이미지파일)</div>
					        	</div>
					        </div>
					      </a>	
						`;
				}
				
				else if(chatList[i].lastChat.type == 'BOOK'){
					chatWrapper.innerHTML += `
					      <a data-chatroom-id="\${chatroomId}" data-craig-no="\${craigNo}" href="#" class="list-group-item list-group-item-action py-3 lh-sm" aria-current="true">
					        <div class="chatList-wrap" class="d-flex w-100 align-items-center justify-content-between">
					        	<div class="forTitle">
							        <span>\${craigTitle}</span>
					        	</div>		
					        	 <img src="${pageContext.request.contextPath}/resources/upload/profile/\${chatList[i].chatWriter.profileImg}" alt="프로필이미지"/>
					        	<div class="chatList-header">
					        		       <strong class="mb-1">\${chatList[i].chatWriter.nickname}</strong>
							        <div class="last-chatting small" style="color: #7FB77E;">(예약)</div>
					        	</div>
					        </div>
					      </a>	
						`;
				}
				
				else { // PLACE
					chatWrapper.innerHTML += `
					      <a data-chatroom-id="\${chatroomId}" data-craig-no="\${craigNo}" href="#" class="list-group-item list-group-item-action py-3 lh-sm" aria-current="true">
					        <div class="chatList-wrap" class="d-flex w-100 align-items-center justify-content-between">
					        	<div class="forTitle">
							        <span>\${craigTitle}</span>
					        	</div>		
					        	 <img src="${pageContext.request.contextPath}/resources/upload/profile/\${chatList[i].chatWriter.profileImg}" alt="프로필이미지"/>
					        	<div class="chatList-header">
					        		       <strong class="mb-1">\${chatList[i].chatWriter.nickname}</strong>
							        <div class="last-chatting small" style="color: #7FB77E;">(장소공유)</div>
					        	</div>
					        </div>
					      </a>	
						`;
				}
				
				
				
				
				document.querySelectorAll("a[data-chatroom-id]").forEach((a) => {
					console.log(a);
					a.addEventListener('click', (e) => {
						console.log(e.target);
						
						let parentA = e.target;
						while(parentA.tagName !== 'A')
							parentA = parentA.parentElement;
						
						const chatroomId = parentA.dataset.chatroomId;
						const craigNo = parentA.dataset.craigNo;
						const memberId = '${member.memberId}';
						console.log(chatroomId);	
						
						$("#chatLog").html(`
								<iframe src="${pageContext.request.contextPath}/chat/craigChat.do?chatroomId=\${chatroomId}&memberId=\${memberId}&craigNo=\${craigNo}" width="100%", height="100%"></iframe>
							`);
						//$("#chatLog").load(`${pageContext.request.contextPath}/chat/craigChat.do?chatroomId=\${chatroomId}&memberId=\${memberId}&craigNo=\${craigNo}`);
					});
				}); // data forEach
				
			} // for문
		}, // success
		error: console.log()		
	}); // ajax end
});


/* 같이해요 채팅 클릭 */
document.querySelector("#togetherBtn").addEventListener("click", (e) => {
	const chatWrapper = document.querySelector("#chatWrapper");
	chatWrapper.innerHTML = ''; // 초기화
	// 비동기로 조회
	$.ajax({
		url: `${pageContext.request.contextPath}/chat/findMyTogetherChat.do`,
		method : 'GET',
		data : {
		memberId : '${member.memberId}'
		},
		headers,
		dataType: "json",
		success(chatList){
		
			console.log(chatList);
			for(let i = 0; i < chatList.length; i++){
				console.log(chatList[i]);
			
				const togetherNo = chatList[i].togetherNo;
				const togetherTitle = chatList[i].togetherTitle;
				const chatCont = chatList[i].lastChat.content;
				let cont = chatCont.substr(0, 10) + ` …`;
				
				
				if(chatList[i].lastChat.type == 'CHAT'){
					chatWrapper.innerHTML += `
					      <a data-together-no="\${togetherNo}" href="#" class="list-group-item list-group-item-action py-3 lh-sm" aria-current="true">
					        <div class="chatList-wrap" class="d-flex w-100 align-items-center justify-content-between">
					        	<div class="forTitle">
							        <span>\${togetherTitle}</span>
					        	</div>		
					        	 <img src="${pageContext.request.contextPath}/resources/upload/profile/\${chatList[i].chatWriter.profileImg}" alt="프로필이미지"/>
					        	<div class="chatList-header">
					        		       <strong class="mb-1">\${chatList[i].chatWriter.nickname}</strong>
							        <div class="last-chatting small">\${cont}</div>
					        	</div>
					        </div>
					      </a>	
						`;
				}
				
				else if(chatList[i].lastChat.type == 'FILE'){
					chatWrapper.innerHTML += `
					      <a data-together-no="\${togetherNo}" href="#" class="list-group-item list-group-item-action py-3 lh-sm" aria-current="true">
					        <div class="chatList-wrap" class="d-flex w-100 align-items-center justify-content-between">
					        	<div class="forTitle">
							        <span>\${togetherTitle}</span>
					        	</div>		
					        	 <img src="${pageContext.request.contextPath}/resources/upload/profile/\${chatList[i].chatWriter.profileImg}" alt="프로필이미지"/>
					        	<div class="chatList-header">
					        		       <strong class="mb-1">\${chatList[i].chatWriter.nickname}</strong>
							        <div class="last-chatting small" style="color: #7FB77E;">(이미지파일)</div>
					        	</div>
					        </div>
					      </a>	
						`;
				}
				

				document.querySelectorAll("a[data-together-no]").forEach((a) => {
					console.log(a);
					a.addEventListener('click', (e) => {
						console.log(e.target);
						
						let parentA = e.target;
						while(parentA.tagName !== 'A')
							parentA = parentA.parentElement;
						
						const togetherNo = parentA.dataset.togetherNo;
						
						$("#chatLog").html(`
								<iframe src="${pageContext.request.contextPath}/chat/togetherChat.do?togetherNo=\${togetherNo}" width="100%", height="100%"></iframe>
							`);
					});
				}); // data forEach
				
			} // for문
		}, // success
		error: console.log()		
	}); // ajax end
});


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />