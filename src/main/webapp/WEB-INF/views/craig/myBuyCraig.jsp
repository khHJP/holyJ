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
		<table id="tbl-board" class="table">
			<c:forEach items="${myBuyCraig}" var="buy">
					 <tr data-no="${buy.no}" id="tr-table">
				 		<td>
							<c:if test="${buy.attachments[0].reFilename != null}">
							   <img id="img" src="${pageContext.request.contextPath}/resources/upload/craig/${buy.attachments[0].reFilename}"/>
							</c:if>
							<c:if test="${buy.attachments[0].reFilename==null}">
							    <img id="img" src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/>
							</c:if> 
						</td>
							<td class="span1" id="buyTitle">${buy.title}</td>
							<td class="span1" id="buyPlace">${buy.placeDetail}</td>
							<td class="span1" id="buyCom">거래완료</td>						
							<td class="span1" id="buyPrice">${buy.price}</td>
						</tr>
						<td id="hogi">보낸 후기 보기</td>
			</c:forEach>
		</table>
	</section> 
	</div>
<script>
document.querySelectorAll("tr[data-no]").forEach((tr) => {
	tr.addEventListener('click', (e) => {
		// console.log(e.target, tr);
		const no = tr.dataset.no;
		console.log(no);
	
	location.href = '${pageContext.request.contextPath}/craig/craigDetail.do?no=' + no;
	});
});		
		
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>