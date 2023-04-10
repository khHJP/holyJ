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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/manner/myManner.css" />

</head>
<body>
<br /><br />
	<div class="manner-container">
		<h1 class="sub_title">${takeMannerList[0].member.nickname}님이 보내신 매너평가</h1>
		<hr />
			<table id="tbl-board" class="table">
				<div class="manner-ti">
					<img src="${pageContext.request.contextPath}/resources/images/smile.png" alt="" id="smile"/>
					<span class="manner-sub">받은 매너 칭찬</span>
				</div>
				<c:forEach items="${takeMannerList}" var="manner">
					 <tr data-no="${manner.mannerNo}" name="no" id="tr-table">
						<c:if test="${manner.prefer eq 'MA2'}">
								<div class="span1" id="like">좋아요
										<hr />
								</div>
						</c:if>
						<c:if test="${manner.prefer eq 'MA3'}">
								<div class="span1" id="like">최고에요
										<hr />
								</div>
						</c:if>
						
						<c:choose>
							<c:when test="${manner.compliment eq 'COM1'}">
									<div class="span1" id="like">제가 있는 곳까지 와서 거래했어요.
											<hr />
									</div>
							</c:when>
							<c:when test="${manner.compliment eq 'COM2'}">
									<div class="span1" id="like">응답이 빨라요
											<hr />
									</div>
							</c:when>
							<c:when test="${manner.compliment eq 'COM3'}">
									<div class="span1" id="like">친절하고 매너가 좋아요.
											<hr />
									</div>
							</c:when>
							<c:when test="${manner.compliment eq 'COM4'}">
									<div class="span1" id="like">시간 약속을 잘 지켜요.
											<hr />
									</div>
							</c:when>
					</c:choose>
					</tr>								
				</c:forEach>
			</table>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>