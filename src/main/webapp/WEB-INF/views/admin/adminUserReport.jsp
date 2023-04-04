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
	<jsp:param value="사용자신고관리" name="title" />
</jsp:include>

<script>
const totalPages = '${totalPages}';
const currentPage = '${currentPage}';

$(document).ready(function() {
	// 페이지네이션 생성
 	generatePagination(totalPages, currentPage);
});
</script>

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
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminTogetherList.do" style="text-decoration: none; color: black;"> 같이해요 관리 </a></li>
		</ul>
		<ul class="sidebar-nav">
			<h3>신고</h3>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminBoardReport.do" style="text-decoration: none; color: black;">
					게시글 신고 관리 </a></li>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="" style="text-decoration: none; color: #56C271;">
					사용자 신고 관리 </a></li>
		</ul>
	</div>
	<div id="admin-content">
		<h1 style="font-family: 'BMJUA', sanserif; margin-top: 30px; margin-bottom: 10px;">사용자 신고 관리</h1>
		<table>
			<thead>
				<tr>
					<th>No</th>
					<th>작성자</th>
					<th>신고 사유</th>
					<th>신고한 회원</th>
					<th>등록일</th>
					<th>처리 상태</th>
					<th>신고 처리</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty adminUserReport}">
					<c:forEach items="${adminUserReport}" var="adminUserReport" varStatus="vs">
						<tr id="table-content">
							<td>${vs.count}</td>
							<td>${adminUserReport.writer}</td>
							<td>${adminUserReport.reportReason.reasonName}</td>
							<td>${adminUserReport.reportedMember}</td>
							<td>
								<fmt:parseDate value="${adminUserReport.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="regDate" /> 
								<fmt:formatDate value='${regDate}' pattern="yyyy.MM.dd" />
							</td>
							<td>${adminUserReport.status}</td>
							<td>
								<input type="hidden" class="report" id="writer${vs.count}" value="${adminBoardReport.writer}"/>
								<input type="button" class="report" value="처리"  onclick="adminMemberDelete(writer${vs.count});" />
								<input type="hidden" class="report" id="writer${vs.count}" value="${adminBoardReport.writer}"/>
								<input type="button" class="report" value="반려"  onclick="adminMemberDelete(writer${vs.count});" />
							</td>							
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty adminUserReport}">
					<tr>
						<td colspan="6">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<nav aria-label="Page navigation example" class="pagebar-box">
 			<ul class="pagination justify-content-center"></ul>
		</nav>
	</div>

</section>
<script>
/* 페이지 처리 */
/* 페이지네이션 버튼을 생성하는 함수 */
const generatePagination = (totalPages, currentPage) => {
    let pagination = $(".pagination");
    pagination.empty(); // 이전에 생성된 페이지네이션 버튼 초기화
    
    let beforeUrl;
	 // 이전 버튼 추가
    if (currentPage != 1) {
    	beforeUrl = '${pageContext.request.contextPath}/admin/adminUserReport.do?currentPage=' + (currentPage - 1);
    	pagination.append("<li class='page-item'><a class='page-link' href='" + beforeUrl + "' tabindex='-1'>이전</a></li>");
    } else {
      pagination.append("<li class='page-item disabled'><a class='page-link' tabindex='-1'>이전</a></li>");
    }

    // 페이지 버튼 추가
    let pageUrl
    for (let i = 1; i <= totalPages; i++) {
        if (i == currentPage) {
            pagination.append("<li class='page-item active'><a class='page-link'>" + i + "</a></li>");
        } else {
        	pageUrl = '${pageContext.request.contextPath}/admin/adminUserReport.do?currentPage=' + i;
        	pagination.append("<li class='page-item'><a class='page-link' href='" + pageUrl + "'>" + i + "</a></li>");
        }
    }

    // 다음 버튼 추가
    let nextUrl;
    if (currentPage != totalPages) {
    	nextUrl = '${pageContext.request.contextPath}/admin/adminUserReport.do?currentPage=' + totalPages;    	
        pagination.append("<li class='page-item'><a class='page-link' href='" + nextUrl +"'>다음</a></li>");
    } else {
        pagination.append("<li class='page-item disabled'><a class='page-link'>다음</a></li>");
    }
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />