<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="subtitle"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/updateprofile.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

</head>
<body>
<br />
<br />
	<table>
		<th>
			<td>
				<img src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지" id="profile">
			</td>
			<td>
				<span id="id">아이디</span>
			</td>
		</th>
	</table>
	
	
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>