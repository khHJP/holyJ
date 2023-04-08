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
			<a class="sidebar-nav-a" href="${pageContext.request.contextPath}/admin/adminMemberList.do" style="text-decoration: none; color: #56C271;"> 회원 관리 </a></li>
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
		<form:form name="adminMemberSearchFrm" method="get">
			<input type="search" class="search" id="searchKeyword" name="searchKeyword" placeholder="&nbsp; 아이디/닉네임 검색...">
			<button type="submit" class="searchButton">검색</button>
		</form:form>
		<h1 style="font-family: 'BMJUA', sanserif; margin-top: 30px; margin-bottom: 10px;">회원 관리</h1>
		<table>
			<thead>
				<tr>
					<th><img src="${pageContext.request.contextPath}/resources/upload/profile/oee.png" 
								style="width: 30px; height: 30px;"></th>
					<th>아이디</th>
					<th>권한</th>
					<th>닉네임</th>
					<th>휴대폰</th>
					<th>매너온도</th>
					<th>신고 횟수</th>
					<th>가입일</th>
					<th>회원 삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${adminMemberList}" var="adminMember" varStatus="vs">
					<tr id="table-content">
						<td><img src="${pageContext.request.contextPath}/resources/upload/profile/${adminMember.profileImg}" 
								style="width: 50px; height: 50px; border-radius: 50px;"></td>
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
						<c:if test="${adminMember.reportCnt lt 3}">
							<td>${adminMember.reportCnt}</td>
						</c:if>
						<c:if test="${adminMember.reportCnt ge 3}">
							<td style="color: red">${adminMember.reportCnt}</td>
						</c:if>
						<td>
							<fmt:parseDate value="${adminMember.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate" /> 
							<fmt:formatDate value='${enrollDate}' pattern="yyyy.MM.dd" />
						</td>
						<td>
							<input type="hidden" class="member delete" id="memberId${vs.count}" value="${adminMember.memberId}"/>
							<input type="button" class="member delete" value="삭제"  onclick="adminMemberDelete(memberId${vs.count});" />
						</td>
					</tr>
				</c:forEach>
				
				<c:if test="${adminMemberSearch != null}">
						<c:forEach items="${adminMemberSearch}" var="adminMemberSearch" varStatus="searchvs">
							<tr id="table-content">
								<td>${searchvs.count}</td>
								<td>${adminMemberSearch.memberId}</td>
								<td>
									<select class="member-role" data-member-id="${adminMemberSearch.memberId}">
										<option value="ROLE_USER" <c:if test="${adminMemberSearch.auth.auth eq 'ROLE_USER'}"> selected="selected"</c:if>> ROLE_USER</option>
										<option value="ROLE_ADMIN" <c:if test="${adminMemberSearch.auth.auth eq 'ROLE_ADMIN'}"> selected="selected"</c:if>>ROLE_ADMIN</option>
										<option value="ROLE_WARN" <c:if test="${adminMemberSearch.auth.auth eq 'ROLE_WARN'}"> selected="selected"</c:if>>ROLE_WARN</option>
									</select>
								</td>
								<td>${adminMemberSearch.nickname}</td>
								<td>
									<fmt:formatNumber var="phone" value="${adminMemberSearch.phone}" pattern="000,0000,0000"/>
									<c:out value="${fn:replace(phone, ',', '-')}" />
								</td>
								<c:if test="${adminMemberSearch.manner lt 30}">
									<td style="color:#3AB0FF">${adminMember.manner}</td>
								</c:if>
								<c:if test="${adminMemberSearch.manner ge 35 && adminMemberSearch.manner lt 50}">
									<td style="color:#56C271">${adminMemberSearch.manner}</td>
								</c:if>
								<c:if test="${adminMemberSearch.manner ge 50}">
									<td style="color:red">${adminMemberSearch.manner}</td>
								</c:if>
								<c:if test="${adminMemberSearch.reportCnt lt 3}">
									<td>${adminMemberSearch.reportCnt}</td>
								</c:if>
								<c:if test="${adminMemberSearch.reportCnt ge 3}">
									<td style="color: red">${adminMemberSearch.reportCnt}</td>
								</c:if>
								<td>
									<fmt:parseDate value="${adminMemberSearch.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate" /> 
									<fmt:formatDate value='${enrollDate}' pattern="yyyy.MM.dd" />
								</td>
								<td>
									<input type="hidden" class="member delete" id="memberId${searchvs.count}" value="${adminMemberSearch.memberId}"/>
									<input type="button" class="member delete" value="삭제"  onclick="adminMemberDelete(memberId${searchvs.count});" />
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty adminMemberSearch}">
							<tr>
								<td colspan="9">검색 결과가 없습니다.</td>
							</tr>
						</c:if>
					</c:if>
			</tbody>
		</table>
		<nav aria-label="Page navigation example" class="pagebar-box">
 			<ul class="pagination justify-content-center"></ul>
		</nav>
	</div>

</section>
<!-- 회원 권한 수정 폼 -->
<form:form name="adminMemberRoleUpdateFrm" action="${pageContext.request.contextPath}/admin/adminMemberRoleUpdate.do" method="post">
	<input type="hidden" name="memberId">
	<input type="hidden" name="auth">
</form:form>
<!-- 회원 삭제 폼 -->
<form:form name="adminMemberUnregisterUpdateFrm" action="${pageContext.request.contextPath}/admin/adminMemberUnregisterUpdate.do" method="post">
	<input type="hidden" name="memberId">
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
function adminMemberDelete(e) {
	const memberId = e.value;
	console.log(memberId);	
	const frm = document.adminMemberUnregisterUpdateFrm;
	console.log(frm);
	
	if(confirm('정말 이 회원을 삭제하시겠습니까?')) {
		frm.memberId.value = memberId;
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
    	beforeUrl = '${pageContext.request.contextPath}/admin/adminMemberList.do?currentPage=' + (currentPage - 1);
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
        	pageUrl = '${pageContext.request.contextPath}/admin/adminMemberList.do?currentPage=' + i;
        	pagination.append("<li class='page-item'><a class='page-link' href='" + pageUrl + "'>" + i + "</a></li>");
        }
    }

    // 다음 버튼 추가
    let nextUrl;
    if (currentPage != totalPages) {
    	nextUrl = '${pageContext.request.contextPath}/admin/adminMemberList.do?currentPage=' + totalPages;    	
        pagination.append("<li class='page-item'><a class='page-link' href='" + nextUrl +"'>다음</a></li>");
    } else {
        pagination.append("<li class='page-item disabled'><a class='page-link'>다음</a></li>");
    }
}

/* 회원 검색 */
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
		location.href = "${pageContext.request.contextPath}/admin/adminMemberList.do";
	}	
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />