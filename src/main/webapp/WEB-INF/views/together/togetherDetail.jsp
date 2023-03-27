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
<script>
/* 매너온도에 따른 색변화 */
window.addEventListener('load', (e) => {
	const temperature = document.querySelector(".temperature span");
	console.log(temperature);
	
	if(temperature.innerText < 30) temperature.style.color = '#3AB0FF'; 
	else if(temperature.innerText >= 30 && temperature.innerText < 50) temperature.style.color = '#56C271'; 
	else if(temperature.innerText >= 50) temperature.style.color = '#F94C66'; 
	
});
</script>
<sec:authentication property="principal" var="loginMember"/>
<div class="together-container">
	<div class="together-wrap">
		<div class="writer-info-box">
			<div class="writer-box">
				<div class="profile-box">
					<img src="${pageContext.request.contextPath}/resources/upload/profile/${together.member.profileImg}" alt="사용자프로필">
				</div>
				<div class="detail-box">
					<p>${together.member.nickname}</p>
					<p>${together.dong.dongName}</p>
				</div>
			</div>
			<div class="manner-box">
				<div class="temperature">
					<span>${together.member.manner}</span>
					<c:if test="${together.member.manner lt 30}">
						<i class="bi bi-thermometer-low"></i>
					</c:if>
					<c:if test="${together.member.manner ge 35 && together.member.manner lt 50}">
						<i class="bi bi-thermometer-half"></i>
					</c:if>
					<c:if test="${together.member.manner ge 50}">
						<i class="bi bi-thermometer-high"></i>
					</c:if>
				</div>
				<p>매너온도</p>
			</div>
		</div><!-- end writer-info-box -->
		<div class="category-box">
			<span>
				<c:if test="${together.categoryNo eq 1}">
					<i class="bi bi-cup-hot"></i>
				</c:if>
				<c:if test="${together.categoryNo eq 2}">
					<i class="bi bi-bicycle"></i>
				</c:if>
				<c:if test="${together.categoryNo eq 3}">
					<i class="bi bi-pencil-square"></i>
				</c:if>
				<c:if test="${together.categoryNo eq 4}">
					<i class="bi bi-palette"></i>
				</c:if>
				<c:if test="${together.categoryNo eq 5}">
					
				</c:if>
				<c:if test="${together.categoryNo eq 6}">
					<i class="bi bi-three-dots"></i>
				</c:if>
				${category}
			</span>
		</div><!-- end category-box -->
		<div class="header-box">
			<div class="info-box">
				<div class="status-box">
					<c:if test="${together.status eq 'Y'}">
					<h2 class="status ing">모집중</h2>
					</c:if>
					<c:if test="${together.status eq 'N'}">
						<h2 class="status end">모집완료</h2>
					</c:if>
				</div>
				<div class="title-box">
					<h2>${together.title}</h2>
				</div>
			</div>
			<div class="choose-box">
			<c:if test="${together.writer eq loginMember.memberId}">
				<button class="btn">모임종료</button>
			</c:if>
			<c:if test="${together.writer ne loginMember.memberId}">
				<button class="btn">신고하기</button>				
			</c:if>
			</div>
		</div><!-- end header-box -->
		<div class="content-box">
			<h4>정보</h4>
			<div class="info required">
				<!-- 성별 선택 -->
				<i class="bi bi-people-fill"></i>
				<c:if test="${together.gender eq 'A'}">
					<span class="gender">성별무관</span>
				</c:if>
				<c:if test="${together.gender eq 'F'}">
					<span class="gender">여성</span>
				</c:if>
				<c:if test="${together.gender eq 'M'}">
					<span class="gender">남성</span>
				</c:if>
				&nbsp;&middot;&nbsp;
				<!-- 나이 선택 -->
				<c:if test="${together.age eq '100'}">
					<span class="age">나이무관</span>
				</c:if>
				<c:if test="${together.age ne '100'}">
					<span class="age">${together.age}대이상</span>
				</c:if>
			</div>
			<div class="info appointmen">
				<i class="bi bi-calendar4-week"></i>
				<p class="datetime">
					<fmt:parseDate value="${together.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="dateTime"/>
					<fmt:formatDate value="${dateTime}" pattern="MM월 dd일 E요일 HH시 mm분"/>
				</p>
			</div>
			<div class="info place">
				<i class="bi bi-geo-alt"></i>
				<p>${together.place}</p>
			</div>
			<div class="modify-box">
				<!-- 😺 채팅 참여하기 - join으로 이벤트 걸으면 될것같요! 😺 -->
				<button class="join btn">참가하기</button>
				<!-- 😺 채팅 참여하기 😺 -->
				<c:if test="${together.writer eq loginMember.memberId}">
						<button class="btn modify">수정</button>
						<button class="btn delete">삭제</button>
				</c:if>
			</div>
		</div>
		<hr>
		<div class="content-detail-box">
			<h4>상세내용</h4>
			<p>${together.content}</p>
		</div>
		<div class="join-member-box">
			<h4>참여중인 이웃<span></span></h4>
			<div></div>
		</div>
	</div>
</div>
<!-- 삭제하기 히든폼 -->
<c:if test="${together.writer eq loginMember.memberId}">
<form:form name="togetherDeleteFrm" action="${pageContext.request.contextPath}/together/togetherDelete.do" method="post">
	<input type="hidden" value="${together.no}" name="no">
</form:form>
</c:if>
<!-- 👻 정은 시작 👻 -->
<script>
/* 같이해요 수정 */
document.querySelector(".modify").addEventListener('click', (e) => {
	const no = '${together.no}';
	location.href = '${pageContext.request.contextPath}/together/togetherUpdate.do?no=' + no;	
});

/* 같이해요 삭제 */
document.querySelector(".delete").addEventListener('click', (e) => {
	if(confirm('해당 게시글을 삭제하시겠습니까?')){
		document.togetherDeleteFrm.submit();
	}
});

</script>
<!-- 👻 정은 끝 👻 -->

<script>
/* 클릭 잘되는지 한번 만들어봤어욤! 지우고 다시하셔도 됩니다! */
document.querySelector(".join").addEventListener('click', (e) => {
	const no = '${together.no}';
	console.log(e.target, no); 
	/* location.href = */ 
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>