<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="동네생활" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/local/localDetail.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginMember"/>
<div class="localboard-container">
	<div class="localboard-wrap">
	<!-- 카테고리 넣어라 -->
		<div class="memberInfo">
		<div>
			<span>${localdetail.categoryNo}</span>
		</div>
			<div class="profileimg">
				<img src="${pageContext.request.contextPath}/resources/upload/profile/${localdetail.member.profileImg}" alt="사용자프로필">
			</div>
			<div class="detailInfo">
				<p>${localdetail.member.nickname}</p>
				<span>${localdetail.dong.dongName}</span>
				&nbsp;
				<fmt:parseDate value="${localdetail.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate"/>
					<fmt:formatDate value="${regDate}" pattern="MM.dd HH:mm"/>
			</div>
		</div>
			<div>
				<h4>${localdetail.title}</h4>
			</div>
			<div>
				<p>${localdetail.content }</p>
			</div>
			<div>
				<c:if test="${localdetail.attachments[0].reFilename!=null}">
						    <a><img id="eachimg"  style="display : inline-block; height : 200px; width:200px;" 
								    src="${pageContext.request.contextPath}/resources/upload/local/${localdetail.attachments[0].reFilename}"/></a><br/>
						</c:if>
			</div>
		
	</div>
</div>



















<jsp:include page="/WEB-INF/views/common/footer.jsp"/>