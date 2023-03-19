<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="동네생활" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/local.css" >
<script src="https://kit.fontawesome.com/b4f3d66551.js" crossorigin="anonymous"></script>
</head>
<body>

	<div class="wrap">
		<div class="search">
			<input type="text" class="localsearch" placeholder="내 동네 근처에서 검색">
			<!-- 검색 버튼 -->
			<button type="submit" class="searchbtn">
				<i style="color: green;" class="fa-solid fa-magnifying-glass fa-2x"></i>
			</button>
			<!-- 글쓰기 버튼 -->
			<button class="writebtn">
				<i style="color: green;" class="fa-solid fa-pencil fa-2x"></i>
			</button>
		</div>
	</div>
	<div class="nav-category-container">
				<ul class="category-list">
					<li id="localcate">동네질문</li>
					<li id="localcate">동네소식</li>
					<li id="localcate">분실/실종센터</li>
					<li id="localcate">해주세요</li>
				</ul>
			</div>
	<table id="localList" >
		<tbody>
		<c:forEach items="${localList}" var="localall"> 	
	 		<tr data-no="${localall.no}">
	 			<td th:inline="text" style="padding-left:250px;" id="localList">${localall.title} <br>${localall.categoryNo}${localall.writer}
	 			<fmt:parseDate value="${localall.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate"/>
					<fmt:formatDate value="${regDate}" pattern="yy-MM-dd HH:mm"/><br></td>
	 		</tr>
	 	 </c:forEach>	
	 	</tbody>
	</table>
	

</body>
<script>
document.querySelectorAll("tr[data-no]").forEach( (tr)=>{
	tr.addEventListener('click', (e) => {
		console.log(e.target,tr);
		
		const no = tr.dataset.no;
		console.log( no );
	})
})

document.querySelector("#writebtn").addEventListener('click', (e) => {
			location.href = `${pageContext.request.contextPath}/local/localEnroll.do`;

});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>