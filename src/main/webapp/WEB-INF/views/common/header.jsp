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
<meta charset="UTF-8">
<title>오이마켓</title>
<!-- jq추가 - 혜진 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- bootstrap js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
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
</head>
<body>
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
						<a href="#" class="title nav-link">같이해요</a>
					</li>
				</ul>
			</div>
			<!-- 로그인전 -->
			<c:if test="${empty loginMember}">
 			<div class="login-box">
				<%-- <button class="btn" onclick="location.href='${pageContext.request.contextPath}/member/memberLogin.do'">로그인</button> --%>
				<button type="button" class="btn" data-toggle="modal" data-target="#loginModal">
 		 			로그인
				</button>
				<button class="btn" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do'">회원가입</button>
			</div>
			</c:if>
			<!-- 로그인후 -->
			<c:if test="${not empty loginMember}">
			<div class="login-box">
				<div class="notice-wrap">
					<img src="${pageContext.request.contextPath}/resources/images/bookmark.png" alt="키워드알림">
					<img src="${pageContext.request.contextPath}/resources/images/notification.png" alt="알림">
				</div>
				 
				<div class="profile-wrap">
					<img src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지">
					<div class="my-select-box">
						<span class="my-select"><a href="${pageContext.request.contextPath}/member/myPage.do" class="subtitle nav-link">나의 오이</a></span>
						<span class="my-select"><a href="${pageContext.request.contextPath}/admin/adminList.do" class="subtitle nav-link">관리자페이지</a></span>
						<span class="my-select"><a href="${pageContext.request.contextPath}/member/memberLogout.do" class="subtitle nav-link">로그아웃</a></span>
					</div>	
				</div>
			</div><!-- end login-box -->
			</c:if>
		</div>
	</header>
	<!-- Modal시작 -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="login-header">
					<div class="img-box">
						<img src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png">
					</div>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<!--로그인폼 -->
				<form:form
					action="${pageContext.request.contextPath}/member/memberLogin.do"
					method="post">
					<div class="modal-body">
						<c:if test="${param.error != null}">
							<div class="alert alert-danger alert-dismissible fade show" role="alert">
								<span class="text-danger">아이디 또는 비밀번호가 일치하지 않습니다.</span>
								<button type="button" class="close" data-dismiss="alert" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
				            </div>
						</c:if>
						<input 
							type="text" class="je-input" name="memberId"
							placeholder="아이디" required> 
						<br /> 
						<input
							type="password" class="je-input" name="password"
							placeholder="비밀번호" required>
						<div class="login-check">
							<input type="checkbox" class="form-check-input" name="remember-me" id="remember-me"/>
							<label for="remember-me" class="form-check-label">자동로그인</label>
						</div>
					</div>
					<div class="login-footer">
						<div>
							<button type="submit" class="btn">로그인</button>
							<button type="button" class="btn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<!-- Modal 끝-->
	<section id="content">
<c:if test="${not empty loginMember}">
<script>
/* 프로필 토글 */
document.querySelector(".profile-wrap").addEventListener('click', (e) => {
	const selectBox = document.querySelector(".my-select-box");
	selectBox.classList.toggle('show-toggle');
});
</script>
</c:if>