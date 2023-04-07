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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/local/mylocal.css" />

</head>
<body>
<br /><br />
	<c:choose>
			<c:when test="${not empty myLocal}">
	<div class="local-container">
				<h1 class="sub_title">${myLocal[0].member.nickname}님 동네생활 글</h1>
		<br />		
		<div>
			<ul class="local-ul">
				<li><a class="board"id="local-li" href="${pageContext.request.contextPath}/local/myLocal1.do">게시글</a></li>
			</ul>
		</div>
		<hr />
		</c:when>
		<c:otherwise>
			<div class="local-container">
				<h1 class="sub_title">동네생활 글</h1>
			</div>
		</c:otherwise>
		</c:choose>
<section id="board-container" class="container">
	<table id="tbl-board" class="table table-hover">
		<c:choose>
				<c:when test="${not empty myLocal}">
					<c:forEach items="${myLocal}" var="local">
							 <tr data-no="${local.no}" id="tr-table">
								<c:choose>
									<c:when test="${local.categoryNo eq '1'}">
											<td class="span1" id="category">동네생활</td>
									</c:when>
									<c:when test="${local.categoryNo eq '2'}">
											<td class="span1" id="category">동네소식</td>
									</c:when>
									<c:when test="${local.categoryNo eq '3'}">
											<td class="span1" id="category">분실/실종센터</td>
									</c:when>
									<c:otherwise>
											<td class="span1" id="category">해주세요</td>
									</c:otherwise>
								</c:choose>
									<td class="span1" id="toTitle">
									<span id="qu">Q.&nbsp</span> 
									${local.title}</td>
							</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div id="empty">
						<img src="${pageContext.request.contextPath}/resources/images/오이.png" alt="" id="emptyimg"/>
					옹잉?? 작성한 게시물이 없어용!!</div>
				</c:otherwise>
			</c:choose>
	</table>
</section> 	
	</div>
<script>
document.querySelectorAll("tr[data-no]").forEach((tr) => {
	tr.addEventListener('click', (e) => {
		// console.log(e.target, tr);
		const no = tr.dataset.no;
		console.log(no);
	
		location.href = '${pageContext.request.contextPath}/local/localDetail.do?no=' + no;
	});
});		
		
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>