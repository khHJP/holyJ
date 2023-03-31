<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<jsp:param value="회원관리" name="title" />
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
			<a class="sidebar-nav-a" href="" style="text-decoration: none; color: #56C271;"> 회원 관리 </a></li>
		</ul>
		<ul class="sidebar-nav">
			<h3>게시글</h3>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminCraigList.do" style="text-decoration: none; color: black;"> 중고거래 관리 </a></li>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminLocalList.do" style="text-decoration: none; color: black;"> 동네생활 관리 </a></li>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminTogetherList.do" style="text-decoration: none; color: black;"> 같이해요 관리 </a></li>
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
		<h1 style="font-family: 'BMJUA', sanserif; margin-top: 30px; margin-bottom: 10px;">회원 관리</h1>
		<table>
			<thead>
				<tr>
					<th>No</th>
					<th>아이디</th>
					<th>권한</th>
					<th>닉네임</th>
					<th>휴대폰</th>
					<th>매너온도</th>
					<th>신고 횟수</th>
					<th>가입일</th>
					<th><button>삭제</button></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty adminMemberList}">
					<c:forEach items="${adminMemberList}" var="adminMember" varStatus="vs">
						<tr id="table-content">
							<td>${vs.count}</td>
							<td>${adminMember.memberId}</td>
							<td>
								<select class="member-role" data-member-id="${adminMember.memberId}">
									<option value="ROLE_USER" <c:if test="${adminMember.auth.auth eq 'ROLE_USER'}"> selected="selected"</c:if>> ROLE_USER</option>
									<option value="ROLE_ADMIN" <c:if test="${adminMember.auth.auth eq 'ROLE_ADMIN'}"> selected="selected"</c:if>>ROLE_ADMIN</option>
									<option value="ROLE_WARN" <c:if test="${adminMember.auth.auth eq 'ROLE_WARN'}"> selected="selected"</c:if>>ROLE_WARN</option>
								</select>
							</td>
							<td>${adminMember.nickname}</td>
							<td>
								<fmt:formatNumber var="phone" value="${adminMember.phone}" pattern="000,0000,0000"/>
								<c:out value="${fn:replace(phone, ',', '-')}" />
							</td>
							<c:if test="${adminMember.manner lt 30}">
								<td style="color:#3AB0FF">${adminMember.manner}</td>
							</c:if>
							<c:if test="${adminMember.manner ge 35 && adminMember.manner lt 50}">
								<td style="color:#56C271">${adminMember.manner}</td>
							</c:if>
							<c:if test="${adminMember.manner ge 50}">
								<td style="color:red">${adminMember.manner}</td>
							</c:if>
							<td>${adminMember.reportCnt}</td>
							<td>
								<fmt:parseDate value="${adminMember.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="enrollDate" /> 
								<fmt:formatDate value='${enrollDate}' pattern="yyyy.MM.dd" />
							</td>
							<form:form class="delete" action="${pageContext.request.contextPath}/admin/adminMemberDelete.do" name="adminMemberDeleteFrm" method="POST">
							<td>
								<button type="button" name ="memberId" value="${adminMember.memberId}">삭제</button>
							</td>
							</form:form>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty adminMemberList}">
					<tr>
						<td colspan="11">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

</section>
<!-- 회원 권한 수정 폼 -->
<form:form name="adminMemberRoleUpdateFrm" action="${pageContext.request.contextPath}/admin/adminMemberRoleUpdate.do" method="post">
	<input type="hidden" name="memberId">
	<input type="hidden" name="auth">
</form:form>
<script>
/* 회원 권한 수정 */
document.querySelectorAll(".member-role").forEach((select) => {
	select.addEventListener('change', (e) => {
		console.log(e.target.value);
		console.log(e.target.dataset.memberId);
		const memberId = e.target.dataset.memberId;
		const auth = e.target.value;
		const frm = document.adminMemberRoleUpdateFrm;
		
		if(confirm(`[\${memberId}]회원의 권한을 \${auth}로 변경하시겠습니까?`)){			
			console.log(frm);
			frm.memberId.value = e.target.dataset.memberId;
			frm.auth.value = auth;
			frm.submit();
		}
		else {
			e.target.querySelector("option[selected]").selected = true;
		}
		
	});
});

/* 회원 삭제 */
document.querySelector(".delete").addEventListener('click', (e) => {
	if(confirm('해당 회원을 삭제하시겠습니까?')){
		document.adminMemberDeleteFrm.submit();
	}
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />