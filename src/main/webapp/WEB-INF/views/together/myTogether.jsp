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
<body>
<br /><br />
	<div class="together-container">
		<h1 class="subtitle">내 글 목록</h1>
		<br />
<section id="board-container" class="container">
	<table id="tbl-board" class="table table-striped table-hover">
		<c:forEach items="${togetherList}" var="board">
			<tr data-no="${together.no}">
				<td>${together.status}</td>
				<td>${together.title}</td>
				<td>${together.age}</td>
				<td>${together.dateTime}</td>
				<td>${together.joinCount}</td>
				<%-- <td>
					<fmt:parseDate value="${together.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
					<fmt:formatDate value="${createdAt}" pattern="yy-MM-dd HH:mm"/>
				</td>
				<td>${together.readCount}</td> --%>
			</tr>
		</c:forEach>
	</table>
</section> 
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
		
				
	</div>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>