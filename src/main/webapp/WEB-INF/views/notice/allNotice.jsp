<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice/notice.css" />

<div>
	<table>
		<c:forEach items="${adminNoticeList}" var="adminNotice"
			varStatus="vs">
			<tr id="table-content">
				<td>${vs.count}</td>
				<td>${adminNotice.msg}</td>
				<td>
					<fmt:parseDate value="${adminNotice.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="regDate" /> 
					<fmt:formatDate value='${regDate}' pattern="yyyy.MM.dd HH:mm" />
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
	
<script>

</script>