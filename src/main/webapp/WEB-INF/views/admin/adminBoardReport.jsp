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
	<jsp:param value="게시글신고관리" name="title" />
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
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/notice/adminNoticeList.do" style="text-decoration: none; color: black;"> 전체 공지 관리 </a>
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
			<a class="sidebar-nav-a" href="" style="text-decoration: none; color: #56C271;">
					게시글 신고 관리 </a></li>
			<li class="sidebar-nav-list">
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminUserReport.do" style="text-decoration: none; color: black;">
					사용자 신고 관리 </a></li>
		</ul>
	</div>
	<div id="admin-content">
		<h1 style="font-family: 'BMJUA', sanserif; margin-top: 30px; margin-bottom: 10px;">게시글 신고 관리</h1>
		<table>
			<thead>
				<tr>
					<th>No</th>
					<th>신고자</th>
					<th>카테고리</th>
					<th>게시글</th>
					<th>신고 사유</th>
					<th>등록일</th>
					<th>상태</th>
					<th>신고 처리</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty adminBoardReport}">
					<c:forEach items="${adminBoardReport}" var="adminBoardReport" varStatus="vs">
						<tr id="table-content">
							<td>${totalCount - (currentPage - 1) * limit - vs.index}</td>
							<td>${adminBoardReport.writer}</td>
							<c:if test="${adminBoardReport.reportType == 'CR'}">
								<td cla>중고거래</td>
							</c:if>
							<c:if test="${adminBoardReport.reportType == 'LO'}">
								<td>동네생활</td>
							</c:if>
							<c:if test="${adminBoardReport.reportType == 'TO'}">
								<td>같이해요</td>
							</c:if>
							<td id="count" class="report-view" data-no="${adminBoardReport.reportPostNo}" data-type="${adminBoardReport.reportType}">
								${adminBoardReport.reportPostNo}
							</td>
							<td>${adminBoardReport.reportReason.reasonName}</td>
							<td>
								<fmt:parseDate value="${adminBoardReport.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="regDate" /> 
								<fmt:formatDate value='${regDate}' pattern="yyyy.MM.dd" />
							</td>
							<td>${adminBoardReport.status}</td>
							<td data-no="${adminBoardReport.reportPostNo}" data-type="${adminBoardReport.reportType}">
								<input type="hidden" class="report" id="writer${vs.count}" value="${adminBoardReport.reportNo}"/>
								<input type="button" class="report" value="처리"  onclick="adminReportHandle(writer${vs.count}); this.onclick=null;" />
								<input type="button" class="report" value="취소"  onclick="adminReportCancle(writer${vs.count}); this.onclick=null;" />
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty adminBoardReport}">
					<tr>
						<td colspan="8">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<nav aria-label="Page navigation example" class="pagebar-box">
 			<ul class="pagination justify-content-center"></ul>
		</nav>
	</div>

</section>
<!-- 게시글 신고 처리 폼 -->
<form:form name="adminCraigBoardReportHandleFrm" action="${pageContext.request.contextPath}/admin/adminCraigBoardReportHandle.do" method="post">
	<input type="hidden" name="reportNo">
	<input type="hidden" name="reportPostNo">
</form:form>
<form:form name="adminLocalBoardReportHandleFrm" action="${pageContext.request.contextPath}/admin/adminLocalBoardReportHandle.do" method="post">
	<input type="hidden" name="reportNo">
	<input type="hidden" name="reportPostNo">
</form:form>
<form:form name="adminTogetherBoardReportHandleFrm" action="${pageContext.request.contextPath}/admin/adminTogetherBoardReportHandle.do" method="post">
	<input type="hidden" name="reportNo">
	<input type="hidden" name="reportPostNo">
</form:form>
<!-- 게시글 신고 취소 폼 -->
<form:form name="adminBoardReportCancleFrm" action="${pageContext.request.contextPath}/admin/adminBoardReportCancle.do" method="post">
	<input type="hidden" name="reportNo">
</form:form>
<script>
/* 신고 게시글 상세페이지 이동 */
document.querySelectorAll(".report-view").forEach( (td)=>{
	td.addEventListener('click', (e) => {		
		const no = td.dataset.no;
		const type = td.dataset.type;
		console.log(no, type);
		
		switch(type) {
		case 'CR':
			location.href = "${pageContext.request.contextPath}/craig/craigDetail.do?no="+no;
			break;
		case 'LO':
			location.href='${pageContext.request.contextPath}/local/localDetail.do?no=' + no;
			break;
		case 'TO':
			location.href = '${pageContext.request.contextPath}/together/togetherDetail.do?&no=' + no;
			break;			
		}
	});
});

/* 게시글 신고 처리 */
function adminReportHandle(e) {
	const reportNo = e.value;
	const reportPostNo = e.parentNode.dataset.no;
	const reportType = e.parentNode.dataset.type;
	console.log(reportNo, reportPostNo, reportType);	
	
	const craigfrm = document.adminCraigBoardReportHandleFrm;
	const localfrm = document.adminLocalBoardReportHandleFrm;
	const togetherfrm = document.adminTogetherBoardReportHandleFrm;
	console.log(craigfrm);
	console.log(localfrm);
	console.log(togetherfrm);
	
	if(reportType == 'CR') {
		if(confirm('이 신고건을 처리하시겠습니까?')) {
			craigfrm.reportNo.value = reportNo;
			craigfrm.reportPostNo.value = reportPostNo;
			craigfrm.submit();
		}
	}
	
	if(reportType == 'LO') {
		if(confirm('이 신고건을 처리하시겠습니까?')) {
			localfrm.reportNo.value = reportNo;
			localfrm.reportPostNo.value = reportPostNo;
			localfrm.submit();
		}
	}
	
	if(reportType == 'TO') {
		if(confirm('이 신고건을 처리하시겠습니까?')) {
			togetherfrm.reportNo.value = reportNo;
			togetherfrm.reportPostNo.value = reportPostNo;
			togetherfrm.submit();
		}
	}
	
	this.onclick = null;
};

/* 게시글 신고 취소 */
function adminReportCancle(e) {
	const reportNo = e.value;
	console.log(reportNo);	
	const frm = document.adminBoardReportCancleFrm;
	console.log(frm);
	
	if(confirm('이 신고건을 취소하시겠습니까?')) {
		frm.reportNo.value = reportNo;
		frm.submit();
	}
	
	this.onclick = null;
};

/* 페이지 처리 */
/* 페이지네이션 버튼을 생성하는 함수 */
const generatePagination = (totalPages, currentPage) => {
    let pagination = $(".pagination");
    pagination.empty(); // 이전에 생성된 페이지네이션 버튼 초기화
    
    let beforeUrl;
	 // 이전 버튼 추가
    if (currentPage != 1) {
    	beforeUrl = '${pageContext.request.contextPath}/admin/adminBoardReport.do?currentPage=' + (currentPage - 1);
    	pagination.append("<li class='page-item'><a class='page-link' style='color: black;' href='" + beforeUrl + "' tabindex='-1'>이전</a></li>");
    } else {
      pagination.append("<li class='page-item disabled'><a class='page-link' style='color: black;' 'tabindex='-1'>이전</a></li>");
    }

    // 페이지 버튼 추가
    let pageUrl
    for (let i = 1; i <= totalPages; i++) {
        if (i == currentPage) {
            pagination.append("<li class='page-item active'><a class='page-link' style='background-color: #56C271; border: 1px solid #56C271;'>" + i + "</a></li>");
        } else {
        	pageUrl = '${pageContext.request.contextPath}/admin/adminBoardReport.do?currentPage=' + i;
        	pagination.append("<li class='page-item'><a class='page-link' style='color: #56C271;' href='" + pageUrl + "'>" + i + "</a></li>");
        }
    }

    // 다음 버튼 추가
    let nextUrl;
    if (currentPage != totalPages) {
    	nextUrl = '${pageContext.request.contextPath}/admin/adminBoardReport.do?currentPage=' + totalPages;    	
        pagination.append("<li class='page-item'><a class='page-link' style='color: black;' href='" + nextUrl +"'>다음</a></li>");
    } else {
        pagination.append("<li class='page-item disabled'><a class='page-link' style='color: black;'>다음</a></li>");
    }
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />