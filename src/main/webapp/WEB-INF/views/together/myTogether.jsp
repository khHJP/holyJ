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
		<h1 class="sub_title">내 글 목록</h1>
		<br />
<section id="board-container" class="container">
	<table id="tbl-board" class="table">
		<c:forEach items="${myTogether}" var="together">
			<tr data-no="${together.no}" id="no">
				<td id="status">${together.status}</td>
				<th id="title">${together.title}</th>
				<td id="age">${together.age}</td>
				<td id="dateTime">
					<fmt:parseDate value="${together.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="dateTime"/>
					<fmt:formatDate value="${dateTime}" pattern="yy-MM-dd HH:mm"/>
				</td>
				<td id="joinCnt">${together.joinCnt}</td>
			</tr>
		</c:forEach>
	</table>
</section> 
<script>
document.querySelectorAll("tr[data-no]").forEach((tr) => {
	tr.addEventListener('click', (e) => {
		//console.log(e.target, tr);
		const no = tr.dataset.no;
		console.log(no);
	});
});
</script>		
		
				
	</div>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>