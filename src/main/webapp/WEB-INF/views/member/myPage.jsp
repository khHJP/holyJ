<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="subtitle"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

</head>
<body>
<br />
<br />
	<table>
		<th>
			<td>
		
		
			<!-- Button trigger modal -->
			<button type="button" class="btn1 btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
			<img src="${pageContext.request.contextPath}/resources/upload/profile/<sec:authentication property="principal.profileImg"/>"  alt="프로필" name="profileImg" id="imagePreview">
			</button>
			
			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content">
			      <div class="modal-header">
				      <div>
					        <h3 class="modal-title fs-5" id="exampleModalLabel">
					        <img src="${pageContext.request.contextPath}/resources/upload/profile/<sec:authentication property="principal.profileImg"/>"  alt="프로필" name="profileImg" id="imagemodal">
					        <sec:authentication property="principal.nickname"/></h3>
					        <h6><sec:authentication property="principal.enrollDate"/>
					        <fmt:formatDate value="${loginMember.enrollDate}" type="date"/>가입
					        </h6>
				        </div>
					        <h6><sec:authentication property="principal.manner"/>℃</h6>
			      </div>
			      
			      <div class="modal-body">
			        <li>
			        <img src="${pageContext.request.contextPath}/resources/images/Cr.png" alt="" id="mypageimg"/>
			        <a href="">중고거래</a>
			        </li>
			        <li>
			        <img src="${pageContext.request.contextPath}/resources/images/Lo.png" alt="" id="mypageimg"/>
			        <a href="">동네생활</a>
			        </li>
			        <li>
			        <img src="${pageContext.request.contextPath}/resources/images/To.png" alt="" id="mypageimg"/>
			        <a href="">같이해요</a>
			        </li>
			        <li>
					<img src="${pageContext.request.contextPath}/resources/images/heart_empty.png" alt="" id="mypageimg"/>
					<a href="${pageContext.request.contextPath}/craig/myWishCraig.do">관심목록</a>
				</li>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			      </div>
			    </div>
			  </div>
			</div>
			</td>
		<!-- --------------------------------------------------------------------------------------------- -->
			<td>
				<span id="nickname"><sec:authentication property="principal.nickname"/></span>
			</td>
			<td>
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/myProfile.do'">프로필 보기</button>
			</td>
		</th>
	</table>
		<br />
		<div class="menu-container">
			<ul class="menu-list">
				<li id="menu">중고거래</li>
				<li id="submenu">
					<img src="${pageContext.request.contextPath}/resources/images/tag.png" alt="" id="mypageimg"/>
					<a href="${pageContext.request.contextPath}/notice/noticeKeywordList.do">알림 키워드 설정</a>
				</li>
				<li id="submenu">
					<img src="${pageContext.request.contextPath}/resources/images/sal.png" alt="" id="mypageimg"/>
					<a href="${pageContext.request.contextPath}/craig/mySalCraig.do">판매내역</a>
				</li>
				<li id="submenu">
					<img src="${pageContext.request.contextPath}/resources/images/buy.png" alt="" id="mypageimg"/>
					<a href="${pageContext.request.contextPath}/craig/myBuyCraig.do">구매내역</a>
				<li id="submenu">
					<img src="${pageContext.request.contextPath}/resources/images/heart.png" alt="" id="mypageimg"/>
					<a href="${pageContext.request.contextPath}/craig/myWishCraig.do">관심목록</a>
				</li>
				</li>
				<hr />
				<li id="menu">동네생활</li>
				<li id="submenu">
					<img src="${pageContext.request.contextPath}/resources/images/list.png" alt="" id="mypageimg"/>
					<a href="${pageContext.request.contextPath}/local/myLocal.do">동네생활 글/댓글</a>
				</li>
				<hr />
				<li id="menu">같이해요</li>
				<li id="submenu">
					<img src="${pageContext.request.contextPath}/resources/images/list.png" alt="" id="mypageimg"/>
					<a href="${pageContext.request.contextPath}/together/myTogether.do">나의 같이해요</a>
				</li>
				<hr />
				<li id="menu">채팅</li>
				<li id="submenu">
					<img src="${pageContext.request.contextPath}/resources/images/chat.png" alt="" id="mypageimg"/>
					<a href="${pageContext.request.contextPath}/chat/chatList.do">채팅방</a>
				</li>
			</ul>
		</div>
	<script>
	const myModal = document.getElementById('myModal')
	const myInput = document.getElementById('myInput')

	myModal.addEventListener('shown.bs.modal', () => {
	  myInput.focus()
	})
	</script>
		
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>