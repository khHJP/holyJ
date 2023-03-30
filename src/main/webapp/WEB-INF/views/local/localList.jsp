<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="동네생활" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/local/local.css" >
<script src="https://kit.fontawesome.com/b4f3d66551.js" crossorigin="anonymous"></script>
</head>
<body>
<!-- 내동네 가져오기 -->
		<div class="search">
			<span class="mydong">도곡2동</span> <!-- 임시(dujun74 기준) -->
			<input type="text" class="localsearch" placeholder="내 동네 근처에서 검색">
			<!-- 검색 버튼 -->
			<button type="submit" class="searchbtn">
				<i style="color: green;" class="fa-solid fa-magnifying-glass fa-2x"></i>
			</button>
			<!-- 글쓰기 버튼 -->
			<button id="writebtn" class="writebtn">
				<i style="color: green;" class="fa-solid fa-pencil fa-2x"></i>
			</button>
		</div>
	</div>
	<div class="category-list-wrap">
	<c:forEach items="${localCategory}" var="category">
				<ul class="category-list">
					<li id="localcate">${category.CATEGORY_NAME}</li>
				</ul>
	</c:forEach>
	</div>
	<table>
	<c:set var="category" value="${localCategory}" scope="page"/>
		<tbody>
			<c:forEach items="${localList}" var="local" varStatus="vs">
			<c:if test="${vs.index % 1 ==0}">
				<tr class="local-tr">
			</c:if>	 
				<td class="local-list" data-no="${local.no}" data-category="${category[local.categoryNo - 1].CATEGORY_NAME}">
			
			<div class="local-title">
				<span>${local.title}</span>
			</div>
			<div class="local-footer">
				<span class="local-category">${category[local.categoryNo - 1].CATEGORY_NAME}</span>
				&nbsp;
				<span class="local-dong">${local.dong.dongName}</span>
				&nbsp;
				<fmt:parseDate value="${local.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate"/>
					<fmt:formatDate value="${regDate}" pattern="MM.dd HH:mm"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<c:if test="${local.attachments[0].reFilename != null}">
						    <a><img id="localimg"  style="display : inline-block; height : 40px; width:40px; " 
								    src="${pageContext.request.contextPath}/resources/upload/local/${local.attachments[0].reFilename}"/></a><br/>
						</c:if>
						
			</div>
			</td>
			<c:if test="${vs.index %1== 1}">
						</tr>
			</c:if>
			</c:forEach>
		</tbody>
	</table>
	

</body>
<script>
document.querySelectorAll("tr[data-no]").forEach( (tr)=>{
	tr.addEventListener('click', (e) => {
		console.log(e.target);
		console.log( tr );
		
		const no = tr.dataset.no;
		console.log( no );
	})
})

document.querySelector("#writebtn").addEventListener('click', (e) => {
			location.href = `${pageContext.request.contextPath}/local/localEnroll.do`;

});
</script>
<script>
//상세페이지로 이동
document.querySelectorAll("td[data-no]").forEach( (td) => {
	td.addEventListener('click', (e) => {
		console.log(e.target);
		console.log( td );
		
		const no = td.dataset.no;
		const category = td.dataset.category;
		console.log(no, category);
		location.href='${pageContext.request.contextPath}/local/localDetail.do?category=' + category + "&no=" + no;
	});
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>