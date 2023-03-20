<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<<<<<<< HEAD
=======
<!-- jquery -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- bootstrap css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
>>>>>>> branch 'master' of https://github.com/khHJP/holyJ.git

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래대화방" name="title"/>
</jsp:include>




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
   max-height: 50rem;
   margin: 0 auto;
   border: 1px solid black;
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
	font-size: 17px;
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
</style>


<!-- svg 아이콘태그 start  -->  
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
	<symbol id="craigChatIcon" viewBox="0 0 16 16">
  		<path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
  	</symbol>
</svg> 
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16">
	<symbol id="togetherChatIcon" viewBox="0 0 16 16">
  		<path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
	</symbol>
</svg>
<!-- svg 아이콘태그 end -->    
<main id="chatWrap" class="d-flex flex-nowrap">
  <div id="prof-bar" class="d-flex flex-column flex-shrink-0 bg-light" style="width: 4.5rem;">
    <a href="${pageContext.request.contextPath}/member/myPage.do" class="d-block p-3 link-dark text-decoration-none">
      <img src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지" style="width: 100%;">
    </a>
    <ul class="nav nav-pills nav-flush flex-column mb-auto text-center">
      <li class="nav-item">
        <a href="#" class="nav-link active py-3 border-bottom rounded-0" data-toggle="tooltip" data-placement="right" aria-label="craigChatList" title="중고거래">
          <svg id="craigChat" class="bi pe-none" width="24" height="24" role="img" aria-label="craigChatList"><use xlink:href="#craigChatIcon"></use></svg>
        </a>
      </li>
      <li class="nav-item">
        <a href="#" class="nav-link py-3 border-bottom rounded-0" data-toggle="tooltip" data-placement="right" aria-label="togetherChatList" title="같이해요">
          <svg id="togetherChat" class="bi pe-none" width="24" height="24" role="img" aria-label="togetherChatList"><use xlink:href="#togetherChatIcon"></use></svg>
        </a>
      </li>
    </ul>
  </div>


  <div id="chatList" class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 380px;">
    <div id="nickname" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
      <span>닉네임</span>
    </div>
    <div class="list-group list-group-flush border-bottom scrollarea">
      <a href="#" class="list-group-item list-group-item-action active py-3 lh-sm" aria-current="true">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small>Wed</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
      <a href="#" class="list-group-item list-group-item-action py-3 lh-sm">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small class="text-muted">Tues</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
      <a href="#" class="list-group-item list-group-item-action py-3 lh-sm">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small class="text-muted">Mon</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
      <a href="#" class="list-group-item list-group-item-action py-3 lh-sm" aria-current="true">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small class="text-muted">Wed</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
      <a href="#" class="list-group-item list-group-item-action py-3 lh-sm">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small class="text-muted">Tues</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
      <a href="#" class="list-group-item list-group-item-action py-3 lh-sm">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small class="text-muted">Mon</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
      <a href="#" class="list-group-item list-group-item-action py-3 lh-sm">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small class="text-muted">Tues</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
      <a href="#" class="list-group-item list-group-item-action py-3 lh-sm">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small class="text-muted">Mon</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
      <a href="#" class="list-group-item list-group-item-action py-3 lh-sm" aria-current="true">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small class="text-muted">Wed</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
      <a href="#" class="list-group-item list-group-item-action py-3 lh-sm">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small class="text-muted">Tues</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
      <a href="#" class="list-group-item list-group-item-action py-3 lh-sm">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">List group item heading</strong>
          <small class="text-muted">Mon</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
    </div>
  </div>

</main>
<script>
$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
})

/* tooltip클릭시 고정되는것 숨김 */
document.querySelector("#prof-bar").addEventListener('click', (e) => {
	const $a = $("ul li a");
	$a.tooltip('hide');
}); 
</script>
  
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>