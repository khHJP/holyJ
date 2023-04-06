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
	<jsp:param value="중고거래관리" name="title" />
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
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminCraigList.do" style="text-decoration: none; color: #56C271;"> 중고거래 관리 </a></li>
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
		<form:form name="adminCraigSearchFrm" method="get">
			<input type="search" class="search" id="searchKeyword" name="searchKeyword" placeholder="&nbsp; 작성자/제목 검색...">
			<button type="submit" class="searchButton">검색</button>
		</form:form>
		<h1 style="font-family: 'BMJUA', sanserif; margin-top: 30px; margin-bottom: 10px;">중고거래 관리</h1>
		<table>
			<thead>
				<tr>
					<th>No</th>
					<th>카테고리</th>
					<th>작성자</th>
					<th>제목</th>
					<th>상태</th>
					<th>등록일</th>
					<th>완료일</th>
					<th>중고거래 삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${adminCraigList}" var="adminCraig" varStatus="vs">
					<tr id="table-content">
						<td id="count" class="craig-view" data-crno="${adminCraig.no}">${vs.count}</td>
						<td>
							<select class="craig-category" data-no="${adminCraig.no}">
								<option value=1 <c:if test="${adminCraig.categoryNo eq 1}"> selected="selected"</c:if>>디지털기기</option>
								<option value=2 <c:if test="${adminCraig.categoryNo eq 2}"> selected="selected"</c:if>>가구</option>
								<option value=3 <c:if test="${adminCraig.categoryNo eq 3}"> selected="selected"</c:if>>의류</option>
								<option value=4 <c:if test="${adminCraig.categoryNo eq 4}"> selected="selected"</c:if>>잡화</option>
								<option value=5 <c:if test="${adminCraig.categoryNo eq 5}"> selected="selected"</c:if>>서적</option>
								<option value=6 <c:if test="${adminCraig.categoryNo eq 6}"> selected="selected"</c:if>>기타</option>
								<option value=7 <c:if test="${adminCraig.categoryNo eq 7}"> selected="selected"</c:if>>삽니다</option>
							</select>
						</td>
						<td>${adminCraig.writer}</td>
						<td style="width: 230px;">${adminCraig.title}</td>
						<c:if test="${adminCraig.state eq 'CR1'}">
						<td style="color: #56C271;">예약중</td>
						</c:if>
						<c:if test="${adminCraig.state eq 'CR2'}">
						<td style="color: #56C271;">판매중</td>
						</c:if>
						<c:if test="${adminCraig.state eq 'CR3'}">
						<td style="color: #868B94;">판매완료</td>
						</c:if>
						<td>
							<fmt:parseDate value="${adminCraig.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="regDate" /> 
							<fmt:formatDate value='${regDate}' pattern="yyyy.MM.dd" />
						</td>
						<td>
							<fmt:parseDate value="${adminCraig.completeDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="completeDate" /> 
							<fmt:formatDate value='${completeDate}' pattern="yyyy.MM.dd" />
						</td>
						<td>
							<input type="hidden" class="craig delete" id="craig${vs.count}" value="${adminCraig.no}"/>
							<input type="button" class="craig delete" value="삭제"  onclick="adminCraigDelete(craig${vs.count});" />
						</td>
					</tr>
				</c:forEach>
				
				<c:if test="${adminCraigSearch != null}">
					<c:forEach items="${adminCraigSearch}" var="adminCraigSearch" varStatus="searchvs">
						<tr id="table-content">
							<td id="count" class="craig-view" data-crno="${adminCraigSearch.no}">${searchvs.count}</td>
							<td>
								<select class="craig-category" data-no="${adminCraigSearch.no}">
									<option value=1 <c:if test="${adminCraigSearch.categoryNo eq 1}"> selected="selected"</c:if>>디지털기기</option>
									<option value=2 <c:if test="${adminCraigSearch.categoryNo eq 2}"> selected="selected"</c:if>>가구</option>
									<option value=3 <c:if test="${adminCraigSearch.categoryNo eq 3}"> selected="selected"</c:if>>의류</option>
									<option value=4 <c:if test="${adminCraigSearch.categoryNo eq 4}"> selected="selected"</c:if>>잡화</option>
									<option value=5 <c:if test="${adminCraigSearch.categoryNo eq 5}"> selected="selected"</c:if>>서적</option>
									<option value=6 <c:if test="${adminCraigSearch.categoryNo eq 6}"> selected="selected"</c:if>>기타</option>
									<option value=7 <c:if test="${adminCraigSearch.categoryNo eq 7}"> selected="selected"</c:if>>삽니다</option>
								</select>
							</td>
							<td>${adminCraigSearch.writer}</td>
							<td>${adminCraigSearch.title}</td>
							<c:if test="${adminCraigSearch.state eq 'CR1'}">
							<td>예약중</td>
							</c:if>
							<c:if test="${adminCraigSearch.state eq 'CR2'}">
							<td>판매중</td>
							</c:if>
							<c:if test="${adminCraigSearch.state eq 'CR3'}">
							<td>판매완료</td>
							</c:if>
							<td>
								<fmt:parseDate value="${adminCraigSearch.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="regDate" /> 
								<fmt:formatDate value='${regDate}' pattern="yyyy.MM.dd" />
							</td>
							<td>
								<fmt:parseDate value="${adminCraigSearch.completeDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="completeDate" /> 
								<fmt:formatDate value='${completeDate}' pattern="yyyy.MM.dd" />
							</td>
							<td>
								<input type="hidden" class="craig delete" id="craig${searchvs.count}" value="${adminCraigSearch.no}"/>
								<input type="button" class="craig delete" value="삭제"  onclick="adminCraigDelete(craig${searchvs.count});" />
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<nav aria-label="Page navigation example" class="pagebar-box">
 			<ul class="pagination justify-content-center"></ul>
		</nav>
	</div>

</section>
<!-- 중고거래 카테고리 수정 폼 -->
<form:form name="adminCraigCategoryUpdateFrm" action="${pageContext.request.contextPath}/admin/adminCraigCategoryUpdate.do" method="post">
	<input type="hidden" value="${adminCraig.no}" name="no">
	<input type="hidden" value="${adminCraig.categoryNo}" name="categoryNo">
</form:form>
<!-- 중고거래 카테고리 삭제 폼 -->
<form:form name="adminCraigDeleteFrm" action="${pageContext.request.contextPath}/admin/adminCraigDelete.do" method="post">
	<input type="hidden" name="no">
</form:form>
<script>
/* 중고거래 상세 페이지 연결 */
document.querySelectorAll(".craig-view").forEach( (td)=>{
	td.addEventListener('click', (e) => {
		console.log(e.target);
		console.log(td);
		
		const no = td.dataset.crno;
		console.log(no);
		location.href = "${pageContext.request.contextPath}/craig/craigDetail.do?no="+no;
		
	});
});

/* 중고거래 카테고리 수정 */
document.querySelectorAll(".craig-category").forEach((select) => {
	select.addEventListener('change', (e) => {
		console.log(e.target.value);
		console.log(e.target.dataset.no);
		const no = e.target.dataset.no;
		const categoryNo = e.target.value;
		const frm = document.adminCraigCategoryUpdateFrm;
		
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

/* 중고거래 게시글 삭제 */
function adminCraigDelete(e) {
	const no = e.value;
	console.log(no);	
	const frm = document.adminCraigDeleteFrm;
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
    	beforeUrl = '${pageContext.request.contextPath}/admin/adminCraigList.do?currentPage=' + (currentPage - 1);
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
        	pageUrl = '${pageContext.request.contextPath}/admin/adminCraigList.do?currentPage=' + i;
        	pagination.append("<li class='page-item'><a class='page-link' href='" + pageUrl + "'>" + i + "</a></li>");
        }
    }

    // 다음 버튼 추가
    let nextUrl;
    if (currentPage != totalPages) {
    	nextUrl = '${pageContext.request.contextPath}/admin/adminCraigList.do?currentPage=' + totalPages;    	
        pagination.append("<li class='page-item'><a class='page-link' href='" + nextUrl +"'>다음</a></li>");
    } else {
        pagination.append("<li class='page-item disabled'><a class='page-link'>다음</a></li>");
    }
}

/* 중고거래 검색 */
document.querySelector(".searchButton").addEventListener('click', (e) => {
	const searchKeyword =  document.querySelector("#searchKeyword").value;
	console.log(searchKeyword);

	const blank_pattern = /^\s+|\s+$/g;
	
	if(searchKeyword.replace(blank_pattern, '' ) == "" ){
		alert("검색어를 입력해 주세요!");
		document.querySelector("#searchKeyword").select();
		e.preventDefault();
		return false;
	}
	
	else if(searchKeyword != null && searchKeyword != "" ){
		location.href = "${pageContext.request.contextPath}/admin/adminCraigList.do";
	}	
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />