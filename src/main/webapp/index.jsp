<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="main-container">
	<div class="main-wrap">
		<div class="main-info">
			<h1>오늘의 이웃</h1>
			<h1>오이마켓</h1>
			<h3>
				중고 거래부터 동네 정보까지, 이웃과 함께해
				<br/>
				가깝고 따뜻한 당신의 근처를 만들어요.
			</h3>
		</div>
		<div class="main-img">
			<img src="${pageContext.request.contextPath}/resources/images/main.png">
		</div>
	</div><!-- end main-wrap -->
</div><!-- end main-container -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>