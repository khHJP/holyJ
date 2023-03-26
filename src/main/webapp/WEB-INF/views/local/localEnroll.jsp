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
				<select class="form-select" id="category-select" aria-label="Default select example">
				  <option selected>카테고리</option>
				  	<c:forEach items="${localCategory}" var="category">
				  		<option data-no="${category.categoryNo}" value="${category.CATEGORY_NO}">${category.CATEGORY_NAME} </option>
				  	</c:forEach>
				</select>
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

document.querySelectorAll("option[data-no]").forEach( (option)=>{
	option.addEventListener('click', (e) => {
		
		const no = option.dataset.no;
		console.log( "no",no );
		
		const optionValue = option.value;
		console.log("optionValue", optionValue);
	});
});


//유효성 검사
document.localEnrollFrm.onsubmit = (e) => {
	console.log ( e );
	
	const title = e.target.title;
	const content = e.target.content;
	
	if( !/^.+$/.test(title.value)){
		alert("제목을 작성해주세요");
		title.select();
		return false;
	}
	
	if(!/^.|\n+$/.test(content.value)){
		alert("내용을 작성해주세요");
		content.select();
		return false;
	}
}

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
