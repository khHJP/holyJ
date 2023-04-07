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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig/myWishCraig.css" />

</head>
<body>
<br /><br />
	<div class="buy-container">
		<h1 class="sub_title">관심목록</h1>
		<br />
	
	<section id="board-container" class="container">
		<table id="tbl-board" class="table ul-hover">
		<c:choose>
			<c:when test="${not empty myWishCraig}">
				<c:forEach items="${myWishCraig}" var="wish">
						 <ul data-no="${wish.no}" id="ul-table">
					 		<li id="li-img">
								<c:if test="${wish.attachments[0].reFilename != null}">
								   <img id="img" src="${pageContext.request.contextPath}/resources/upload/craig/${wish.attachments[0].reFilename}"/>
								</c:if>
								<c:if test="${wish.attachments[0].reFilename==null}">
								    <img id="img" src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/>
								</c:if> 
							</li>
							<ul id="ul-title">
								<li class="span1" id="buyTitle">${wish.title}<img id="heart"src="${pageContext.request.contextPath}/resources/images/heart_red.png" alt=""/></li>									
								<li class="span1" id="buyPlace">${wish.placeDetail}</li>
								<c:if test="${wish.price ne '0'}">														
									<li class="span1" id="buyPrice">
									<fmt:formatNumber value="${wish.price}" pattern="#,###" />원</li>
								</c:if>
								<c:if test="${wish.price eq '0'}">					
									<li class="span1" id="buyPrice">나눔💚<li>
								</c:if>
							</ul>
							</ul>
							<hr id="hogi-hr"/>
				</c:forEach>
			</c:when>
				<c:otherwise>
					<div id="empty">
						<img src="${pageContext.request.contextPath}/resources/images/오이.png" alt="" id="emptyimg"/>
					옹잉?? 관심목록이 없어용!!</div>
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