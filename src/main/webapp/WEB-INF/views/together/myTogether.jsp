<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="subtitle"/>
</jsp:include>
<!-- css 주소 바꾸기 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mytogether.css" />

</head>
<br /><br />
	<div class="together-container">
		<h1 class="sub_title">내 글 목록</h1>
	
<section id="board-container" class="container">
	<table id="tbl-board" class="table table-striped table-hover">
		<c:forEach items="${myTogether}" var="together">
				 <tr data-no="${together.no}" id="tr-table">
					<c:choose>
						<c:when test="${not empty myTogether}">
							<c:if test="${together.status eq 'Y'}">
								<td class="span1" id="status-y">모집중</td>
							</c:if>
							<c:if test="${together.status eq 'N'}">
								<td class="span1" id="status-n">모집완료</td>
							</c:if>
							<td class="span1" id="toTitle">${together.title}</td>
							<c:if test="${together.age eq '100'}">
								<td class="span1" id="toAge">
								<img src="${pageContext.request.contextPath}/resources/images/human.png" alt="" id="togetherimg"/>
								누구나 참여가능</td>
							</c:if>
							<c:if test="${together.age ne '100'}">
								<td class="span1" id="toAge">
								<img src="${pageContext.request.contextPath}/resources/images/human.png" alt="" id="togetherimg"/>
								${together.age}대</td>
							</c:if>
							<td class="span1" id="toDteTime">
								<img src="${pageContext.request.contextPath}/resources/images/calendar.png" alt="" id="togetherimg"/>
								<fmt:parseDate value="${together.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="dateTime"/>
								<fmt:formatDate value="${dateTime}" pattern="yy-MM-dd HH:mm"/>
							</td>
							<td class="span1" id="toJoinCnt">
								<img src="${pageContext.request.contextPath}/resources/images/humans.png" alt="" id="togetherimg"/>
							${together.joinCnt}명</td>
						</c:when>
						<c:otherwise>
							<td colspan="5">옹잉?? 작성하신 게시물이 없어용!!</td>
						</c:otherwise>
					</c:choose>
				</tr>
		</c:forEach>
				<%-- <tr data-no="${together.no}">
					<c:if test="${together.status eq 'Y'}">
						<td class="span1" id="status-y">모집중</td>
					</c:if>
					<c:if test="${together.status eq 'N'}">
						<td class="span1" id="status-n">모집완료</td>
					</c:if>
						<td>${together.age}</td>
						<td>
							<fmt:parseDate value="${together.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="dateTime"/>
							<fmt:formatDate value="${dateTime}" pattern="yy-MM-dd HH:mm"/>
						</td>
						<td>${together.joinCnt}</td>
					</tr>
				</c:forEach> --%>
	</table>
</section> 	
	</div>
<script>
document.querySelectorAll("tr[data-no]").forEach((tr) => {
	tr.addEventListener('click', (e) => {
		// console.log(e.target, tr);
		const no = tr.dataset.no;
		console.log(no);
	
		location.href = '${pageContext.request.contextPath}/together/togetherDetail.do?no=' + no;
	});
});

</script>		
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>