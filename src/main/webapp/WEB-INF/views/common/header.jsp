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
<!-- css 모음 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<!-- 글꼴 'Noto Sans Korean' -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<script>
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
</head>
<body>
<div id="container">
	<header>
		<div class="header-container">
			<a class="logo-box" href="${pageContext.request.contextPath}/">
				<img src="${pageContext.request.contextPath}/resources/images/OEE-LOGO.png" alt="오이마켓로고">
			</a>
			<div class="nav-container">
				<ul class="nav-list">
					<li>
						<a href="${pageContext.request.contextPath}/craig/craigList.do" class="title">중고거래</a>
					</li>
					<li>
						<a href="#" class="title">동네생활</a>
					</li>
					<li>
						<a href="#" class="title">같이해요</a>
					</li>
				</ul>
			</div>
			<!-- 로그인전 -->
			<!--  
 			<div class="non-login">
				<button class="btn">로그인</button>
				<button class="btn">회원가입</button>
			</div>
			-->
			<!-- 로그인후 -->

			<div class="login-box">
				<div class="notice-wrap">
					<img src="${pageContext.request.contextPath}/resources/images/bookmark.png" alt="키워드알림">
					<img src="${pageContext.request.contextPath}/resources/images/notification.png" alt="알림">
				</div>
				 
				<div class="profile-wrap">
					<img src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지">
					<div class="my-select-box">
						<span class="my-select"><a href="${pageContext.request.contextPath}/mypage/mypage.do" class="subtitle">나의 오이</a></span>
						<span class="my-select"><a href="#">관리자페이지</a></span>
						<span class="my-select"><a href="#">로그아웃</a></span>
					</div>	
				</div>
			</div><!-- end login-box -->

		</div><!-- end header-wrap -->
	</header>
	<section id="content">
<script>
/* 로그인시 실행 */
document.querySelector(".profile-wrap").addEventListener('click', (e) => {
	const selectBox = document.querySelector(".my-select-box");
	selectBox.classList.toggle('show-toggle');
});
</script>