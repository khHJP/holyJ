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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig/myBuyCraig.css" />

</head>
<body>
<br /><br />
	<div class="buy-container">
		<h1 class="sub_title">구매내역</h1>
		<br />
	
	<section id="board-container" class="container">
		<table id="tbl-board" class="table ul-hover">
		<c:choose>
			<c:when test="${not empty myBuyCraig}">
				<c:forEach items="${myBuyCraig}" var="buy">
						 <ul data-no="${buy.no}" id="ul-table">
					 		<li id="li-img">
								<c:if test="${buy.attachments[0].reFilename != null}">
								   <img id="img" src="${pageContext.request.contextPath}/resources/upload/craig/${buy.attachments[0].reFilename}"/>
								</c:if>
								<c:if test="${buy.attachments[0].reFilename==null}">
								    <img id="img" src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/>
								</c:if> 
							</li>
							<ul id="ul-title">
								<li class="span1" id="buyTitle">${buy.title}</li>
								<li class="span1" id="buyPlace">${buy.placeDetail}</li>
								<ul id="ul-price">
									<li class="span1" id="buyCom">거래완료</li>	
									<c:if test="${buy.price ne '0'}">														
										<li class="span1" id="buyPrice">
										<fmt:formatNumber value="${buy.price}" pattern="#,###" />원</li>
									</c:if>
									<c:if test="${buy.price eq '0'}">					
										<li class="span1" id="buyPrice">나눔💚<li>
									</c:if>
								</ul>
							</ul>
							</ul>
							<hr id="hogi-hr"/>
							<form:form action="${pageContext.request.contextPath}/manner/sendManner.do" method="GET">
							<input type="hidden" name="no" value="${buy.no}"/>
							<ul id="hogi-ul">
								<input id="hogi" type="submit" value="내가 보낸 후기보기"/>
							</ul>
							</form:form>
							<hr id="hogi-hr"/>
				</c:forEach>
			</c:when>
				<c:otherwise>
					<div id="empty">
						<img src="${pageContext.request.contextPath}/resources/images/오이.png" alt="" id="emptyimg"/>
					옹잉?? 구매하신 내역이 없어용!!</div>
				</c:otherwise>
			</c:choose>
		</table>
	</section> 
	</div>
<script>
document.querySelectorAll("#ul-table").forEach((ul) => {
	ul.addEventListener('click', (e) => {
		// console.log(e.target, tr);
		const no = ul.dataset.no;
		console.log(no);
	
	location.href = '${pageContext.request.contextPath}/craig/craigDetail.do?no=' + no;
	});
});		
		
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>