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
</head>
<div id="localEnrollConatainer">
	<form id="localEnrollFrm" method="post" enctype="multipart/form-data" name="localEnrollFrm"
		action="${pageContext.request.contextPath}/local/localBoardEnroll.do?${_csrf.parameterName}=${_csrf.token}">
	<sec:authentication property="principal" var="loginMember"/>
	<input type="hidden" class="form-control" name="writer" id="writer" value="${loginMember.memberId}"  required>
		<!--부트스트랩 쓸 것-->
			<!-- 카테고리 -->
			<div class="category-box">
			 	<table>
				<tr>
				<th style="max-width : 100px;" ><label for="category"> 카테고리 </label></th>
				<td style="max-width:650px; text-align: left">
				<c:forEach items="${localCategory}" var="category"> 	
					<input type="radio" id="categoryNo" name="categoryNo" value="${category.CATEGORY_NO}" data-no="${category.CATEGORY_NO}"> <label for="categoryNo">${category.CATEGORY_NAME}</label> 
				</c:forEach>
				</td>
			</tr>
			</table>
			 
			<!--  
			<select class="category-select" aria-label="Default select example">
				<!--  <option selected> 카테고리 </option> -->
				<c:forEach items="${localCategory}" var="category">
					<option value="${category.CATEGORY_NO}" data-no="${category.CATEGORY_NO}">${category.CATEGORY_NAME}</option>
				</c:forEach>
			</select>
			--> 
			
			
			
			</div>
			<hr>
			<div class="title-box">
				<input type="text" class="localTitle" placeholder="제목" name="title" id="title" required><hr>
				<textarea class="localContent" name="content" id="content" placeholder="내용" required="required"></textarea>
				<hr>
			</div>
		<!-- 첨부파일 미리보기 외 않되? -->	
			<input type="file" name="upFile" id="upFile1" multiple>	 
		 <hr>
		<div style="display:inline-block; margin: 0 30px;  float: right;">
		<input type="button" class="cancelbtn" value="취소" onclick="history.go(-1)">
		<input type="submit" class="submitbtn" value="등록">
		</div>
	</form>
</div>
<script>


//카테고리
document.querySelectorAll("input[data-no]").forEach( (input)=>{
	
	option.addEventListener('click', (e) => {
		
		const no = input.dataset.no;
		console.log( "no", no );

		const optionValue = input.value;
		console.log( "inputValue", inputValue );

	})
});

//유효성검사 
document.craigEnrollFrm.onsubmit = (e) =>{
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


<script>
//첨부파일
document.querySelector("#upFile1").addEventListener('change', (e) => {
	const img = e.target;
	
	if(img.files[0]){
		const reader = new FileReader(); 
		reader.readAsDataURL(img.files[0]); 
		reader.onload = (e) => {
			document.querySelector("img_viewer").src = e.target.result; 
		};	

	else {
		 파일 선택 취소
		document.querySelector("img_viewer").src = "";
	};
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
