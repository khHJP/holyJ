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
	<div class="local-container">
		<h1 class="sub_title">나의 판매내역</h1>
		<br />
		<div>
			<ul class="local-ul">
				<li><a id="local-li" href="${pageContext.request.contextPath}/craig/mySalCraig.do">판매중</a></li>
				<li><a id="local-li" href="${pageContext.request.contextPath}/craig/mySalFCraig.do">거래완료</a></li>
			</ul>
		</div>
		<hr />
	
	</div>
<script>
document.querySelectorAll("tr[data-no]").forEach((tr) => {
	tr.addEventListener('click', (e) => {
		// console.log(e.target, tr);
		const no = tr.dataset.no;
		console.log(no);
	
	location.href = '${pageContext.request.contextPath}/craig/craigDetail.do?no=' + no;
	});
});		
		
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>