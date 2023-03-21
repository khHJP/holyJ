<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  --%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<style>
	dl, ol, ul { text-align: center; margin-top: 5px; margin-bottom: 0;}
	a { text-decoration:none !important }
	a:hover { text-decoration:none !important }
	.notice-wrap, .non-login {margin-top: 5px;}
	button, input, optgroup, select, textarea { margin: 0; font-family: 'Arial', sans-serif; font-size: 14px; font-weight: 600; }
	
	
	.dropdown-toggle:hover{ color: black; background-color: white; -webkit-appearance:none; }
	
</style>

<h2> 웰컴상세페이지..</h2>





<br><br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>