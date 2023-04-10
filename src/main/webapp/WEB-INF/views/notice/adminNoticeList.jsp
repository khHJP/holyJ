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
			<li class="sidebar-nav-list"><a
				href="${pageContext.request.contextPath}"> <img
					src="${pageContext.request.contextPath}/resources/images/oee.png"
					style="height: 150px;">
			</a></li>
		</ul>
		<ul class="sidebar-nav">
			<h3>공지</h3>
			<li class="sidebar-nav-list"><a class="sidebar-nav-a"
				href="${pageContext.request.contextPath}/notice/adminNoticeList.do"
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
		<form name="adminNoticeFrm">
			<input type="text" id="message-text" placeholder="&nbsp; [공지] 공지 내용을 작성해 주세요...">
			<button type="submit" id="sendBtn">전송</button>
		</form>
		<h1
			style="font-family: 'BMJUA', sanserif; margin-top: 30px; margin-bottom: 10px;">전체
			공지 관리</h1>
		<table>
			<thead>
				<tr>
					<th>No</th>
					<th>내용</th>
					<th>등록일</th>
					<th>공지 삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${adminNoticeList}" var="adminNotice"
					varStatus="vs">
					<tr id="table-content">
						<td style="width: 50px;">${vs.count}</td>
						<td style="width: 500px;">${adminNotice.msg}</td>
						<td style="width: 300px;">
							<fmt:parseDate value="${adminNotice.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="regDate" /> 
							<fmt:formatDate value='${regDate}' pattern="yyyy.MM.dd HH:mm" />
						</td>
						<td style="width: 100px;">
							<input type="hidden" class="notice delete" id="noticeNo${vs.count}" value="${adminNotice.no}"/>
							<input type="button" class="notice delete" value="삭제"  onclick="adminNoticeDelete(noticeNo${vs.count});" />
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<nav aria-label="Page navigation example" class="pagebar-box">
			<ul class="pagination justify-content-center"></ul>
		</nav>

	</div>

</section>
<!-- 공지 삭제 폼 -->
<form:form name="adminNoticeDeleteFrm" action="${pageContext.request.contextPath}/notice/adminNoticeDelete.do" method="post">
	<input type="hidden" name="no">
</form:form>
<script>
/* 실시간 공지 발송 */
document.querySelector("#sendBtn").addEventListener('click', (e) => {		
	const messageText = document.querySelector("#message-text");
	const msg = messageText.value;
	
	console.log(msg);
	
	if(!msg) return;
	
	const payload = {
		msg,
		regDate : Date.now(),
	};
	
	stompClient.send("/app/admin/notice", {}, JSON.stringify(payload));
	document.adminNoticeFrm.reset();
});
	
/* 공지 삭제 */
function adminNoticeDelete(e) {
	const no = e.value;
	console.log(no);	
	const frm = document.adminNoticeDeleteFrm;
	console.log(frm);
	
	if(confirm('정말 이 공지를 삭제하시겠습니까?')) {
		frm.no.value = no;
		frm.submit();
	}
};

/* 페이지 처리 */
/* 페이지네이션 버튼을 생성하는 함수 */
const generatePagination = (totalPages, currentPage) => {
    let pagination = $(".pagination");
    pagination.empty(); // 이전에 생성된 페이지네이션 버튼 초기화
    
    let beforeUrl;
	 // 이전 버튼 추가
    if (currentPage != 1) {
    	beforeUrl = '${pageContext.request.contextPath}/notice/adminNoticeList.do?currentPage=' + (currentPage - 1);
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
        	pageUrl = '${pageContext.request.contextPath}/notice/adminNoticeList.do?currentPage=' + i;
        	pagination.append("<li class='page-item'><a class='page-link' style='color: #56C271;' href='" + pageUrl + "'>" + i + "</a></li>");
        }
    }

    // 다음 버튼 추가
    let nextUrl;
    if (currentPage != totalPages) {
    	nextUrl = '${pageContext.request.contextPath}/notice/adminNoticeList.do?currentPage=' + totalPages;    	
        pagination.append("<li class='page-item'><a class='page-link' style='color: black;' href='" + nextUrl +"'>다음</a></li>");
    } else {
        pagination.append("<li class='page-item disabled'><a class='page-link' style='color: black;'>다음</a></li>");
    }
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />