<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="list-group list-group-flush border-bottom scrollarea">
	<!-- 게시글정보 start -->
	<div id="craig_bar">
		<div class="craig_info_wrap">
			<c:if test="${craig.attachments[0].reFilename == null}">
				<img src="/oee/resources/images/OEE-LOGO2.png" alt="" />
			</c:if>
			<c:if test="${craig.attachments[0].reFilename != null}">
				<img src="/oee/resources/upload/craig/${craig.attachments[0].reFilename}" alt="" />
			</c:if>
			<div class="craig_text">
				<p class="craig_status">
					<c:choose> 
						<c:when test="${craig.state eq 'CR1'}">
						예약중
						</c:when>
						<c:when test="${craig.state eq 'CR2'}">
						판매중
						</c:when>
						<c:when test="${craig.state eq 'CR3'}">
						판매완료
						</c:when>
					</c:choose>
				</p> 
				<p class="craig_name">${craig.title}</p>
				<span class="price">
					<fmt:formatNumber value="${craig.price}" pattern="#,###"/>원
				</span>
			</div>
		</div>
		<button type="button" class="btn btn-outline-secondary">약속잡기</button>
	</div>
	<!-- 게시글정보 end -->


	<a href="#" class="list-group-item list-group-item-action py-3 lh-sm" aria-current="true">
		<div id="chatList-wrap" class="d-flex w-100 align-items-center justify-content-between">
			<img src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지"/>
        	<div class="chatList-header">
	       		<strong class="mb-1">닉네임</strong>
	          	<small>지역</small>
			    <small>시간</small>
		    	<div class="last-chatting small">마지막채팅내용</div> <!-- 앞에서부터 몇자까지 끊어서 출력해야할듯  -->
        	</div> 
        </div>
      </a>
</div>
</body>
</html>