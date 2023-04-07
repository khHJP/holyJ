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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig/mySalCraig.css" />

</head>
<body>
<br /><br />
	<section id="board-container" class="container">
		<table id="tbl-board" class="table ul-hover">
		<c:choose>
			<c:when test="${not empty mySalCraig}">
	<div class="craig-container">
			<h1 class="sub_title">${mySalCraig[0].member.nickname}님의 판매내역</h1>
		<br />
		<div>
			<ul class="craig-ul">
				<li><a id="craig-li" class="bold" href="${pageContext.request.contextPath}/craig/mySalCraig1.do">판매중</a></li>
			</ul>
		</div>
				<c:forEach items="${mySalCraig}" var="sal">
						 <ul data-no="${sal.no}" id="ul-table">
					 		<li id="li-img">
								<c:if test="${sal.attachments[0].reFilename != null}">
								   <img id="img" src="${pageContext.request.contextPath}/resources/upload/craig/${sal.attachments[0].reFilename}"/>
								</c:if>
								<c:if test="${sal.attachments[0].reFilename==null}">
								    <img id="img" src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/>
								</c:if> 
							</li>
							<ul id="ul-title">
								<li class="span1" id="buyTitle">${sal.title}</li>
								<li class="span1" id="buyPlace">${sal.placeDetail}</li>
								<ul id="ul-price">
									<c:if test="${sal.state eq 'CR2'}">
										<li class="span1" id="buyCom">판매중</li>	
									</c:if>
									<c:if test="${sal.state eq 'CR1'}">
										<li class="span1" id="buyCom">예약중</li>	
									</c:if>
									<c:if test="${sal.price ne '0'}">														
										<li class="span1" id="buyPrice">
										<fmt:formatNumber value="${sal.price}" pattern="#,###" />원</li>
									</c:if>
									<c:if test="${sal.price eq '0'}">					
										<li class="span1" id="buyPrice">나눔💚<li>
									</c:if>
								</ul>
							</ul>
							</ul>
							<hr id="hogi-hr"/>
				</c:forEach>
			</c:when>
				<c:otherwise>
				</div>
					<div id="empty">
						<img src="${pageContext.request.contextPath}/resources/images/오이.png" alt="" id="emptyimg"/>
					옹잉?? 판매중인 내역이 없어용!!</div>
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