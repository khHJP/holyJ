<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
	integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/chat/chatroom.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<style>
/* 주아체 */
@font-face {
    font-family: 'BMJUA';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
/* noto-sans */
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');

main#chatWrap {
   max-width: 73rem;
   mam-width: 73rem;
   max-height: 50rem;
   min-height: 50rem;
   margin: 0 auto;
   border: 1px solid rgba(0,0,0,.125);
   font-family: 'Noto Sans KR', sans-serif;
 }
#content {
	border-bottom: 1px solid #eaebee;
}

/* 프로필바 */
#prof-bar > a {
	height: 72px;
}

/* 채팅목록  */
#chatList > div#nickname {
	height: 72px;
}
#chatList > div#nickname > span {
	font-size: 20px;
	font-weight: bold;
}

/* 스크롤바 관련  */
.scrollarea {
   overflow-y: auto;
}
.scrollarea::-webkit-scrollbar {
    width: 8px; 
}
.scrollarea::-webkit-scrollbar-thumb {
    background: rgba(178, 215, 181, 0.412); 
    border-radius: 10px;
    border: 1px solid #7FB77E;
}
.scrollarea::-webkit-scrollbar-track {
    background: #F2F3F6; 
}

#chatLog {
	width: 715px;
}

/* 채팅목록 */
#chatList {

}
#chatList-wrap img{
	width: 40px;
	border-radius:50%;
	float: left;
}
.chatList-header {
	margin-right: 150px;
}
.col-10 {
	max-width: 100%;	
}
</style>
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