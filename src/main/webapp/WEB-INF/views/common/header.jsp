<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="csrf-token" content="{{#_csrf}}token{{/_csrf}}">
<!-- <meta charset="UTF-8"> -->
<title>오이마켓</title>
<!-- jq추가 - 혜진 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/58cf6ad0e8.js" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<!-- bootstrap locon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<!-- css 모음 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<!-- 글꼴 'Noto Sans Korean' -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<script>
/* 현재 타이틀에 색 입히기 */
window.addEventListener('load', (e) => {
	const titleList = document.querySelectorAll(".title");
	const currentTitle = '${param.title}';
	titleList.forEach((title) => {
		if(title.innerText === currentTitle){
			title.style.color = "RGB(86, 194, 112)";
		}
	})
});
</script>
<c:if test="${not empty msg}">
	<script>
	alert('${msg}');
	</script>
</c:if>
<!-- 🐹 효정 03/24 로그인시 websocket연결 start 🐹 -->
<sec:authorize access="isAuthenticated()">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
	const ws = new SockJS(`http://\${location.host}${pageContext.request.contextPath}/stomp`);
	const stompClient = Stomp.over(ws);
	stompClient.connect({}, (frame) => {
		console.log("연결 성공!", frame); 
	});
	</script>
</sec:authorize>
<!-- 🐹 효정 03/24 로그인시 websocket연결 end 🐹 -->
</head>
<body>
<div class="modal fade" id="alert-modal" tabindex="-1" role="dialog" aria-labelledby="alertModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<div class="modal-body"></div>
		</div>
	</div>
</div>
<div id="container">
	<header>
		<div id="header-container">
			<a class="logo-box" href="${pageContext.request.contextPath}/">
				<img src="${pageContext.request.contextPath}/resources/images/OEE-LOGO.png" alt="오이마켓로고">
			</a>
			<div id="nav-container">
				<ul id="nav-list">
					<li id="list">
						<a href="${pageContext.request.contextPath}/craig/craigList.do" class="title nav-link" >중고거래</a>
					</li>
					<li id="list">
						<a href="${pageContext.request.contextPath}/local/localList.do" class="title nav-link">동네생활</a>
					</li>
					<li id="list">
						<a href="${pageContext.request.contextPath}/together/togetherList.do" class="title nav-link">같이해요</a>
					</li>
				</ul>
			</div>

			<!-- 로그인 전 접근 가능 -->		
			<sec:authorize access="isAnonymous()">
 			<div class="login-box">
				<button type="button" class="btn" data-toggle="modal" data-target="#loginModal" onclick="location.href='${pageContext.request.contextPath}/member/memberLogin.do'">
 		 			로그인
				</button>
				<button class="btn" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do'">회원가입</button>
			</div>
			</sec:authorize>
			
			<!-- 로그인 후 접근 가능 -->
			<sec:authorize access="isAuthenticated()">
			<div class="login-box">
				<div class="notice-wrap">
					<i class="bi bi-bookmark"></i>
					<i class="bi bi-bell"></i>
				</div>
				<div class="profile-wrap">
					<sec:authentication property="principal" var="loginMember"/>					
					<img src="${pageContext.request.contextPath}/resources/upload/profile/${loginMember.profileImg}" alt="임시이미지">
					<div class="my-select-box">
						<span class="my-select"><button onclick="location='${pageContext.request.contextPath}/member/myPage.do';" class="subtitle">나의 오이</button></span>
						
						<!-- 관리자만 접근 가능  -->
						<sec:authorize access="hasRole('ROLE_ADMIN')">
						<span class="my-select"><button onclick="location='${pageContext.request.contextPath}/admin/adminMemberList.do';" class="subtitle">관리자페이지</button></span>
						</sec:authorize>
						
						<form:form class="my-select" action="${pageContext.request.contextPath}/member/memberLogout.do" method="post">
							<button class="subtitle" type="submit" style="z-index: 111">
								로그아웃
							</button>
						</form:form>
					</div>	
				</div>
			</div><!-- end login-box --> 
			</sec:authorize>
		</div>
	</header>
	<%-- <section id="content"> --%>
<sec:authorize access="isAuthenticated()">
<script>
document.querySelector(".profile-wrap").addEventListener('click', (e) => {
	const selectBox = document.querySelector(".my-select-box");
	selectBox.classList.toggle('show-toggle');
});
</script>
</sec:authorize>