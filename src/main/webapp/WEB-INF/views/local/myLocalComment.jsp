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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/local/mylocalCo.css" />

</head>
<body>
<br /><br />
	<div class="local-container">
		<h1 class="sub_title">내 댓글 목록</h1>
		<br />
		<div>
			<ul class="local-ul">
				<li><a id="local-li" href="${pageContext.request.contextPath}/local/myLocal.do">게시글</a></li>
				<li><a class="command" id="local-li" href="${pageContext.request.contextPath}/local/myLocalComment.do">댓글</a></li>
			</ul>
		</div>
		<hr />
<section id="board-container" class="container">
	<table id="tbl-board" class="table table-hover">
		<c:choose>
			<c:when test="${not empty myLocalComment}">
				<c:forEach items="${myLocalComment}" var="localCo">
						 <tr data-no="${localCo.localNo}" id="tr-table">
							<td class="span1" id="loContent">${localCo.content}</td>
							<td class="span1" id="loTitle">'${localCo.title}'</td>
						</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div id="empty">
					<img src="${pageContext.request.contextPath}/resources/images/오이.png" alt="" id="emptyimg"/>
				옹잉?? 작성하신 댓글이 없어용!!</div>
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