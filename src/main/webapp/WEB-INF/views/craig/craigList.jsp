<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<style>
	dl, ol, ul { text-align: center; margin-top: 5px; margin-bottom: 0;}
	a { text-decoration:none !important }
	a:hover { text-decoration:none !important }
	.notice-wrap, .non-login {margin-top: 5px;}
	button, input, optgroup, select, textarea { margin: 0; font-family: 'Arial', sans-serif; font-size: 14px; font-weight: 600; }
	
	
	.dropdown-toggle:hover{ color: black; background-color: white; -webkit-appearance:none; }
	
	#writeCraigbtn{
		height:36px; width: 80px; 
		background-color: white; 
		color:black; 
		border-color: lightgray; 
		top:-1px; position: relative; left:10px;  
	}
	#writeCraigbtn:hover { border-color:  #28a745; }
	
	#memberInfo{
		width: 120px;
		border:1px solid lightgray;
		position: relative;
		left: 420px;
		top:71px;
		height: 50px;
		padding: 8px;
		border-radius: 5px 5px 5px 5px;
		
	}
	
	#craigWholeListTbl{
		margin: auto;
		margin-top : 50px;
		padding: 40px;
/** border: 1px solid black; **/
		border: none;
		width : 700px;	
	}
	
	.explains{
		margin-bottom: 50px;
		width : 240px;
		margin: auto;
	}
	
	#eachimg{
		border-radius: 15px 15px 15px 15px; 
		margin-bottom: 15px;
	}
	
	.page-link{
		color: green;
	}
	
	.pne{
		margin: 0 auto;
	}
	
	.pagination{
	
	text-align: center;
	justify-content: center;
	}
</style>
<%-- 해야되는거 - 사진뽑기 / read카운트 처리 / 페이징 --%>
	 <span id="memberInfo" ></span>
	 
	   <div class="searchdiv" style="position: relative; top: 38px; left: 550px; ">
	      <input type="text" class="searchTerm" placeholder=" 검색어를 입력해주세요 ">
	      <button type="submit" class="searchButton">
	        <i class="fa fa-search"></i>
	     </button>
       	 <button id="writeCraigbtn"  class="btn btn-success " style=""> 글쓰기</button>
	   </div>

	   <div class="btn-group">
		  <button type="button" style="width:160px; margin-left: 250px; appearance:none; " class="btn btn-success dropdown-toggle"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    중고거래 카테고리
		  </button>
		  <ul class="dropdown-menu">
		  <c:forEach items="${craigCategory}" var="category">
		    <li data-no="${category.no}"><a class="dropdown-item" href="#">${category.CATEGORY_NAME}</a></li>
	   	  </c:forEach>
		  </ul>
		</div>
		<!-- whole List  -->
		<h3 style="margin-top: 30px; text-align: center;">중고거래 인기매물</h3>
		
		<table id="craigWholeListTbl">
		<tbody>
		<c:forEach items="${craigList}" var="craig" varStatus="vs">
			<c:if test="${vs.index%4==0}">
				<tr data-no="${craig.no}" style="padding-bottom : 30px; margin-bottom : 30px; ">
			</c:if>
				  <td class="crnotd" data-crno="${craig.no}" style="width:200px; height: 350px; padding: 10px">
					<div class="explains">
						<div>
						<%-- 예약중 / 판매완료만꺼내기	<p id="crtitle">${craig.state}</p> --%>
						<c:if test="${craig.attachments[0].reFilename != null}">
						    <a><img id="eachimg"  style="display : inline-block; height : 200px; width:200px; " 
								    src="${pageContext.request.contextPath}/resources/upload/craig/${craig.attachments[0].reFilename}"/></a><br/>
						</c:if>
						<c:if test="${craig.attachments[0].reFilename==null}">
						    <a><img id="eachimg"  style="display : inline-block; height : 200px; width:200px;" 
								    src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/></a><br/>
						</c:if>
							<p id="crtitle" class="crpp">${craig.title}</p>
						<c:if test="${craig.price > 0}">
							<p id="crprice" class="crpp"> <fmt:formatNumber pattern="#,###" value="${craig.price}" />원</p>
						</c:if>
						<c:if test="${craig.price == 0 && craig.categoryNo != 7 }">
							<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; font-size: 14px;">나눔💚</p>
						</c:if>
							<p id="crdong" class="crpp">${craig.dong.dongName}</p> <span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish"></span>  <span id="crchat" class="crwishchat"> | 채팅</span><span id="crchat"></span> 
							</div>
						</div>
					</td>
		<c:if test="${vs.index %4==3}">
			</tr>
		</c:if>
		</c:forEach>
		</tbody>
		</table><br><br><br>

		<nav aria-label="Page navigation example pne">
		  <ul class="pagination">
		    <li class="page-item">
		      <a class="page-link" href="#" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		        <span class="sr-only">Previous</span>
		      </a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    <li class="page-item">
		      <a class="page-link" href="#" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		        <span class="sr-only">Next</span>
		      </a>
		    </li>
		  </ul>
		</nav>


<script>
document.querySelectorAll("span[data-no]").forEach( (tr)=>{
	tr.addEventListener('click', (e) => {
		console.log(e.target);
		console.log( tr );
		
		const no = tr.dataset.no;
		console.log( no );
	})
})

//category
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

<script>
document.querySelectorAll("td[data-crno]").forEach( (td)=>{
	td.addEventListener('click', (e) => {
		console.log(e.target);
		console.log( td );
		
		const crno = td.dataset.crno;
		console.log( crno );
		location.href = "${pageContext.request.contextPath}/craig/craigDetail.do?no="+crno;
		
	})
})

</script>


<script>
window.addEventListener('load', () => {
	
	const memberInfo = document.querySelector("#memberInfo");
	
	$.ajax({
		url : `${pageContext.request.contextPath}/craig/getMyCraigDong.do`,
		method : 'get',
		dataType : 'json',
		data : { dongNo : '<sec:authentication property="principal.dongNo" />'},
		success(data){
			memberInfo.innerHTML =   data.dongName  ;
		},
		error : console.log
	});
	
});

</script>

<br><br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>