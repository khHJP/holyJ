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
					<div id="divToggle" style="display: none;">
						<ul class="updeltb">
							<li><button class="btn" id="update">수정하기</button></li>
							<li><button class="btn delete">삭제하기</button></li>
						<ul>
					</div>
				</c:if>
				<c:if test="${localdetail.writer != loginMember.memberId  }">
				<div id="divToggle" style="display: none;">
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
				<span>조회</span>
				<div class="heart">
					<span><i class="bi-heart"></i></span>
				</div>
					<span class="comment-btn">댓글쓰기</span>
			</div>
		<div class="div-comment">
			<span>·등록순</span>
			&nbsp;&nbsp;&nbsp;
			<span>·최신순</span>
		</div>
	</div>
</div>

<script>
$(function (){
	$("#togglebtn").click(function (){
  	$("#divToggle").toggle();
  });
});
</script>
<script>
//수정하기
document.querySelector("#update").addEventListner('click', (e) => {
	location.href=`${pageContext.request.contextPath}/local/localUpdate.do?`;
});
</script>
















<jsp:include page="/WEB-INF/views/common/footer.jsp"/>