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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/local/localDetail.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginMember"/>
<div class="localboard-container">
	<div class="localboard-wrap">
		<span class="category">${category}</span>
		<div class="memberInfo">
			<div class="profileimg">
				<img src="${pageContext.request.contextPath}/resources/upload/profile/${localdetail.member.profileImg}" alt="사용자프로필">
			</div>
			<div class="detailInfo">
				<span class="nickname">${localdetail.member.nickname}</span>
				<div class="dong-date">
				<span>${localdetail.dong.dongName}</span>
				&nbsp;
				<fmt:parseDate value="${localdetail.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate"/>
					<fmt:formatDate value="${regDate}" pattern="MM.dd HH:mm"/>
			</div>
				<div class="update-delete">
				<button id="togglebtn"><i class="bi-three-dots-vertical"></i></button>
				<c:if test="${localdetail.writer eq loginMember.memberId  }">
					<div id="divToggle" style="display: none; position:absolute; right:20px; top:60px;">
						<ul class="updeltb">
							<li><button class="btn" id="update">수정하기</button></li>
							<li><button class="btn" id="deletee">삭제하기</button></li>
						</ul>
					</div>
				</c:if>
				<c:if test="${localdetail.writer != loginMember.memberId  }">
				<div id="divToggle" style="display: none; position:absolute; right:20px; top:60px;">
				<ul class="updeltb">
					<li><button class="btn report">신고하기</button>
				</ul>
				</div>
				</c:if>
				</div>
			</div>
		</div>
			<div class="titleInfo" >
				<span>${localdetail.title}</span>
			</div>
			<div class="contentInfo">
				<p>${localdetail.content }</p>
			</div>
			<div class="contentImg">
				<c:if test="${localdetail.attachments[0].reFilename!=null}">
						    <a><img id="eachimg"  style="display : inline-block; height : 250px; width:250px; border-radius:5px;" 
								    src="${pageContext.request.contextPath}/resources/upload/local/${localdetail.attachments[0].reFilename}"/></a><br/>
						</c:if>
			</div>
			<div class="reheco">
				<span>조회${localdetail.hits}</span>
				<!-- 좋아요 -->
				<c:choose>
					<!-- likecheck가 0이면 빈하트 -->
					<c:when test="${likecheck eq '0' or empty likecheck}">
						<img class="btnlike" src="${pageContext.request.contextPath}/resources/images/heart_empty.png">
					</c:when>
					<!-- likecheck가 1이면 채운하트 -->
					<c:otherwise>
						<img class="btnlike" src="${pageContext.request.contextPath}/resources/images/heart_red.png">
					</c:otherwise>
				</c:choose>
					<span class="comment-btn">댓글쓰기</span>
			</div>
		<div class="div-comment">
			<span>·등록순</span>
			&nbsp;&nbsp;&nbsp;
			<span>·최신순</span>
		</div>
	</div>
</div>
<c:if test="${localdetail.writer eq loginMember.memberId}">
<form:form name="localDeleteFrm"  enctype ="multipart/form-data"  method="post"
	 action="${pageContext.request.contextPath}/local/localDelete.do?${_csrf.parameterName}=${_csrf.token}" >
	 <input type="hidden" name="no" value="${localdetail.no}" >
</form:form>

<script>
//수정하기
document.querySelector("#update").addEventListener('click', (e) => {
	const no ='${localdetail.no}'
		location.href = '${pageContext.request.contextPath}/local/localUpdate.do?no=' + no;
});

//삭제하기
document.querySelector("#deletee").addEventListener('click', (e) => {
	if(confirm('게시글을 삭제하시겠습니까?')){
		document.localDeleteFrm.submit();
	}
});
</script>
</c:if>

<c:if test="${localdetail.writer != loginMember.memberId}">
<script>
/* 신고하기 */
document.querySelector(".report").addEventListener('click', (e) => {
	const reportType = 'LO';
	const boardNo = '${localdetail.no}';
	const reportedId = '${localdetail.writer}';
	console.log(reportType, boardNo, reportedId);
	
	location.href = '${pageContext.request.contextPath}/report/reportEnroll.do?reportType='+ reportType + '&boardNo=' + boardNo + '&reportedId=' + reportedId;
	
});
</script>
</c:if>

<script>
$(function (){
	$("#togglebtn").click(function (){
  	$("#divToggle").toggle();
  });
});
</script>


<script>
// 하트 누르기
<script>
	document.querySelector(".btnlike").addEventListener('click', (e) => {
		const img = e.target;
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		console.log( img );
		headers[csrfHeader] = csrfToken;
		
		$.ajax({
		    method : 'POST',
		    url : `${pageContext.request.contextPath}/local/clickLike.do`,
		    headers,
		    dataType : 'json',
		    data : { no : '${localdetail.no}',
		             memberId : '<sec:authentication property="principal.username" />'},
	           success(data){
		    	if(data == 1){
		    		img.src = `${pageContext.request.contextPath}/resources/images/heart_red.png`;
		    	}
		    	else{
		    		img.src = `${pageContext.request.contextPath}/resources/images/heart_empty.png`;
		    	}
		    }
		   
		})
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>