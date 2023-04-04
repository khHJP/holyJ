<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
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
		height:39px; width: 80px; 
		background-color: white; 
		color:black; 
		border: 1.5px solid black;
		top:-1px; position: relative; left:10px;  
	}
	
	#writeCraigbtn:hover { border-color:  #28a745; }
	
	#memberInfo{
		width: 100px;
		border: 1.5px solid black;
		height: 38px;
		padding: 6px;
		padding-bottom : 12px;
		vertical-align :middle;
		border-radius: 5px 5px 5px 5px;
		margin-top: 2px;
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
	
	.searchdiv { margin-left: 1px; display: inline-block; margin-left: -10px}
	
/* header */
.nav-link{ margin-top: -5px }
.profile-wrap{ margin-top: 5px }
.login-box { width: 140px;
    display: flex; align-items: center;
    justify-content: flex-end;  margin-top: -5px ;
}
</style>
<div style="height: 400px; width:1794px !important; margin-left : -350px;  background-color: #F7F1EB">
	<div class="seconddivv" >
	 	<div><h1>우리 동네</h1>
	 	<h1> 중고 직거래 마켓</h1></div>
		<div><img  src="${pageContext.request.contextPath}/resources/images/indexdang.png" /></div>
	</div>
</div>
<br><br><br>
	<%-- 글쓰기 / 카데고리 --%>
	<div id="searchToWriteDiv">
	   	<div class="btn-group" style="margin-left: 95px; margin-right: 10px ">
			<button type="button" style="width:160px; border: 1.5px solid black  ; height:36px; appearance:none; margin-top: 2px;" class="btn btn-success dropdown-toggle"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    	중고거래 카테고리
			</button>
		  	<ul class="dropdown-menu">
			  <c:forEach items="${craigCategory}" var="category">
			    <li data-no="${category.CATEGORY_NO}"><a class="dropdown-item" data-ano="${category.CATEGORY_NO}"  href="#">${category.CATEGORY_NAME}</a></li>
		   	  </c:forEach>
			</ul>
		</div>

		<span id="memberInfo" ></span>
		<%--  검색 --%>		
	    <div class="searchdiv" style=""> <%-- 동일핸들러로 보내보자 --%>
		    <form:form action=""
	    		 id="keywordFrm" name="keywordFrm" style="display:inline" method="get">
		    	<input type="text"  name="searchKeyword" id="searchKeyword" placeholder=" 검색어를 입력해주세요 ">
		    	<button type="submit" class="searchButton"> <i class="fa fa-search"></i> </button>
	      	</form:form>
       	 	<button id="writeCraigbtn"  class="btn btn-success " style=""> 글쓰기</button>
	    </div>
	</div>
<section id="craigWhole" >	
<%-- whole List  --%>
	<c:if test="${searchCraigs == null}">
		<h3 style="margin: 80px 0 80px 0; text-align: center;"> 중고거래 인기 매물</h3>
	</c:if>
		
	<c:if test="${searchCraigs[0] != null && searchCraigs != '' && searchKeyword != null && searchKeyword != '' }">
		<h3 style="margin: auto; margin-top: 50px; text-align: center;"><span id="searchWord" style="color: green; text-decoration: underline;">${searchKeyword} </span>(으)로 검색한 결과</h3>
		<script>
		document.querySelector(".dropdown-toggle").addEventListener('click', e=>{
			alert("검색과 카테고리를 동시에 사용하실 수 없습니다😣");
			location.href = "${pageContext.request.contextPath}/craig/craigList.do";
		})
		</script>
	</c:if>
	<c:if test="${searchCraigs[0] == null && searchKeyword != null  }">
		<h3 style="margin: auto; margin-top: 50px; text-align: center;"><span id="searchWord" style="color: green; text-decoration: underline;">${searchKeyword} </span>(으)로 검색한 결과가 없습니다!</h3>
		<img  style="width:700px; height: 600px; margin:70px 0 0 280px " src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png" alt="First slide" >
		<script>
		document.querySelector(".dropdown-toggle").addEventListener('click', e=>{
			alert("검색과 카테고리를 동시에 사용하실 수 없습니다😣");
			location.href = "${pageContext.request.contextPath}/craig/craigList.do";
		})
		</script>
	</c:if>
	
<%-- ★★★★★ 걍 결과 ★★★★★--%>
		<table id="craigWholeListTbl">
			<tbody>
			<c:forEach items="${craigList}" var="craig" varStatus="vs">
				<c:if test="${vs.index%4==0}">
					<tr data-no="${craig.no}" style="padding-bottom : 30px; margin-bottom : 30px; ">
				</c:if>
					  <td class="crnotd" data-crno="${craig.no}" style="width:200px; height: 380px; padding: 10px">
						<div class="explains">
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

							<%-- CR1 || CR3--%>
							<c:if test="${craig.state == 'CR1'}">
								<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-success" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 예약중 </span></p>
							</c:if>
							<c:if test="${craig.state == 'CR2'}">
								<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-secondary" style="height: 22px;font-size: 13px; text-align: left; bavertical-align: middle; background-color: white"> </span></p>
							</c:if>
							<c:if test="${craig.state == 'CR3' && craig.price != 0  }">
								<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 거래완료 </span></p>
							</c:if>
							<c:if test="${craig.state == 'CR3' && craig.price == 0 && craig.categoryNo != 7  }">
								<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 나눔완료 </span></p>
							</c:if>
							<c:if test="${craig.price > 0}">
								<p id="crprice" class="crpp" style="font-size:17px; margin-right: 20px;"> <fmt:formatNumber pattern="#,###" value="${craig.price}" />원</p>
							</c:if>		
							<c:if test="${craig.price == 0 && craig.categoryNo != 7 }">
								<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; font-size: 17px;">나눔💚</p>
							</c:if>
								<p id="crdong" class="crpp">${craig.dong.dongName}</p> 
								<p style="text-align: left"><span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">${wishCnt[vs.index]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat"> ${craigChatCnt[vs.index]} </span></p> 
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
							
							<%-- CR1 || CR3--%>
							<c:if test="${searchcraig.state == 'CR1'}">
								<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-success" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 예약중 </span></p>
							</c:if>
							<c:if test="${searchcraig.state == 'CR2'}">
								<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-secondary" style="height: 22px;font-size: 13px; text-align: left; bavertical-align: middle; background-color: white"> </span></p>
							</c:if>
							<c:if test="${searchcraig.state == 'CR3' && searchcraig.price != 0  }">
								<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 거래완료 </span></p>
							</c:if>
							<c:if test="${searchcraig.state == 'CR3' && searchcraig.price == 0 && searchcraig.categoryNo != 7  }">
								<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 나눔완료 </span></p>
							</c:if>
							
							<c:if test="${searchcraig.price > 0}">
								<p id="crprice" class="crpp" style="font-size:17px; margin-right: 20px;"> <fmt:formatNumber pattern="#,###" value="${searchcraig.price}" />원</p>
							</c:if>		
							<c:if test="${searchcraig.price == 0 && searchcraig.categoryNo != 7 }">
								<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; font-size: 17px;">나눔💚</p>
							</c:if>
								<p id="crdong" class="crpp">${searchcraig.dong.dongName}</p> 
								<p style="text-align: left"><span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">${wishCnt[searchvs.index]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat">${craigChatCnt[searchvs.index]}</span></p>
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
				      <li class="page-item nowpagegreen"><a style="background-color: #008200; color: white;"  class="page-link nowpagegreen" href="${pageContext.request.contextPath}/craig/craigList.do?cpage=${cpage}">${cpage}</a></li>
					</c:if>	
					
				    <c:if test="${searchCraigs != null}">
				      <li class="page-item"><a class="page-link" style="background-color: #008200; color: white;" href="${pageContext.request.contextPath}/craig/craigList.do?searchKeyword=${searchKeyword}&cpage=${cpage}">${cpage}</a></li>
					</c:if>
			    </c:when>	
			    		    
			    <c:otherwise>
			    	<c:if test="${searchCraigs == null}">
	    			    <li class="page-item"><a class="page-link"  href="${pageContext.request.contextPath}/craig/craigList.do?cpage=${cpage}">${cpage}</a></li>
			    	</c:if>
   			    	<c:if test="${searchCraigs != null}">
	    			    <li class="page-item"><a class="page-link"  href="${pageContext.request.contextPath}/craig/craigList.do?searchKeyword=${searchKeyword}&cpage=${cpage}">${cpage}</a></li>
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

<%-- 비동기 더보기 버튼 --%>
	<div class="btbca" style="text-align: center;	">
	<button id="btn-more"  class="btn" style="margin: auto; visibility: hidden; width:100px; border: 1px solid green;" > 더보기 <span id="searchPage" >1</span> </button>	
	</div>
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
//	const sfrm = document.keywordFrm;	
	const searchKeyword =  document.querySelector("#searchKeyword").value;
	console.log(searchKeyword);

	const blank_pattern = /^\s+|\s+$/g;  //정규표현식 공란있음 안됨 
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
</script>



<script>
// ■ 카테고리 - 비동기 
	const getMoreCategory = ( page, categoryLi ) => {
		
		const nav  = document.querySelector("nav");
		const tbody  = document.querySelector("#craigWholeListTbl tbody");
	
		let searchPage = document.querySelector("#searchPage").innerHTML;
		let categoryNumber = categoryLi.dataset.no;
	
		if( categoryLi.dataset.no == null ){ //더보기에서 클릭했을때
			  categoryNumber = categoryLi.dataset.ano;	
		}

		nav.innerHTML = "";
		
		if( page == 1 ){ // 앞에 내용이 나와야되니까 
			tbody.innerHTML = "";
		}

		console.log( "버튼에서 호출했을때 categoryNumber -> " , categoryNumber   );
		console.log("내가호출한 함수의 page : ", page );
		
		//비동기시작
		$.ajax({
			url : `${pageContext.request.contextPath}/craig/selectCategorySearch.do`,
			method : 'get',
			dataType : 'json',
			data : { categoryNo : categoryNumber,
					 cpage : searchPage },
			success(data){
			
				const tr1 =  document.createElement("tr");
				  	tr1.style.cssText = "padding-bottom : 30px; margin-bottom : 30px";
	
	 			const tr2 =  document.createElement("tr");
				  	tr2.style.cssText = "padding-bottom : 30px; margin-bottom : 30px";
	
				const tr3 =  document.createElement("tr");
				  	tr3.style.cssText = "padding-bottom : 30px; margin-bottom : 30px";
	
				if( data.wishCnt[0] == null || data.totalPage == 0  ){ // 결과없다 

					tbody.innerHTML = `<p style='position:absolute; top: 450px; left:600px; font-size:33px' >
											아직 해당 카테고리의 게시물이 없습니다! </p>
										<img  style='width:700px; height: 600px; position:relative; top: 220px; left:50px; display : block;' 
						    				src='${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png'/><br/></br></br>`;
				};
	
				// ** 엄청난 비동기의 시작 .... 		
				for( let i=0; i<data.searchCrategory.length; i++ ){
					let img_html = ``; //◆◆◆이미지
					
					if( data.searchCrategory[i].attachments[0].reFilename != null  ){
						img_html = `<div class="explains"><a href = "${pageContext.request.contextPath}/craig/craigDetail.do?no=\${data.searchCrategory[i].no}" /><img id="eachimg"  style="display : inline-block; height : 200px; width:200px;" 
						    		src="${pageContext.request.contextPath}/resources/upload/craig/\${data.searchCrategory[i].attachments[0].reFilename}" /></a><br/>`
					   }
					else if( data.searchCrategory[i].attachments[0].reFilename == null  ){
						img_html = `<a href = "${pageContext.request.contextPath}/craig/craigDetail.do?no=\${data.searchCrategory[i].no}" /><img id="eachimg" style="display : inline-block; height : 200px; width:200px;" 
						    					src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/></a><br/>`
				    }
						
					let price_html = ``; //◆◆◆ 가격
					if( data.searchCrategory[i].price > 0  ){
						let p = data.searchCrategory[i].price;
						let price = p.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						price_html = `<p id="crprice" class="crpp" style="font-size:17px; margin-right: 20px;">\${price}원</p>`
					}
					else if( data.searchCrategory[i].price == 0 && data.searchCrategory[i].categoryNo != 7 ){
						price_html = `<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; font-size: 17px;">나눔💚</p>`
				    }
					else{
						price_html = `<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; font-size: 17px;"> data.searchCrategory[i].price원</p>`
				    }
					
					
					let state_html = ``; //◆◆◆ 상태
					if( data.searchCrategory[i].state == 'CR1' ){
						 state_html = `<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-success" style="height: 22px; font-size: 13px; text-align: center; vertical-align: middle;"> 예약중 </span></p>`
					}
					else if( data.searchCrategory[i].state == 'CR2'){
						 state_html = `<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-secondary" style="height: 22px;font-size: 13px; text-align: left; bavertical-align: middle; background-color: white"> </span></p>`;
					}								
					else if( data.searchCrategory[i].state == 'CR3' && data.searchCrategory[i].price != 0 ){
						state_html = `<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 거래완료 </span></p>`;
					}
					else if( data.searchCrategory[i].state == 'CR3' && data.searchCrategory[i].price == 0 && data.searchCrategory[i].categoryNo != 7 ){
						state_html = `<p style="text-align: left; margin: 0 0 5px 20px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 나눔완료 </span></p>`;
					}

					<%--  뿌리기  --%>
					if( parseInt(i/4) == 0){
						let	    chtml = img_html
								chtml += `<p id="crtitle" class="crpp">\${data.searchCrategory[i].title}</p>`
								chtml += state_html
								chtml += price_html
								chtml += `<p id="crdong" class="crpp">\${data.searchCrategory[i].dong.dongName}</p> 
									<p style="text-align: left"><span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">\${data.wishCnt[i]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat">\${data.craigChatCnt[i]}</span></p></div>`; 
	
						const td = document.createElement('td');
							  td.dataset.crno = data.searchCrategory[i].no;
							  $(td).attr('class','crnotd');
							  td.style.cssText = "width:200px; height: 380px; padding: 10px"
							  td.innerHTML = chtml;					
						 tr1.append( td );
					}
					
					else if( parseInt(i/4) == 1){
						let	cchtml = img_html
								cchtml += `<div class="explains"><p id="crtitle" class="crpp">\${data.searchCrategory[i].title}</p>`
								cchtml += state_html
								cchtml += price_html
								cchtml += `<p id="crdong" class="crpp">\${data.searchCrategory[i].dong.dongName}</p> 
									<p style="text-align: left"><span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">\${data.wishCnt[i]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat">\${data.craigChatCnt[i]}</span></p></div>`; 
	
						const td2 = document.createElement('td');
							  td2.dataset.crno = data.searchCrategory[i].no;
							  $(td2).attr('class','crnotd');
							  td2.style.cssText = "width:200px; height: 380px; padding: 10px"
							  td2.innerHTML = cchtml;					
						 tr2.append( td2 );
					}
					
					else if( parseInt(i/4) == 2){
						let ccchtml = img_html
							ccchtml += `<div class="explains"><p id="crtitle" class="crpp">\${data.searchCrategory[i].title}</p>`
							ccchtml += state_html
							ccchtml += price_html
							ccchtml += `<p id="crdong" class="crpp">\${data.searchCrategory[i].dong.dongName}</p> 
								<p style="text-align: left"><span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">\${data.wishCnt[i]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat">\${data.craigChatCnt[i]}</span></p></div>`; 
	
						const td3 = document.createElement('td');
							  td3.dataset.crno = data.searchCrategory[i].no;
							  $(td3).attr('class','crnotd');
							  td3.style.cssText = "width:200px; height: 380px; padding: 10px"
							  td3.innerHTML = ccchtml;					
						 tr3.append( td3 );
					}	
				}//end-for문	
						 
				tbody.append( tr1, tr2, tr3 );
				
				// 더보기 버튼 보인다  
		 		if(data.totalPage > 1 ){								 
					document.querySelector("#btn-more").style.visibility="visible";
					document.querySelector("#searchPage").innerHTML = Number(searchPage)+1 // 다음페이지셋팅 
		 		}	
			},
			error : console.log,
			complete(){
				//마지막 페이지인 경우 더보기 버튼 비활성화 처리
				if( searchPage == ${totalPage} ){
				  const button = document.querySelector("#btn-more");
						document.querySelector("#searchPage").innerHTML = 1;
						document.querySelector("#btn-more").style.visibility="hidden";
				}
			}	
		});//end-ajax
	
	};/// 함수끝 

	
	// ※※ 실제 카테고리 선택하면 호출 되는 함수 
	let letCategoryLi = ""; //전역
	document.querySelectorAll("li[data-no]").forEach( (categoryLi)=>{
				
		categoryLi.addEventListener('click', (e) => {
			
		const selectedValue = e.target.innerHTML; //값셋팅
			  document.querySelector(".dropdown-toggle").innerHTML = selectedValue;
		
		const categoryNumber = categoryLi.dataset.no;
		      letCategoryLi = e.target; //해당 li

	      getMoreCategory(1, categoryLi); // 함수호출  
		});		  
	});		  
		  
	// ※※ 더보기 버튼이 있을 경우 
	document.querySelector("#btn-more").addEventListener('click', ()=>{
	
		 const searchPage = document.querySelector("#searchPage").innerHTML; //searchPage
		 
		 getMoreCategory(searchPage, letCategoryLi); // ■■ 더보기함수호출
		 console.log( "함수호출후" , searchPage,  letCategoryLi  ); // 해당  page, li
	});
</script>


<br><br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>