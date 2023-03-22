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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/together.css" />
<div class="together-list-container">
	<div class="together-list-wrap">
		<div class="category-nav">
			<div class="category-img">
			</div>
			<div class="category-name">
				<p>전체</p>
			</div>
		</div>
		<c:forEach items="${categorys}" var="category">
			<div class="category-nav">
				<div class="category-img">
					<%-- <img src="${pageContext.request.contextPath}/resources/images/tocate${category.CATEGORY_NO}.png"> --%>
				</div>
				<div class="category-name">
					<p>${category.CATEGORY_NAME}</p>
				</div>
			</div>
		</c:forEach><!-- end categoryList -->	
	</div><!-- end together-list-wrap -->
	<div class="etc-wrap">
		<div class="checked-box">
  			<input type="checkbox" id="checked-box"/>
  			<label for="checked-box">모집중인 글만 보기</label>
		</div>
		<div class="enroll-box">
			<button class="btn">글쓰기</button>
		</div>
	</div><!-- end etc-box -->
	<div class="together-content-wrap">
		<!-- 카테고리 변수 선언 -->
		<c:set var="category" value="${categorys}" scope="page"/>
		<table>
			<tbody>
				<c:forEach items="${togetherList}" var="together" varStatus="vs">
					<c:if test="${vs.index % 2 == 0}">
						<tr>
					</c:if>
					<td>
						<div class="together-content">
							<div class="together-header">
								<c:if test="${together.status eq 'Y'}">
									<span>모집중</span>
								</c:if>
								<c:if test="${together.status eq 'N'}">
									<span>모집완료</span>
								</c:if>
								<span>${category[together.categoryNo - 1].CATEGORY_NAME}</span>
							</div>
							<div class="together-body">
								<h4>${together.title}</h4>
								<!-- 나이 선택 -->
								<c:if test="${together.gender eq 'A'}">
									<span>성별무관</span>
								</c:if>
								<c:if test="${together.gender eq 'F'}">
									<span>여성</span>
								</c:if>
								<c:if test="${together.gender eq 'M'}">
									<span>남성</span>
								</c:if>
								<!-- 나이 선택 -->
								<c:if test="${together.age eq '100'}">
									<span>나이무관</span>
								</c:if>
								<c:if test="${together.age ne '100'}">
									<span>${together.age}대이상</span>
								</c:if>
								<!-- 날짜 (형식 바꿔야함) -->
								<p>${together.dateTime}</p>
							</div>
						</div>
					</td>
					<c:if test="${vs.index % 2 == 1}">
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>