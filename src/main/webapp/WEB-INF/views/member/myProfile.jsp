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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myprofile.css" />
<!-- <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet"> -->


</head>
<body>
<br />
<br />
	<table>
		<th>
			<td>
				<img src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지" id="profile">
			</td>
			<td>
				<span id="nickname">오이</span>
			</td>
		</th>
	</table>
	<br />
	<table id="mannertmp">
		<th>
			<td>매너온도</td>
			<td></td>
		</th>
	</table>
	<br />
	<div id="proupdate">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/memberDetail.do'" id="probut">프로필 수정</button>
	</div>
	<br />
	<div id="proupdate">
		<hr />
		<li id="sala">
		<a href="">판매 상품 *개</a>
		</li>
		<hr />
		<li id="sala">
		<a href="">받은매너평가
		</a>
		</li>
		<hr />
	</div>
	
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>