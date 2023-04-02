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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/myprofile.css" />
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
				<img src="${pageContext.request.contextPath}/resources/upload/profile/<sec:authentication property="principal.profileImg"/>" alt="임시이미지" id="profile">
			</td>
			<td>
				<span id="nickname"><sec:authentication property="principal.nickname"/></span>
			</td>
			<td>
			<c:choose>
				<c:when test="${principal.manner < 30}">
					<span id="tmp1"><sec:authentication property="principal.manner"/></span>
				</c:when>
				<c:when test="${principal.manner > 90}">
					<span id="tmp3"><sec:authentication property="principal.manner"/></span>
				</c:when>
				<c:otherwise>
					<span id="tmp2"><sec:authentication property="principal.manner"/></span>
				</c:otherwise>
			
			</c:choose>
				<%-- <c:if test="${loginMember.manner < 30}"><span id="tmp1"><sec:authentication property="principal.manner"/></span></c:if>
				<c:if test="${loginMember.manner >= 30 && loginMember.manner <= 60}"><span id="tmp2"><sec:authentication property="principal.manner"/></span></c:if>
				<c:if test="${loginMember.manner > 60}"><span id="tmp3"><sec:authentication property="principal.manner"/></span></c:if> --%>
			</td>
			</th>

	</table>
	<br />
	<div id="proupdate">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/pwCheck.do'" id="probut">프로필 수정</button>
	</div>
	<br />
	<div id="proupdate">
		<hr />
		<li id="sala">
		<a href="${pageContext.request.contextPath}/craig/mySalCraig.do">판매 상품</a>
		</li>
		<hr />
		<li id="sala">
		<a href="${pageContext.request.contextPath}/manner/myManner.do">받은매너평가
		</a>
		</li>
		<hr />
	</div>
	
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>