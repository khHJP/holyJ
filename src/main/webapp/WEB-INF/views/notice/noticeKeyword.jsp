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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noticekeyword.css" />


</head>
<body>
<br /><br />
	<div class="keycontainer">
		<h1 class="subtitle">알림 키워드 설정</h1>
		<br />
		<div class="search-container">
			<input type="text" id="search" placeholder="키워드를 입력해주세요.(예:자전거)"/>
			<button id="search-btn">
				<img src="${pageContext.request.contextPath}/resources/images/search.png" alt="" id="searchimg"/>
			</button>
		</div>
		<br /><br />
		<span id="upkword">등록한 키워드 */3</span>
		<br />
		<br />
		<div class="showkword">
			키워드
			<button id="cancel-btn">
				<img src="${pageContext.request.contextPath}/resources/images/cancel.png" alt="" id="cancelimg"/>
			</button>
		</div>
	</div>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>