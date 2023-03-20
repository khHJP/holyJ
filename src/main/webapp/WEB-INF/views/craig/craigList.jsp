<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="title"/>
</jsp:include>
<style>
dl, ol, ul {
    text-align: center;
    margin-top: 5px;
    margin-bottom: 0;
}
a { text-decoration:none !important }
a:hover { text-decoration:none !important }

.notice-wrap, .non-login {margin-top: 5px;}

button, input, optgroup, select, textarea {
    margin: 0;
    font-family: 'Arial', sans-serif;
    font-size: 14px;
    font-weight: 600;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig.css" >
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
 -->

	   <div class="searchdiv" style="position: relative; top: 38px; max-width:900px; left: 480px !important; ">
	      <input type="text" class="searchTerm" placeholder=" 검색어를 입력해주세요 ">
	      <button type="submit" class="searchButton">
	        <i class="fa fa-search"></i>
	     </button>
       	 <button id="writeCraigbtn"  class="btn btn-success" style="height:35px; background-color: white; color:black; border-color:black; top:0px; position: relative; left:20px;  ">+ 글쓰기</button>
	   </div>
	   <table id="tblcate">
		   <tr  style="height:100px;" >
		   		<th style="height:45px; width:190px; text-align:left; font-size: 21px; background-color: white; color:black" id="btct" >중고거래 카테고리</th>
		   </tr>
		   
		   <c:forEach items="${craigCategory}" var="category"> 	
	 		<tr data-no="${category.no}" style="height:50px;">
	 			<td style="height:30px">${category.CATEGORY_NAME}</td>
	 		</tr>
		    </c:forEach>
	   </table>
<%-- 	<table>
		<c:forEach items="${craigList}" var="craig">
			<td>${craig.no}</td>
			<td>${craig.title}</td>
			<td>${craig.writer}</td>
		</c:forEach>
	</table> --%>




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
<br><br><br><br><br><br><br><br><br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>