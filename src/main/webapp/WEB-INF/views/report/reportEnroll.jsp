<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/report/reportEnroll.css" />
<div class="report-container">
	<div class="report-wrap">
		<div class="title-box">
			<h2>신고 접수</h2>
			<span>신고 사유를 선택해주세요.</span>
		</div>
		<div class="frm-container">
			<form:form name="boardReportFrm" class="report-box" method="POST"
					   action="${pageContext.request.contextPath}/report/boardReportEnroll.do">
				<div class="report-type">
					<p>게시글 신고</p>
				</div>
				<c:forEach items="${reasonList}" var="reason" varStatus="vs">
					<c:if test="${reason.reportType ne 'US'}">
						<div class="form-check">
							<input type="checkbox" name="reasonNo" class="form-check-input" id="${reason.reportType}${vs.count}" 
								   value="${reason.reasonNo}" data-report-type="${reason.reportType}" onclick='checkOnlyOne(this)'>
							<label class="form-check-label" for="${reason.reportType}${vs.count}">${reason.reasonName}</label>
						</div>
					</c:if>
				</c:forEach>
				<input type="hidden" name="reportType" value="${info.reportType}">
				<input type="hidden" name="reportPostNo" value="${info.boardNo}">
				<sec:authentication property="principal" var="loginMember"/>
				<input type="hidden" name="writer" value="${loginMember.memberId}">
			</form:form>
			<form:form name="userReportFrm" class="report-box" method="POST"
					   action="${pageContext.request.contextPath}/report/userReportEnroll.do">
				<div class="report-type">
					<p>사용자 신고</p>
				</div>
				<c:forEach items="${reasonList}" var="reason" varStatus="vs">
					<c:if test="${reason.reportType eq 'US'}">
						<div class="form-check">
							<input type="checkbox" name="reasonNo" class="form-check-input" id="${reason.reportType}${vs.count}" 
								   value="${reason.reasonNo}" data-report-type="${reason.reportType}" onclick='checkOnlyOne(this)'>
							<label class="form-check-label" for="${reason.reportType}${vs.count}">${reason.reasonName}</label>
						</div>
					</c:if>
				</c:forEach>
				<input type="hidden" name="writer" value="${loginMember.memberId}">
				<input type="hidden" name="reportedMember" value="${info.reportedId}">
				<input type="hidden" name="reportType" value="${info.reportType}">
				<input type="hidden" name="reportPostNo" value="${info.boardNo}">
			</form:form>
		</div>
	</div>
	<div class="btn-box">
		<button class="btn" onclick="history.go(-1)">취소</button>
		<button class="btn report-btn">신고</button>
	</div>
</div>
<script>
/* 체크박스 제어 */
const checkOnlyOne = (element) => {
  
  const checkboxes = document.getElementsByName("reasonNo");
  
  checkboxes.forEach((cb) => {
    cb.checked = false;
  })
  
  element.checked = true;
};

/* 유효성 검사 */
document.querySelector(".report-btn").addEventListener('click', (e) => {
	
	const reportTypes = document.querySelectorAll("[name=reasonNo]");
	let type;
	
	reportTypes.forEach((reportType) => {
		if(reportType.checked == true){
			type = reportType.dataset.reportType;
		}
	});
	
	if(type == null){
		alert("사유를 선택해주세요.");
		return false;
	}
	else if (type != 'US'){
		if(confirm('신고하시겠습니까?'))
			document.boardReportFrm.submit();
	}
	else if (type == 'US'){
		if(confirm('신고하시겠습니까?'))
			document.userReportFrm.submit();
		
	}
	
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>