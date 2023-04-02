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
	<jsp:param value="동네생활관리" name="title" />
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
			<a class="sidebar-nav-a" href="" style="text-decoration: none; color: #56C271;"> 동네생활 관리 </a></li>
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
		<h1 style="font-family: 'BMJUA', sanserif; margin-top: 30px; margin-bottom: 10px;">동네생활 관리</h1>
		<table>
			<thead>
				<tr>
					<th>No</th>
					<th>카테고리</th>
					<th>작성자</th>
					<th>제목</th>
					<th>등록일</th>
					<th>동네생활 삭제</th>
				</tr>
			</thead>
			<c:set var="category" value="${localCategory}" scope="page"/>
			<tbody>
				<c:if test="${not empty adminLocalList}">
					<c:forEach items="${adminLocalList}" var="adminLocal" varStatus="vs">
						<tr id="table-content">
							<td class="local-view" data-lono="${adminLocal.no}">${vs.count}</td>
							<td>
								<select class="local-category" data-no="${adminLocal.no}">
									<option value=1 <c:if test="${adminLocal.categoryNo eq 1}"> selected="selected"</c:if>>동네질문</option>
									<option value=2 <c:if test="${adminLocal.categoryNo eq 2}"> selected="selected"</c:if>>동네소식</option>
									<option value=3 <c:if test="${adminLocal.categoryNo eq 3}"> selected="selected"</c:if>>분실/실종센터</option>
									<option value=4 <c:if test="${adminLocal.categoryNo eq 4}"> selected="selected"</c:if>>해주세요</option>
								</select>
							</td>
							<td>${adminLocal.writer}</td>
							<td>${adminLocal.title}</td>
							<td>
								<fmt:parseDate value="${adminLocal.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="regDate" /> 
								<fmt:formatDate value='${regDate}' pattern="yyyy.MM.dd" />
							</td>
							<td>
								<input type="hidden" class="local delete" id="local${vs.count}" value="${adminLocal.no}"/>
								<input type="button" class="local delete" value="삭제"  onclick="adminLocalDelete(local${vs.count});" />
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty adminLocalList}">
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
<!-- 동네생활 카테고리 수정 폼 -->
<form:form name="adminLocalCategoryUpdateFrm" action="${pageContext.request.contextPath}/admin/adminLocalCategoryUpdate.do" method="post">
	<input type="hidden" value="${adminLocal.no}" name="no">
	<input type="hidden" value="${adminLocal.categoryNo}" name="categoryNo">
</form:form>
<!-- 동네생활 카테고리 삭제 폼 -->
<form:form name="adminLocalDeleteFrm" action="${pageContext.request.contextPath}/admin/adminLocalDelete.do" method="post">
	<input type="hidden" name="no">
</form:form>
<script>
/* 동네생활 상세 페이지 이동 */
document.querySelectorAll(".local-view").forEach( (td) => {
	td.addEventListener('click', (e) => {
		console.log(e.target);
		console.log(td);
		
		const no = td.dataset.lono;
		console.log(no);
		location.href='${pageContext.request.contextPath}/local/localDetail.do?&no=' + no;
	});
});

/* 카테고리 수정 */
document.querySelectorAll(".local-category").forEach((select) => {
	select.addEventListener('change', (e) => {
		console.log(e.target.value);
		console.log(e.target.dataset.no);
		const no = e.target.dataset.no;
		const categoryNo = e.target.value;
		const frm = document.adminLocalCategoryUpdateFrm;
		
		if(confirm(`해당 게시물의 카테고리를 변경하시겠습니까?`)){			
			frm.no.value = no;
			frm.categoryNo.value = categoryNo;
			frm.submit();
		}
		else {
			e.target.querySelector("option[selected]").selected = true;
		}
		
	});
});

/* 동네생활 게시글 삭제 */
function adminLocalDelete(e) {
	const no = e.value;
	console.log(no);	
	const frm = document.adminLocalDeleteFrm;
	console.log(frm);
	
	if(confirm('정말 이 게시물을 삭제하시겠습니까?')) {
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
    	beforeUrl = '${pageContext.request.contextPath}/admin/adminLocalList.do?currentPage=' + (currentPage - 1);
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
        	pageUrl = '${pageContext.request.contextPath}/admin/adminLocalList.do?currentPage=' + i;
        	pagination.append("<li class='page-item'><a class='page-link' href='" + pageUrl + "'>" + i + "</a></li>");
        }
    }

    // 다음 버튼 추가
    let nextUrl;
    if (currentPage != totalPages) {
    	nextUrl = '${pageContext.request.contextPath}/admin/adminLocalList.do?currentPage=' + totalPages;    	
        pagination.append("<li class='page-item'><a class='page-link' href='" + nextUrl +"'>다음</a></li>");
    } else {
        pagination.append("<li class='page-item disabled'><a class='page-link'>다음</a></li>");
    }
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />