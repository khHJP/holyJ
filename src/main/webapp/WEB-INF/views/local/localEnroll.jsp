<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="동네생활" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/local.css" >
</head>
<h2>동네생활 글쓰기</h2>
<div id="localEnrollConatainer">
	<form id="localEnrollFrm" method="post" enctype="multipart/form-data" name="localEnrollFrm">
	<input type="hidden" class="form-control"  required>
		<table>
		<!-- 혜진님 코드론 잘 가져와짐 ,, 드롭다운 나는 어떻게 하지! 공부 필요 ! -->
			<tr>
				<th style="max-width : 100px;" ><label for="category"> 카테고리 </label></th>
				<td style="max-width:650px;">
				<c:forEach items="${localCategory}" var="category"> 	
					<input type="radio" id="categoryNo" name="categoryNo" value="${category.CATEGORY_NO}" data-no="${category.CATEGORY_NO}" style="margin-left: 12px"> <label for="categoryNo">${category.CATEGORY_NAME}</label> 
				</c:forEach>
				</td>
			</tr>
			<tr>
				<td><input type="text" class="localTitle" placeholder="제목" name="title" id="title" required></td>
			</tr>
			<tr>
				<th>
					<textarea class="localContent" name="content" id="content" placeholder="내용" required="required"></textarea>
				</th>
			</tr>	
		</table>
		
		<input type="button" class="cancelbtn" value="취소" onclick="history.go(-1)">
		<input type="submit" class="submitbtn" value="등록">
	</form>
</div>
<script>
//카테고리
document.querySelectorAll("input[data-no]").forEach( (input)=>{
	
	input.addEventListener('click', (e) => {
		
		const no = input.dataset.no;
		console.log( "no", no );

		const optionValue = input.value;
		console.log( "inputValue", inputValue );	
				
	})
})

//유효성 검사

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
