<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="동네생활" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/local/local.css" >
<script src="https://kit.fontawesome.com/b4f3d66551.js" crossorigin="anonymous"></script>

</head>
<body>
<div class="local-explain">
	<div class="local-explain-text">
		<div>
			<h1>
				<span style="color: green;">오</span>늘 <br> 우리 <span style="color: green;">이</span>웃은 뭐하고 있을까?
			</h1>
			<br>
			<span>지금 바로 동네생활에서 공유하고 우리 이웃은 뭐하고 있을지 둘러보세요!</span>
		</div>
		<div class="local-explain-img">
			<img alt="" src="${pageContext.request.contextPath}/resources/images/local-neighborhood.png">
		</div>
	</div>
</div>
<!-- 내동네 가져오기 -->
	<div class="relatviedong">
		<div class="search">
			<span id="mydong"></span>
			<!-- 검색창 -->
			<form:form action="" id="keywordFrm" name="keywordFrm" style="display:inline" method="get">
			<input type="text" id="searchKeyword" name="searchKeyword" placeholder="내 동네 근처에서 검색" value="${searchKeyword}">
			<!-- 검색 버튼 -->
			<button type="submit" class="searchbtn">
				<i style="color: green;" class="fa-solid fa-magnifying-glass fa-2x"></i>
			</button>
			</form:form>
			<!-- 글쓰기 버튼 -->
			<button id="writebtn" class="writebtn">
				<i style="color: green;" class="fa-solid fa-pencil fa-2x"></i>
			</button>
		</div>
	</div>
	<div class="category-list-wrap" >
	<c:forEach items="${localCategory}" var="category">
				<ul class="category-list" data-category-num="${category.CATEGORY_NO}">
					<li id="localcate">${category.CATEGORY_NAME}</li>
				</ul>
	</c:forEach>
	</div>
	<div class="local-wrqp">
	<c:set var="category" value="${localCategory}" scope="page"/>
	<c:if test="${not empty localList}">
	<table>
		<tbody id="localList">
			<c:forEach items="${localList}" var="local" varStatus="vs">
				<c:if test="${vs.index % 1 == 0}">
					<tr class="local-tr">
				</c:if>	 
		 		<td class="local-list" data-no="${local.no}" data-category="${category[local.categoryNo - 1].CATEGORY_NAME}">
						<div class="atimg">
						<c:if test="${local.attachments[0].reFilename != null}">
						    <a>
						    	<span><img id="localimg"   
								    src="${pageContext.request.contextPath}/resources/upload/local/${local.attachments[0].reFilename}"/></span>
						    </a>
					    	
						</c:if>
						</div>
					<div class="local-content">
					<div class="local-title">
						<span class="localTitle">${local.title}</span>
					</div>
					<div class="local-footer">
						<span class="local-category">${category[local.categoryNo - 1].CATEGORY_NAME}</span>
						&nbsp;
						<span class="local-dong">${local.dong.dongName}</span>
						&nbsp;
						<!-- 시간오류 수정하기 -->
						<fmt:parseDate value="${local.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate"/>
						<fmt:formatDate value="${regDate}" pattern="MM.dd HH:mm"/>
					</div>
					</div>
				</td>
				<c:if test="${vs.index %1== 1}">
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	</c:if>
	<c:if test="${empty localList}">
			<div class="empty-box">
				<p>해당 게시글은 아직 등록이 안되었어요😥 </p>
			</div>
		
	</c:if>
	</div>
	

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

document.querySelectorAll(".category-list").forEach((category) => {
	category.addEventListener('click', (e) => {
		const no = category.dataset.categoryNum;
		console.log(no);
		
		location.href='${pageContext.request.contextPath}/local/localList.do?categoryNo=' + no ;
	});
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
		location.href='${pageContext.request.contextPath}/local/localDetail.do?&no=' + no;
	});
});
</script>


<script>
window.addEventListener('load', () => {
	const mydong = document.querySelector("#mydong");
	
	$.ajax({
		url : `${pageContext.request.contextPath}/local/getDongDong.do`,
		method : 'get',
		dataType : 'json',
		data : { dongNo : '<sec:authentication property="principal.dongNo" />'},
		success(data){
			mydong.innerHTML =   data.dongName  ;
		},
		error : console.log
	});
});
</script>

<script>
//검색 버튼 클릭 시 이벤트 핸들러
document.querySelector(".searchbtn").addEventListener('click', (e) => {
    const searchKeyword = document.querySelector("#searchKeyword").value;
    console.log(searchKeyword);

    const blank_pattern = /^\s+|\s+$/g;
    if (searchKeyword.replace(blank_pattern, '') == "") {
        alert("검색어를 입력해주세요!");
        document.querySelector("#searchKeyword").select();
        e.preventDefault();
        return false;
    }

    else if (searchKeyword != null && searchKeyword != "") {
        location.href = "${pageContext.request.contextPath}/local/localLists.do?searchKeyword=" + searchKeyword;
    }
});

// 검색 결과 페이지에서 타이틀 강조 표시
const searchKeyword = new URLSearchParams(window.location.search).get('searchKeyword');
const highlightedTitle = "<strong><span class='highlighted'>" + searchKeyword + "</span></strong>";
const titles = document.querySelectorAll('.localTitle');
titles.forEach(title => {
    if (title.innerText.includes(searchKeyword)) {
        title.innerHTML = title.innerHTML.replace(new RegExp(searchKeyword, 'g'), highlightedTitle);
    }
});





</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>