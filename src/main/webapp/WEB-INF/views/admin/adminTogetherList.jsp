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
	<jsp:param value="같이해요관리" name="title" />
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
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminNoticeList.do" style="text-decoration: none; color: black;"> 전체 공지 관리 </a>
			</li>
		</ul>
		<ul class="sidebar-nav">
			<h3>회원</h3>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminMemberList.do" style="text-decoration: none; color: black;"> 회원 관리 </a></li>
		</ul>
		<ul class="sidebar-nav">
			<h3>게시글</h3>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminCraigList.do" style="text-decoration: none; color: black;"> 중고거래 관리 </a></li>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminLocalList.do" style="text-decoration: none; color: black;"> 동네생활 관리 </a></li>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="" style="text-decoration: none; color: #56C271;"> 같이해요 관리 </a></li>
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
		<h1 style="font-family: 'BMJUA', sanserif; margin-top: 30px; margin-bottom: 10px;">같이해요 관리</h1>
		<table>
			<thead>
				<tr>
					<th>No</th>
					<th>카테고리</th>
					<th>작성자</th>
					<th>제목</th>
					<th>상태</th>
					<th>등록일</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty adminTogetherList}">
					<c:forEach items="${adminTogetherList}" var="adminTogether" varStatus="vs">
						<tr id="table-content">
							<td>${vs.count}</td>
							<td>${adminTogether.categoryNo}</td>
							<td>${adminTogether.writer}</td>
							<td>${adminTogether.title}</td>
							<td>${adminTogether.status}</td>
							<td>
								<fmt:parseDate value="${adminTogether.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="regDate" /> 
								<fmt:formatDate value='${regDate}' pattern="yyyy.MM.dd HH:mm" />
							</td>
							<td></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty adminTogetherList}">
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