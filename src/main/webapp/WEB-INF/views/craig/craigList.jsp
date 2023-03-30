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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig/craig.css" >
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
		width: 100px;
		border:1px solid lightgray;
		height: 38px;
		padding: 6px;
		padding-bottom : 12px;
		vertical-align :middle;
		border-radius: 5px 5px 5px 5px;
	}
	
	#craigWholeListTbl{
		margin: auto;
		margin-top : 50px;
		padding: 40px;
		border: none;
		width : 700px;	
	}
	
	.explains{ margin-bottom: 50px; width : 240px; margin: auto; }
	
	#eachimg{ border-radius: 15px 15px 15px 15px;  margin-bottom: 15px; }
	
	.page-link{ color: green; }
	
	.pne{ margin: 0 auto; }
	
	.pagination{ text-align: center; justify-content: center; }
	
	#searchToWriteDiv{
		margin: 0 auto; text-align: center;
		display: flex; justify-content: center; margin-left: -110px;
	}
	
	.searchdiv { margin-left: 1px; display: inline-block; width: 760px; }
	
/* header */
.nav-link{ margin-top: -5px }
.profile-wrap{ margin-top: 5px }
.login-box { width: 140px;
    display: flex; align-items: center;
    justify-content: flex-end;  margin-top: -5px ;
}
</style>

<%-- 해야되는거 - read카운트 처리  --%>
<br><br><br>
	<%-- 글쓰기 / 카데고리 --%>
	<div id="searchToWriteDiv">
	   	<div class="btn-group" style="margin: 0; padding-right: 50px">
			<button type="button" style="width:160px; height:36px; appearance:none; " class="btn btn-success dropdown-toggle"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    	중고거래 카테고리
			</button>
		  	<ul class="dropdown-menu">
			  <c:forEach items="${craigCategory}" var="category">
			    <li data-no="${category.CATEGORY_NO}"><a class="dropdown-item" href="#">${category.CATEGORY_NAME}</a></li>
		   	  </c:forEach>
			</ul>
		</div>

		<span id="memberInfo" ></span>
		<%--  검색 --%>		
	    <div class="searchdiv" style=""> <%-- 동일핸들러로 보내보자 --%>
	    	<form:form action=""
	    		 id="keywordFrm" name="keywordFrm" enctype ="multipart/form-data"  style="display:inline" method="get">
		    	<input type="text"  name="searchKeyword" id="searchKeyword" placeholder=" 검색어를 입력해주세요 ">
		    	<button type="submit" class="searchButton"> <i class="fa fa-search"></i> </button>
	     	</form:form>
       	 	<button id="writeCraigbtn"  class="btn btn-success " style=""> 글쓰기</button>
	    </div>
	</div>
<section id="craigWhole" >	
<!-- whole List  -->
	<c:if test="${searchCraigs == null}">
		<h3 style="margin-top: 50px; text-align: center; margin-bottom: 30px">중고거래 인기매물</h3>
	</c:if>
		
	<c:if test="${searchCraigs[0] != null && searchCraigs != '' && searchKeyword != null && searchKeyword != '' }">
		<h3 style="margin: auto; margin-top: 50px; text-align: center;"><span id="searchWord" style="color: green; text-decoration: underline;">${searchKeyword} </span>(으)로 검색한 결과</h3>
	</c:if>
	<c:if test="${searchCraigs[0] == null && searchKeyword != null  }">
		<h3 style="margin: auto; margin-top: 50px; text-align: center;"><span id="searchWord" style="color: green; text-decoration: underline;">${searchKeyword} </span>(으)로 검색한 결과가 없습니다!</h3>
		<img  style="width:700px; height: 600px; margin:70px 0 0 280px " src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png" alt="First slide" >
	</c:if>
	

		<table id="craigWholeListTbl">
			<tbody>
			<c:forEach items="${craigList}" var="craig" varStatus="vs">
				<c:if test="${vs.index%4==0}">
					<tr data-no="${craig.no}" style="padding-bottom : 30px; margin-bottom : 30px; ">
				</c:if>
					  <td class="crnotd" data-crno="${craig.no}" style="width:200px; height: 380px; padding: 10px">
						<div class="explains">
							<div>
							<%-- img --%>
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
								<p id="crprice" class="crpp" style="display: inline-block; font-size:17px; margin-right: 20px;"> <fmt:formatNumber pattern="#,###" value="${craig.price}" />원</p>
							</c:if>
							<%-- CR1 || CR3--%>
							<c:if test="${craig.state == 'CR1'}">
								<span class="badge badge-success" style="height: 22px; font-size: 13px; text-align: center; vertical-align: middle;"> 예약중 </span>
							</c:if>
							<c:if test="${craig.state == 'CR3'}">
								<span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: center; vertical-align: middle;"> 판매완료 </span>
							</c:if>
		
							<c:if test="${craig.price == 0 && craig.categoryNo != 7 }">
								<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; font-size: 17px;">나눔💚</p>
							</c:if>
								<p id="crdong" class="crpp">${craig.dong.dongName}</p> <span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">${wishCnt[vs.index]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat"></span> 

								</div>
							</div>
						</td>
					<c:if test="${vs.index %4==3}">
						</tr>
					</c:if>
				</c:forEach>
			
			
		<%--  ★★★★★ 검색 결과 ★★★★★--%>
		<c:if test="${searchCraigs != null}">
			<c:forEach items="${searchCraigs}" var="searchcraig" varStatus="searchvs">
				<c:if test="${searchvs.index%4==0}">
					<tr data-no="${searchcraig.no}" style="padding-bottom : 30px; margin-bottom : 30px; ">
				</c:if>
					  <td class="crnotd" data-crno="${searchcraig.no}" style="width:200px; height: 380px; padding: 10px">
						<div class="explains">
							<div>
							<%-- img --%>
							<c:if test="${searchcraig.attachments[0].reFilename != null}">
							    <a><img id="eachimg"  style="display : inline-block; height : 200px; width:200px; " 
									    src="${pageContext.request.contextPath}/resources/upload/craig/${searchcraig.attachments[0].reFilename}"/></a><br/>
							</c:if>
							<c:if test="${searchcraig.attachments[0].reFilename==null}">
							    <a><img id="eachimg"  style="display : inline-block; height : 200px; width:200px;" 
									    src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/></a><br/>
							</c:if>
								<p id="crtitle" class="crpp">${searchcraig.title}</p>
							<c:if test="${searchcraig.price > 0}">
								<p id="crprice" class="crpp" style="display: inline-block; font-size:17px; margin-right: 20px;"> <fmt:formatNumber pattern="#,###" value="${searchcraig.price}" />원</p>
							</c:if>
							<%-- CR1 || CR3--%>
							<c:if test="${searchcraig.state == 'CR1'}">
								<span class="badge badge-success" style="height: 22px; font-size: 13px; text-align: center; vertical-align: middle;"> 예약중 </span>
							</c:if>
							<c:if test="${searchcraig.state == 'CR3'}">
								<span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: center; vertical-align: middle;"> 판매완료 </span>
							</c:if>
		
							<c:if test="${searchcraig.price == 0 && searchcraig.categoryNo != 7 }">
								<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; font-size: 17px;">나눔💚</p>
							</c:if>
								<p id="crdong" class="crpp">${searchcraig.dong.dongName}</p> <span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">${wishCnt[searchvs.index]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat"></span> 

								</div>
							</div>
						</td>
					<c:if test="${searchvs.index %4==3}">
						</tr>
					</c:if>
				</c:forEach>
			</c:if>
		<%-- ★★★★★★★★★★--%>
			</tbody>
		</table><br><br><br><br><br>
</section>

		<%-- ◆◆◆ 페이징 ◆◆◆--%>
		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<!--  pre   --> 
	        <c:choose>
	           <c:when test="${craigPage.prevPage <= 0 }">
	             <li class="page-item disabled"><a class="page-link" href="#"> 이전 </a></li>
			    </c:when>
	            <c:otherwise>	
		            <c:if test="${searchCraigs == null}">
	             		<li class="page-item" ><a class="page-link" href="${pageContext.request.contextPath}/craig/craigList.do?cpage=${craigPage.prevPage}">Previous</a></li>					
					</c:if>
					<c:if test="${searchCraigs != null}">
	 					<li class="page-item" ><a class="page-link" href="${pageContext.request.contextPath}/craig/craigList.do?searchKeyword=${searchKeyword}&cpage=${craigPage.prevPage}">Previous</a></li>	
	 				</c:if>
	 			</c:otherwise>
	        </c:choose>
	 		<!--  now --> 
	        <c:forEach var="cpage"  begin="${craigPage.min}" end="${craigPage.max}">       
	          <c:choose>
				<c:when test="${cpage == craigPage.currentPage}">
					<c:if test="${searchCraigs == null}">
				      <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/craig/craigList.do?cpage=${cpage}">${cpage}</a></li>
					</c:if>	
					
				    <c:if test="${searchCraigs != null}">
				      <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/craig/craigList.do?searchKeyword=${searchKeyword}&cpage=${cpage}">${cpage}</a></li>
					</c:if>
			    </c:when>	
			    		    
			    <c:otherwise>
			    	<c:if test="${searchCraigs == null}">
	    			    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/craig/craigList.do?cpage=${cpage}">${cpage}</a></li>
			    	</c:if>
   			    	<c:if test="${searchCraigs != null}">
	    			    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/craig/craigList.do?searchKeyword=${searchKeyword}&cpage=${cpage}">${cpage}</a></li>
			    	</c:if>
		 		</c:otherwise>
			 </c:choose>  
			</c:forEach>
			 <!-- next -->
		    <c:choose>
	          <c:when test="${craigPage.max >= craigPage.pageCnt }">
			    <li class="page-item disabled"><a class="page-link" href="#"> 다음 </a></li>
			  </c:when>	          
	          <c:otherwise>
			     <li class="page-item"><a class="page-link" href="#">Next</a></li>
			   </c:otherwise>
	        </c:choose>    
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

//글쓰기 
document.querySelector("#writeCraigbtn").addEventListener('click', (e) => {
			location.href = `${pageContext.request.contextPath}/craig/craigEnroll.do`;

});
</script>

<script>
//■ 상세페이지
document.querySelectorAll("td[data-crno]").forEach( (td)=>{
	td.addEventListener('click', (e) => {
		console.log(e.target);
		console.log( td );
		
		const no = td.dataset.crno;
		console.log( no );
		location.href = "${pageContext.request.contextPath}/craig/craigDetail.do?no="+no;
		
	})
})

</script>

<script>
//■ 내동네
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

<script>
// ■ 검색
document.querySelector(".searchButton").addEventListener('click', (e)=>{
	const sfrm = document.keywordFrm;	
	const searchKeyword =  document.querySelector("#searchKeyword").value;
	console.log(e.target);
	console.log(searchKeyword);
	
	if(searchKeyword == null || searchKeyword ==""){
		alert("검색어를 입력해주세요!");
		e.preventDefault();
		return;
	}

	const blank_pattern = /^\s+|\s+$/g;
	if(searchKeyword.replace(blank_pattern, '' ) == "" ){
		alert("검색어를 입력해주세요!");
		document.querySelector("#searchKeyword").select();
		e.preventDefault();
		return false;
	}
	
	
	else if(searchKeyword != null && searchKeyword !="" ){
		location.href = "${pageContext.request.contextPath}/craig/craigList.do";
	}	
});


// ■ 카테고리 - 비동기를 하나는 해야될거같은디 -- 음 해본다 ^^,, 0330
document.querySelectorAll("li[data-no]").forEach( (cateli)=>{

	let nav  = document.querySelector("nav");
	let tbody  = document.querySelector("#craigWholeListTbl tbody");
	
	
	cateli.addEventListener('click', (e) => {
		
		const cateno = cateli.dataset.no;
		console.log( cateno );	
		
	//	location.href = "${pageContext.request.contextPath}/craig/craigList.do?categoryNo=${cateno}";

	$.ajax({
		url : `${pageContext.request.contextPath}/craig/selectCategorySearch.do`,
		method : 'get',
		dataType : 'json',
		data : { categoryNo : cateno },
		success(data){
			console.log( data );
			
			nav.innerHTML = "";
			tbody.innerHTML = "";
			
			const tr1 =  document.createElement("tr");
			tbody.append( tr1 );
			
			const cateCraigs = data.searchCrategory;
			const imgone = "";
			//엄청난 비동기의 시작 일단 다비운다			
			for( let i=0; i<cateCraigs.length; i++ ){

				
				if( parseInt(i/4) == 0){

					tr1.innerHTML += 
				      `<td class="crnotd" data-crno="${cateCraigs.no}" style="width:200px; height: 380px; padding: 10px">
						<div class="explains">
							<div>`;
							
					tr1.innerHTML += imgone;
					
					
							
						if(${cateCraigs.attachments[0].reFilename != null}){
							 imgone = `<a><img id="eachimg"  style="display : inline-block; height : 200px; width:200px; " 
								    src="${pageContext.request.contextPath}/resources/upload/craig/${cateCraigs.attachments[0].reFilename}"/></a><br/>`;
							}
							
							
							<%--
								<a><img id="eachimg"  style="display : inline-block; height : 200px; width:200px; " 
									    src="${pageContext.request.contextPath}/resources/upload/craig/${cateCraigs.attachments[0].reFilename}"/></a><br/>
							</c:if>
							<c:if test="${cateCraigs.attachments[0].reFilename==null}">
							    <a><img id="eachimg"  style="display : inline-block; height : 200px; width:200px;" 
									    src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/></a><br/>
							</c:if>
								<p id="crtitle" class="crpp">${searchcraig.title}</p>
							<c:if test="${cateCraigs.price > 0}">
								<p id="crprice" class="crpp" style="display: inline-block; font-size:17px; margin-right: 20px;"> <fmt:formatNumber pattern="#,###" value="${searchcraig.price}" />원</p>
							</c:if>
							<%-- CR1 || CR3
							<c:if test="${cateCraigs.state == 'CR1'}">
								<span class="badge badge-success" style="height: 22px; font-size: 13px; text-align: center; vertical-align: middle;"> 예약중 </span>
							</c:if>
							<c:if test="${cateCraigs.state == 'CR3'}">
								<span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: center; vertical-align: middle;"> 판매완료 </span>
							</c:if>
		
							<c:if test="${cateCraigs.price == 0 && cateCraigs.categoryNo != 7 }">
								<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; font-size: 17px;">나눔💚</p>
							</c:if>
								<p id="crdong" class="crpp">${cateCraigs.dong.dongName}</p> <span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">${wishCnt[searchvs.index]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat"></span> 
						
								</div>
							</div>
					  </td>`
					  --%>				
				}				
				
				
				
				
				
			}

			
			
			
			
			
			
			
		},
		error : console.log
	});//end-ajax
		
		
	})
})



</script>

<br><br><br><br><br><br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>