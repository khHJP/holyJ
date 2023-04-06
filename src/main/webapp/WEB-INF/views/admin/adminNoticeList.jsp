<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
<!-- 글꼴 Noto Sans Korean-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자공지" name="title" />
</jsp:include>

<section id="admin-container">
	<div id="sidebar">
		<ul class="sidebar-nav">
			<li class="sidebar-nav-list"><a
				href="${pageContext.request.contextPath}"> <img
					src="${pageContext.request.contextPath}/resources/images/oee.png"
					style="height: 150px;">
			</a></li>
		</ul>
		<ul class="sidebar-nav">
			<h3>공지</h3>
			<li class="sidebar-nav-list"><a class="sidebar-nav-a"
				href="${pageContext.request.contextPath}/admin/adminNoticeList.do"
				style="text-decoration: none; color: #56C271;"> 전체 공지 관리 </a></li>
		</ul>
		<ul class="sidebar-nav">
			<h3>회원</h3>
			<li class="sidebar-nav-list"><a class="sidebar-nav-a"
				href="${pageContext.request.contextPath}/admin/adminMemberList.do"
				style="text-decoration: none; color: black;"> 회원 관리 </a></li>
		</ul>
		<ul class="sidebar-nav">
			<h3>게시글</h3>
			<li class="sidebar-nav-list"><a class="sidebar-nav-a"
				href="${pageContext.request.contextPath}/admin/adminCraigList.do"
				style="text-decoration: none; color: black;"> 중고거래 관리 </a></li>
			<li class="sidebar-nav-list"><a class="sidebar-nav-a"
				href="${pageContext.request.contextPath}/admin/adminLocalList.do"
				style="text-decoration: none; color: black;"> 동네생활 관리 </a></li>
			<li class="sidebar-nav-list"><a class="sidebar-nav-a"
				href="${pageContext.request.contextPath}/admin/adminTogetherList.do"
				style="text-decoration: none; color: black;"> 같이해요 관리 </a></li>
		</ul>
		<ul class="sidebar-nav">
			<h3>신고</h3>
			<li class="sidebar-nav-list"><a class="sidebar-nav-a"
				href="${pageContext.request.contextPath}/admin/adminBoardReport.do"
				style="text-decoration: none; color: black;"> 게시글 신고 관리 </a></li>
			<li class="sidebar-nav-list"><a class="sidebar-nav-a"
				href="${pageContext.request.contextPath}/admin/adminUserReport.do"
				style="text-decoration: none; color: black;"> 사용자 신고 관리 </a></li>
		</ul>
	</div>
	
	<div id="admin-content">
	<h1 style="font-family: 'BMJUA', sanserif; margin-top: 30px; margin-bottom: 10px;">전체 공지 관리</h1>	
	<form name="adminNoticeInsertFrm" action="${pageContext.request.contextPath}/admin/adminNoticeInsert.do" method="post">
		<div class="notice-wrap">
			<input type="text" id="noticeText" name="content"></input>
			<button type="submit" id="enrollBtn">공지 작성</button>
		</div>
	</form>
	
	</div>

</section>
<!-- stomp, sockjs -->
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
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />