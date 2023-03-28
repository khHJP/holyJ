<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="같이해요" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/together/together.css" />
<script type="text/javascript">
$(document).ready(function() {
  // 페이지네이션 생성
  generatePagination(totalPages, currentPage);
});
</script>
<div class="together-list-container">
	<div class="together-list-wrap">
		<div class="category-nav">
			<div class="category-img">
			</div>
			<div class="category-name">
				<p>전체</p>
			</div>
		</div>
		<c:forEach items="${categorys}" var="category">
			<div class="category-nav">
				<div class="category-img">
					<%-- <img src="${pageContext.request.contextPath}/resources/images/tocate${category.CATEGORY_NO}.png"> --%>
				</div>
				<div class="category-name">
					<p>${category.CATEGORY_NAME}</p>
				</div>
			</div>
		</c:forEach><!-- end categoryList -->	
	</div><!-- end together-list-wrap -->
	<div class="etc-wrap">
		<div class="checked-box">
  			<input type="checkbox" id="checked-box"/>
  			<label for="checked-box">모집중인 글만 보기</label>
		</div>
		<div class="enroll-box">
			<button class="btn enroll">글쓰기</button>
		</div>
	</div><!-- end etc-box -->
	<div class="together-content-wrap">
		<!-- 카테고리 변수 선언 -->
		<c:set var="category" value="${categorys}" scope="page"/>
		<table>
			<tbody>
				<c:forEach items="${togetherList}" var="together" varStatus="vs">
					<c:if test="${vs.index % 2 == 0}">
						<tr class="to-table-tr">
					</c:if>
					<td class="together-view" data-no="${together.no}" data-category="${category[together.categoryNo - 1].CATEGORY_NAME}">
						<div class="together-content">
							<div class="together-header">
								<c:if test="${together.status eq 'Y'}">
									<span class="to-status ing">모집중</span>
								</c:if>
								<c:if test="${together.status eq 'N'}">
									<span class="to-status end">모집완료</span>
								</c:if>
								&nbsp;&middot;&nbsp;
								<span class="to-category">${category[together.categoryNo - 1].CATEGORY_NAME}</span>
								&nbsp;&middot;&nbsp;
								<span class="to-dong">${together.dong.dongName}</span>
							</div>
							<div class="together-body">
								<h4>${together.title}</h4>
								<!-- 나이 선택 -->
								<div class="to-required">
									<i class="bi bi-people-fill"></i>
									<c:if test="${together.gender eq 'A'}">
										<span class="to-gender">성별무관</span>
									</c:if>
									<c:if test="${together.gender eq 'F'}">
										<span class="to-gender">여성</span>
									</c:if>
									<c:if test="${together.gender eq 'M'}">
										<span class="to-gender">남성</span>
									</c:if>
									&nbsp;&middot;&nbsp;
									<!-- 나이 선택 -->
									<c:if test="${together.age eq '100'}">
										<span class="to-age">나이무관</span>
									</c:if>
									<c:if test="${together.age ne '100'}">
										<span class="to-age">${together.age}대이상</span>
									</c:if>
								</div>
								<!-- 날짜 (형식 바꿔야함) -->
								<div class="to-time">
									<i class="bi bi-calendar4-week"></i>
									<p class="to-datetime">
										<fmt:parseDate value="${together.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="dateTime"/>
										<fmt:formatDate value="${dateTime}" pattern="MM월 dd일 E요일 HH시 mm분"/>
									</p>
								</div>
								<!-- 채팅 후 다시 작성 -->
								<div class="to-cnt">
									<i class="bi bi-person-circle"></i>
									<i class="bi bi-person-circle"></i>
									<span>2/4명</span>
								</div>
							</div>
						</div>
					</td>
					<c:if test="${vs.index % 2 == 1}">
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<nav aria-label="Page navigation example" class="pagebar-box">
  		<ul class="pagination justify-content-center"></ul>
	</nav>
</div>
<script>
/* 같이해요 상세페이지 이동 */
document.querySelectorAll(".together-view").forEach((together) => {
	together.addEventListener('click', (e) => {
		const no = together.dataset.no; // 버블링 잊지말자!
		const category = together.dataset.category;
		console.log(no, category);
		location.href = '${pageContext.request.contextPath}/together/togetherDetail.do?category=' + category + "&no=" + no;
	});
});

/* 글쓰기 폼 이동 */
document.querySelector(".enroll").addEventListener('click', (e) => {
	location.href = '${pageContext.request.contextPath}/together/togetherEnroll.do';
});

/* 페이지 처리 */
const totalPages = '${totalPages}';
const currentPage = '${currentPage}';

console.log(currentPage);

// 페이지네이션 버튼을 생성하는 함수
const generatePagination = (totalPages, currentPage) => {
    let pagination = $(".pagination");
    pagination.empty(); // 이전에 생성된 페이지네이션 버튼 초기화
    
	 // 이전 버튼 추가
    if (currentPage != 1) {
      pagination.append("<li class='page-item'><a class='page-link' href='${pageContext.request.contextPath}/together/togetherList.do?currentPage=" + (currentPage - 1) +"' tabindex='-1'>이전</a></li>");
    } else {
      pagination.append("<li class='page-item disabled'><a class='page-link' tabindex='-1'>이전</a></li>");
    }

    // 페이지 버튼 추가
    for (let i = 1; i <= totalPages; i++) {
        if (i == currentPage) {
            pagination.append("<li class='page-item active'><a class='page-link'>" + i + "</a></li>");
        } else {
            pagination.append("<li class='page-item'><a class='page-link' href='${pageContext.request.contextPath}/together/togetherList.do?currentPage=" + i +"' data-page='" + i + "'>" + i + "</a></li>");
        }
    }

    // 다음 버튼을 추가
    if (currentPage != totalPages) {
        pagination.append("<li class='page-item'><a class='page-link' href='${pageContext.request.contextPath}/together/togetherList.do?currentPage=" + (currentPage + 1) +"'>다음</a></li>");
    } else {
        pagination.append("<li class='page-item disabled'><a class='page-link'>다음</a></li>");
    }
    
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>