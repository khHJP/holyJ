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
	<form id="localEnrollFrm" method="post" enctype="multipart/form-data" name="localEnrollFrm"
	action="${pageContext.request.contextPath}/local/localBoardEnroll.do">
	<input type="hidden" class="form-control"  required>
		<table>
		<!--부트스트랩 쓸 것-->
			<tr>
				<ul class="category-dropdown">
				<c:forEach items="${localCategory}" var="category">
					<li data-no="${category.no}"}><a class="category-item" href="#">${category.CATEGORY_NAME}</a></li>
				</c:forEach>
				</ul>
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
		<hr>
		<!-- 첨부파일 미리보기 찾아보기 -->
		<div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일1</span>
		  </div>
		<div class=custom-file>
			<input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple>
			<label class="custom-file-label" for="upFile1">사진</label>
		</div>
		</div>
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

//첨부파일
document.querySelectorAll("[name=upFile]").forEach((input) => {
	input.addEventListner('change',(e) => {
		const file = e.target.files[0];
		const label = e.target.nextElementSibling;
		
		if(file)
			label.innerHTML = file.name;
		else
			label.innerHTML = '파일을 선택하세요';
		
	});
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
