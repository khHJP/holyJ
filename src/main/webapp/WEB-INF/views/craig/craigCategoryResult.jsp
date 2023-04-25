<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:if test="${fn:length(wishCnt) == 0  }">
	<p style='margin: auto; padding-left : 350px; font-size:33px' > 아직 해당 카테고리의 게시물이 없습니다! </p>
	<img  style='width:700px; height: 600px; position:relative; top: 220px; left:280px; display : block;' 
		src='${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png'/></br></br></br>
</c:if>

<c:forEach items="${searchCrategory}" var="craig" varStatus="vs">
	<c:if test="${vs.index%4==0}">
		<tr data-no="${craig.no}" style="padding-bottom : 30px; margin-bottom : 30px; ">
	</c:if>
		  <td class="crnotd" data-crno="${craig.no}" style="width:350px; height: 380px; padding: 30px; padding-right: 45px">
			<div class="explains">
				<%-- img --%>
				<c:if test="${craig.attachments[0].reFilename != null}">
				    <a><img id="eachimg"  style="display : inline-block; height : 250px; width:240px; " 
						    src="${pageContext.request.contextPath}/resources/upload/craig/${craig.attachments[0].reFilename}"/></a><br/>
				</c:if>
				<c:if test="${craig.attachments[0].reFilename==null}">
				    <a><img id="eachimg"  style="display : inline-block; height : 250px; width:240px;" 
						    src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/></a><br/>
				</c:if>
					<p id="crtitle" class="crpp">${craig.title}</p>

				<%-- CR1 || CR3--%>
				<c:if test="${craig.state == 'CR1'}">
					<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-success" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 예약중 </span></p>
				</c:if>
				<c:if test="${craig.state == 'CR2'}">
					<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-secondary" style="height: 22px;font-size: 13px; text-align: left; bavertical-align: middle; background-color: white"> </span></p>
				</c:if>
				<c:if test="${craig.state == 'CR3' && craig.price != 0  }">
					<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 거래완료 </span></p>
				</c:if>
				<c:if test="${craig.state == 'CR3' && craig.price == 0 && craig.categoryNo != 7  }">
					<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 나눔완료 </span></p>
				</c:if>
				<c:if test="${craig.price > 0}">
					<p id="crprice" class="crpp" style="font-size:17px; margin-right: 20px;"> <fmt:formatNumber pattern="#,###" value="${craig.price}" />원</p>
				</c:if>		
				<c:if test="${craig.price == 0 && craig.categoryNo != 7 }">
					<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; margin-top: 15px; font-size: 17px;">나눔💚</p>
				</c:if>
					<p id="crdong" class="crpp">${craig.dong.dongName}</p> 
					<p style="text-align: left"><span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">${wishCnt[vs.index]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat"> ${craigChatCnt[vs.index]} </span></p> 
				</div>
			</td>
	<c:if test="${vs.index %4==3}">
		</tr>
	</c:if>
	
</c:forEach>

<c:if test="${totalPage >= 2}">
<script>
	// 더보기 버튼 보일 경우 
		if( ${totalPage} > 1 ){
			const searchPageResultjsp = document.querySelector("#searchPage").innerHTML;
			document.querySelector("#btn-more").style.visibility="visible";
			document.querySelector("#searchPage").innerHTML = Number(searchPageResultjsp)+1 // 다음페이지셋팅
			
			document.querySelector(".dropdown-toggle").addEventListener("click", (e) => {
//				console.log(" if change category ");
			  	const button = document.querySelector("#btn-more");
				document.querySelector("#searchPage").innerHTML = 1;
				document.querySelector("#btn-more").style.visibility="hidden";
				document.querySelector("#btn-more").style.disabled="true";
			});
			
		}
		
		if( document.querySelector("#searchPage").innerHTML > ${totalPage}   ){ //버튼없애기			
//			console.log("지금 없애댜돼");
		  	const button = document.querySelector("#btn-more");
			document.querySelector("#searchPage").innerHTML = 1;
			document.querySelector("#btn-more").style.visibility="hidden";
			document.querySelector("#btn-more").style.disabled="true";
		}
</script>
</c:if>

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
