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
const totalPages = '${totalPages}';
const currentPage = '${currentPage}';
const categoryNo = '${param.categoryNo}';
const status = '${param.status}';

$(document).ready(function() {
	// 페이지네이션 생성
 	generatePagination(totalPages, currentPage);
	
	// 카테고리 선택시 해당 카테고리에 스타일 입히기
	if(categoryNo){
		const selectedCategory = document.querySelectorAll(".category-nav");
		selectedCategory.forEach((cate_gory) => {
			const num = cate_gory.dataset.categoryNum;
			if(categoryNo == num){
				cate_gory.firstElementChild.classList.add('light');
				cate_gory.lastElementChild.style.color='#56C271';
			}			
		});
	}
	else {
		const main = document.querySelector(".main");
		main.classList.add('light');
		main.nextElementSibling.style.color='#56C271';
	}
	
	// 모임 중인 글만 볼때 스타일 입히기
	if(status){
		const text = document.querySelector("[for=checked-box]");
		text.style.color = '#56C271';
	}
	
	// 
});
</script>
<div class="together-list-container">
	<div class="together-list-wrap">
		<div class="category-nav" data-category-num>
			<div class="category-img main">
				<i class="fa-solid fa-house"></i>
			</div>
			<div class="category-name">
				<p>전체</p>
			</div>
		</div>
		<c:forEach items="${categorys}" var="category">
			<div class="category-nav" data-category-num="${category.CATEGORY_NO}">
				<div class="category-img">
					<c:if test="${category.CATEGORY_NO eq 1}">
						<i class="fa-solid fa-utensils"></i>
					</c:if>
					<c:if test="${category.CATEGORY_NO eq 2}">
						<i class="fa-solid fa-shoe-prints"></i>
					</c:if>
					<c:if test="${category.CATEGORY_NO eq 3}">
						<i class="fa-solid fa-book"></i>
					</c:if>
					<c:if test="${category.CATEGORY_NO eq 4}">
						<i class="fa-solid fa-palette"></i>
					</c:if>
					<c:if test="${category.CATEGORY_NO eq 5}">
						<i class="fa-solid fa-paw"></i>
					</c:if>
					<c:if test="${category.CATEGORY_NO eq 6}">
						<i class="fa-solid fa-bars"></i>
					</c:if>
				</div>
				<div class="category-name">
					<p>${category.CATEGORY_NAME}</p>
				</div>
			</div>
		</c:forEach><!-- end categoryList -->	
	</div><!-- end together-list-wrap -->
	<div class="etc-wrap">
		<div class="checked-box">
  			<input type="checkbox" id="checked-box" class="ing-board" ${param.status eq 'Y' ? 'checked' : ''}/>
  			<label for="checked-box">모집중인 글만 보기</label>
		</div>
		<div class="enroll-box">
			<button class="btn enroll">글쓰기</button>
		</div>
	</div><!-- end etc-box -->
	<div class="together-content-wrap">
		<!-- 카테고리 변수 선언 -->
		<c:set var="category" value="${categorys}" scope="page"/>
		<c:if test="${not empty togetherList}">
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
									<div class="to-time">
										<i class="bi bi-calendar4-week"></i>
										<p class="to-datetime">
											<fmt:parseDate value="${together.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="dateTime"/>
											<fmt:formatDate value="${dateTime}" pattern="MM월 dd일 E요일 HH시 mm분"/>
										</p>
									</div>
									<div class="to-cnt">
											<c:forEach items="${joinMemberList}" var="joinMember">
												<c:if test="${joinMember.togetherNo eq together.no}">
													<span class="member-img"><img src="${pageContext.request.contextPath}/resources/upload/profile/${joinMember.member.profileImg}" alt="참여이웃프로필"></span>
												</c:if>										
											</c:forEach>
										<div class="check-cnt">
											<c:forEach items="${joinCntList}" var="cnt">
												<c:if test="${cnt.togetherNo eq together.no}">
													<span class="current-join-cnt">${cnt.joinCnt}</span>
												</c:if>
											</c:forEach>
											<span>&#47;</span>
											<span>${together.joinCnt}명</span>
										</div>
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
		</c:if>
		<c:if test="${empty togetherList}">
			<div class="empty-box">
				<p>해당 같이해요는 아직 등록되지 않았어요!</p>
			</div>
		</c:if>
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

/* 모집중인 글만 보기 */
document.querySelector(".ing-board").addEventListener("change", (e) => {
	let yn;
	// 체크여부에 따른 분기	
	if(e.target.checked)
		yn = 'Y';
	else
		yn = '';
	
	// 페이지 이동
	location.href='${pageContext.request.contextPath}/together/togetherList.do?currentPage=1'
		 + (categoryNo ? '&categoryNo=' + categoryNo : '')
		 + '&status=' + yn;
});

/* 카테고리 선택 */
document.querySelectorAll(".category-nav").forEach((category) => {
	category.addEventListener('click', (e) => {
		const no = category.dataset.categoryNum;
		console.log(no);
		
		location.href='${pageContext.request.contextPath}/together/togetherList.do?currentPage=1&categoryNo=' + no 
					+ (status ? '&status=' + status : '');
	});
});

/* 페이지 처리 */
/* 페이지네이션 버튼을 생성하는 함수 */
const generatePagination = (totalPages, currentPage) => {
    let pagination = $(".pagination");
    pagination.empty(); // 이전에 생성된 페이지네이션 버튼 초기화
    
    
    let beforeUrl;
	 // 이전 버튼 추가
    if (currentPage != 1 && totalPages != 0) {
    	beforeUrl = '${pageContext.request.contextPath}/together/togetherList.do?currentPage=' + (currentPage - 1);
    	if(categoryNo) {
    		beforeUrl += '&categoryNo=' + categoryNo;
    	}
    	if(status) {
    		beforeUrl += '&status=' + status;
    	}
    			
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
        	pageUrl = '${pageContext.request.contextPath}/together/togetherList.do?currentPage=' + i;
        	if(categoryNo) {
        		pageUrl += '&categoryNo=' + categoryNo;
        	}
        	if(status) {
        		pageUrl += '&status=' + status;
        	}
        	
            pagination.append("<li class='page-item'><a class='page-link' href='" + pageUrl + "'>" + i + "</a></li>");
        }
    }

    // 다음 버튼을 추가
    let nextUrl;
    if (currentPage != totalPages && totalPages != 0) {
    	nextUrl = '${pageContext.request.contextPath}/together/togetherList.do?currentPage=' + totalPages;
    	if(categoryNo) {
    		nextUrl += '&categoryNo=' + categoryNo;
    	}
    	if(status) {
    		nextUrl += '&status=' + status;
    	}
    	
        pagination.append("<li class='page-item'><a class='page-link' href='" + nextUrl +"'>다음</a></li>");
    } else {
        pagination.append("<li class='page-item disabled'><a class='page-link'>다음</a></li>");
    }
    
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>