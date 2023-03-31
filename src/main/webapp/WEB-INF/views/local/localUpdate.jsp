<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="동네생활" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/local/localEnroll.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<div id="localEnrollConatainer">
<form id="localUpdateFrm" method="post" enctype="multipart/form-data" name="localUpdateFrm"
		action="${pageContext.request.contextPath}/local/localUpdate.do?${_csrf.parameterName}=${_csrf.token}">
	<sec:authentication property="principal" var="loginMember"/>
	<input type="hidden" class="form-control" name="writer" id="writer" value="${loginMember.memberId}"  required>
		<!--부트스트랩 쓸 것-->
			<!-- 카테고리 -->
			<div class="category-box">
			 	<table>
				<tr>
				<th ><label for="category"> 카테고리 </label></th>
				<td style="text-align: center;">
				<c:forEach items="${localCategory}" var="category"> 	
					<input type="radio" id="categoryNo" name="categoryNo" value="${category.CATEGORY_NO}" data-no="${category.CATEGORY_NO}"
					${localdetail.categoryNo eq category.CATEGORY_NO ? 'checked' : ''}> <label for="categoryNo">${category.CATEGORY_NAME}</label> 
				</c:forEach>
				</td>
			</tr>
			</table>
			 
			</div>
			<hr>
			<div class="title-box">
				<input type="text" class="localTitle" placeholder="제목" name="title" id="title" value="${localdetail.title}" required><hr>
				<textarea class="localContent" name="content" id="content" placeholder="내용" required="required">${localdetail.content}</textarea>
				<hr>
			</div>
		
			<input type="file" name="upFile" id="upFile1">	 
		 <hr>
		<div style="display:inline-block; margin: 0 30px;  float: right;">
		<input type="button" class="cancelbtn" value="취소" onclick="history.go(-1)">
		<input type="submit" class="submitbtn" value="수정">
		</div>
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
});

//유효성검사 
document.localUpdateFrm.onsubmit = (e) =>{
	console.log ( e );

	const title = e.target.title; 
	const content  = e.target.content;

	
	
	//제목 작성하지 않은경우 
	if( !/^.+$/.test(title.value)){
		alert("제목을 작성해주세요!");
		title.select();
		return false;
	}
	
	//내용 없는경우
	if(!/^.|\n+$/.test(content.value)){
		alert("내용을 작성해주세요!");
		content.select();
		return false;
	}
	
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>