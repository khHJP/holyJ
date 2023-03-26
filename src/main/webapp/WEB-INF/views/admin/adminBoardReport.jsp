<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
<!-- 글꼴 Noto Sans Korean-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글신고관리" name="title" />
</jsp:include>

<section id="admin-container">
	<div id="sidebar">
		<ul class="sidebar-nav">
			<li class="sidebar-nav-list">
			<a href="${pageContext.request.contextPath}"> 
			<img src="${pageContext.request.contextPath}/resources/images/oee.png" style="height: 150px;">
			</a></li>
		</ul>
		<ul class="sidebar-nav">
			<h3>공지</h3>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" "href="#" style="text-decoration: none; color: black;"> 전체 공지 관리 </a>
			</li>
		</ul>
		<ul class="sidebar-nav">
			<h3>회원</h3>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminMemberList.do" style="text-decoration: none; color: black;"> 회원 관리 </a></li>
		</ul>
		<ul class="sidebar-nav">
			<h3>신고</h3>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminBoardReport.do" style="text-decoration: none; color: black;">
					게시글 신고 관리 </a></li>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminUserReport.do" style="text-decoration: none; color: black;">
					사용자 신고 관리 </a></li>
		</ul>
	</div>
	<div id="admin-content">
		<input type="search" id="search" placeholder="&nbsp;&nbsp;&nbsp;Search...">
		<h1 style="font-family: 'BMJUA', sanserif; margin-top: 30px; margin-bottom: 10px;">게시글 신고 관리</h1>
		<table>
			<thead>
				<tr>
					<th>No</th>
					<th>WRITER</th>
					<th>TYPE</th>
					<th>POST</th>
					<th>REASON</th>
					<th>REG DATE</th>
					<th>STATUS</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty adminBoardReport}">
					<c:forEach items="${adminBoardReport}" var="adminBoardReport">
						<tr class="table-content">
							<td>${adminBoardReport.reportNo}</td>
							<td>${adminBoardReport.writer}</td>
							<td>${adminBoardReport.reportType}</td>
							<td>${adminBoardReport.reportPostNo}</td>
							<td>${adminBoardReport.reasonNo}</td>
							<td>${adminBoardReport.regDate}</td>
							<td>${adminBoardReport.status}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty adminBoardReport}">
					<tr>
						<td colspan="7">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

</section>
<script></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />