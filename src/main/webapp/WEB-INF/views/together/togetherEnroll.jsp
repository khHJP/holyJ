<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="같이해요" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/together/togetherEnroll.css" />
<div class="enroll-container">
	<div class="enroll-wrap">
		<form:form name="togetherEnrollFrm" action="">
			<div class="page-title">
				<h2>무엇을 같이할까요?</h2>
			</div>
			<div class="category-conatainer">
				<h5>카테고리 선택</h5>
				<c:forEach items="${categorys}" var="category" varStatus="vs">
					<input class="category" type="radio" name="category" id="category${vs.count}" value="${category.CATEGORY_NO}">
					<label class="category-label" for="category${vs.count}">
						${category.CATEGORY_NAME}
					</label>
				</c:forEach>
			</div>
			<div class="to-title">
				<label for="to-title">제목</label>
				<input type="text" name="title" class="to-input" id="to-title">
			</div>
			<div>
				<label>모임 내용</label>
				<textarea rows="" cols=""></textarea>
			</div>
			<div>
				<h5>모임 정보</h5>
				<div>
					<div>
						<label>인원</label>
					</div>
					<div>
						<label>성별</label>
					</div>
					<div>
						<label>인원</label>
					</div>
					<div>
						<label>모임시간</label>
					</div>
					<div>
						<label>나이</label>
					</div>
					<div>
						<label>장소</label>
					</div>
				</div>
			</div>
			<div>
				<input type="submit" value="등록하기">
			</div>
		</form:form>
	</div>
</div>
<script type="text/javascript">

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>