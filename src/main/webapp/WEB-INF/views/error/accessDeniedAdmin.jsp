<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="acess-denied-container">
	<div class="error-img">
		<img src="${pageContext.request.contextPath}/resources/images/오이금지.png">
	</div>
	<div class="error-wrap">
		<h1>관리자에 의해 규제된 게시글입니다.</h1>
		<a href="${pageContext.request.contextPath}/" class="nav-link">홈으로</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>