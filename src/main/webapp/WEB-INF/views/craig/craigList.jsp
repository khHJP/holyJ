<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig.css" >
<!-- bootstrap js -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">



	<div class="wrap">
	   <div class="search">
	      <input type="text" class="searchTerm" placeholder=" 검색어를 입력해주세요 ">
	      <button type="submit" class="searchButton">
	        <i class="fa fa-search"></i>
	     </button>
       	 <button id="writeCraigbtn" style="height:36px">+ 글쓰기</button>
	   </div>
	</div>
	<table id="tbl-cate-board" >
		<thead>
			<th style="height:50px">중고거래 카테고리</th>
		</thead>
		<tbody>
		<c:forEach items="${craigCategory}" var="category"> 	
	 		<tr data-no="${category.no}">
	 			<td style="height:30px">${category.CATEGORY_NAME}</td>
	 		</tr>
	 	 </c:forEach>	
	 	</tbody>
	</table>

	<table>
		<c:forEach items="${craigList}" var="craig">
			<td>${craig.no}</td>
			<td>${craig.title}</td>
			<td>${craig.writer}</td>
		</c:forEach>
	</table>
</body>





<script>
//카테고리뽑기
document.querySelectorAll("tr[data-no]").forEach( (tr)=>{
	tr.addEventListener('click', (e) => {
		console.log(e.target);
		console.log( tr );
		
		const no = tr.dataset.no;
		console.log( no );
	})
})

//글쓰기 
document.querySelector("#writeCraigbtn").addEventListener('click', (e) => {
			location.href = `${pageContext.request.contextPath}/craig/craigEnroll.do`;

});

</script>
<br><br><br><br><br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>