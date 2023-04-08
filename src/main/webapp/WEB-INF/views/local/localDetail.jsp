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

<script>
//답댓
function reReply(commentNo) {
	$('#replyFrm').remove();
	$reply = $(`
			<form action="${pageContext.request.contextPath}/local/insertReComment.do" method="post" id="replyFrm">
				<input type="text" id="replyEditText" name="content" placeholder="답댓글을 작성하세요"></input>
				<input type="hidden" name="commentNo" id="replyCommentNo" value="">
				<input type="hidden" name="localNo" value="${localdetail.no}">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<button type="submit">등록</button>
			</form>
		`);
	
	if($('#replyFrm').length <= 0){
		$('#parentContent-'+commentNo).append($reply);

		$('#replyCommentNo').val(commentNo);
		
		
	}
}
//댓삭
function replyDelete(commentNo) {
	$('#replyFrm').remove();
	$reply = $(`
			<form action="${pageContext.request.contextPath}/local/deleteComment.do" method="post" id="replyFrm">
				<input type="hidden" name="commentNo" id="replyCommentNo" value="">
				<input type="hidden" name="no" value="${localdetail.no}">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		`);
	
	if($('#replyFrm').length <= 0){
		$('#parentContent-'+commentNo).append($reply);

		$('#replyCommentNo').val(commentNo);
		
		if(confirm('댓글을 삭제하시겠습니까?')){
			$('#replyFrm').submit();
		}
	}
}
//댓글 수정
function replyEdit(commentNo, content) {
	$('#replyFrm').remove();
	console.log(commentNo, content);
	/*
	$replyContent = $('#parentContent-'+commentNo);
	$replyInput = $(`<input type="text" id="replyEditText" placeholder="댓글을 작성하세요"></input>`);
	$replyNo = $(`<input type="hidden" name="commentNo" id="replyCommentNo" value="">`);
	$subminBtn = $(`<button type="submit" id="replyUpdate" onclick="">등록</button>`);*/
	
	$reply = $(`
				<form action="${pageContext.request.contextPath}/local/updateComment.do" method="post" id="replyFrm">
					<input type="text" id="replyEditText" name="content" placeholder="댓글을 작성하세요"></input>
					<input type="hidden" name="commentNo" id="replyCommentNo" value="">
					<input type="hidden" name="no" value="${localdetail.no}">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<button type="submit" id="replyUpdate">등록</button>
				</form>
			`);

	if($('#replyFrm').length <= 0){
		$('#parentContent-'+commentNo).append($reply);

		$('#replyCommentNo').val(commentNo);
		$('#replyEditText').val(content);
	}

	
}

function setCommentOrderList(order) {
	console.log(${localdetail.no});
	if(order == 'asc'){
		location.href = '/oee/local/localDetail.do?no='+${localdetail.no}+'&order=asc';
	}else if(order == 'desc'){
		location.href = '/oee/local/localDetail.do?no='+${localdetail.no}+'&order=desc';
	}
}
</script>
</head>
<sec:authentication property="principal" var="loginMember"/>
<div class="localboard-container">
	<div class="localboard-wrap">
		<span class="category">${localdetail.localcategory.categoryName}</span>
			
		<!-- -------------------------------------------------------------------------------------------------------------- -->		
			<!-- Button trigger modal -->
			<div class="memberInfo">
			<button type="button" class="btn1 btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">				
				<div class="profileimg">
					<img src="${pageContext.request.contextPath}/resources/upload/profile/${localdetail.member.profileImg}" alt="사용자프로필">					
				</div>
			</button>
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
			
		
			
			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content" id="modal-content">
			      <div class="modal-header" id="modal-header">
				      <div>
					      <div style="display:flex;">
					        <img src="${pageContext.request.contextPath}/resources/upload/profile/${localdetail.member.profileImg}"  alt="프로필" name="profileImg" id="imagemodal">
					        <div>
					        <h4 class="modal-title1 fs-5" id="exampleModalLabel">
					        ${localdetail.member.nickname}
					        </h4>
					        <h6 id="dong">${localdetail.dong.dongName}</h6>
					        </div>
					      </div>
			      	</div>
					     <h6>${localdetail.member.manner}℃</h6>
			        </div>
			      
			      <div class="modal-body" id="modal-body">
			      	<form:form name="salCriag1Frm" action="${pageContext.request.contextPath}/craig/mySalCraig1.do" method="GET">
				        <li>
				        <img src="${pageContext.request.contextPath}/resources/images/Cr.png" alt="" id="mypageimg"/>
				        <button type="submit" class="btn-list">중고거래</button>
				        <input type="hidden" name="memberId" value="${localdetail.writer}"/>
				        </li>
			        </form:form>
			      	<form:form name="myLocal1Frm" action="${pageContext.request.contextPath}/local/myLocal1.do" method="GET">
				      	<li>
				        <img src="${pageContext.request.contextPath}/resources/images/Lo.png" alt="" id="mypageimg"/>
					        <button type="submit" class="btn-list">동네생활</button>
					        <input type="hidden" name="memberId" value="${localdetail.writer}"/>
				        </li>
			        </form:form>
			      	<form:form name="myTogether1Frm" action="${pageContext.request.contextPath}/together/myTogether1.do" method="GET">
				        <li>
				        <img src="${pageContext.request.contextPath}/resources/images/To.png" alt="" id="mypageimg"/>
				        <button type="submit" class="btn-list">같이해요</button>
				        <input type="hidden" name="memberId" value="${localdetail.writer}"/>
				        </li>
			        </form:form>
			      	<form:form name="myManner1Frm" action="${pageContext.request.contextPath}/manner/myManner1.do" method="GET">
				        <li>
				        <img src="${pageContext.request.contextPath}/resources/images/Ma.png" alt="" id="mypageimg"/>
				        <button type="submit" class="btn-list">받은매너</button>
				        <input type="hidden" name="memberId" value="${localdetail.writer}"/>
				        </li>
			        </form:form>
			      </div>
			      <div class="modal-footer" id="modal-footer">
			        <button type="button" class="btn btn-secondary1" data-bs-dismiss="modal">Close</button>
			      </div>
			    </div>
			  </div>
			</div>
			</td> 
		<!-- --------------------------------------------------------------------------------------------- -->
		
		
		
		
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
				<span id="likeimg">
				<%-- <c:if test="${}" 이 로그인멤버의 아이디&게시글 no가 wish테이블에 없다면 빈하트 아니 꽉찬하트  --%>
			
				<c:if test="${findlike == 0 or findlike == null}">
					<img  style="width: 40px; float: right; margin-right: 10px; margin-top: -50px; display: inline"
					class="hearts" src="${pageContext.request.contextPath}/resources/images/heart_empty.png" alt="임시이미지">
				</c:if>
				<c:if test="${findlike == 1}">
					<img  style="width: 40px; float: right; margin-right: 10px; margin-top: -50px; display: inline"
					class="hearts" src="${pageContext.request.contextPath}/resources/images/heart_red.png" alt="heartfull">
				</c:if>
				</span> 
						
			</div>
		<!-- 댓글 -->
		<form name="commentInsertFrm" action="${pageContext.request.contextPath}/local/commentInsert.do" method="post">
			<div class="comment-wrap">
				<input type="text" id="replytext" name="content" placeholder="댓글을 작성하세요"></input>
				<input type="hidden" name="localNo" value="${localdetail.no}" >
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<br>
				<div class=replyBtn>
				<p><button type="submit" id="btnReply">댓글 작성</button></p>
				</div>
			</div>
		</form>
		<c:if test="${not empty commentList}">
			<div class="div-comment">
				<div id="commentOriList">
					<button id="commentOriList" onclick="setCommentOrderList('asc');">·등록순</button>
				</div>
				&nbsp;&nbsp;&nbsp;
				<div id="commentNewList">
					<button id="commentNewList" onclick="setCommentOrderList('desc');">·최신순</button>
				</div>
			</div>
		</c:if>
		<c:forEach items="${commentList}" var="comment">
	<!-- -등록순 최신순 -->
		<div id="commentList">
		<!-- 모댓글 -->
		<div class="moComment" style="margin-left:20px;">
			<c:if test="${comment.commentLevel == 1}">
				<div class="memberInfo">
					<div class="profileimg">
						<img src="${pageContext.request.contextPath}/resources/upload/profile/${comment.member.profileImg}" alt="사용자프로필">
					</div>
					<div class="detailInfo">
						<span class="nickname">${comment.member.nickname}</span>
						<div class="dong-date">
							<span>${comment.dong.dongName}</span>
							&nbsp;
							<fmt:parseDate value="${comment.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate"/>
								<fmt:formatDate value="${regDate}" pattern="MM.dd a HH:mm"/>
						</div>
					</div>
				</div>
				<p class="commentContent" id="parentContent-${comment.commentNo}"> ${comment.content }</p>
			
				<!-- 댓글 수정 삭제 버튼 넣기 -->
				<button type="button" onclick="reReply(${comment.commentNo});">답글쓰기</button>
				<c:if test="${comment.writer == loginMember.memberId  }">
					<button type="button" onclick="replyEdit(${comment.commentNo}, '${comment.content}');">수정</button>
					<button type="button" onclick="replyDelete(${comment.commentNo});">삭제</button>
					
				</c:if>
			</c:if>
		</div>
		<!-- 대댓글 -->
		<c:if test="${comment.commentLevel > 1 }">
			<div class="reComment" style="margin-left:60px;">
				<div class="memberInfo">
			<div class="profileimg">
				<img src="${pageContext.request.contextPath}/resources/upload/profile/${comment.member.profileImg}" alt="사용자프로필">
			</div>
			<div class="detailInfo">
				<span class="nickname">${comment.member.nickname}</span>
				<div class="dong-date">
					<span>${comment.dong.dongName}</span>
					&nbsp;
					<fmt:parseDate value="${comment.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate"/>
						<fmt:formatDate value="${regDate}" pattern="MM.dd HH:mm"/>
					</div>
				</div>
			</div>
				<p class="commentContent" id="parentContent-${comment.commentNo}">${comment.content}</p>
				<c:if test="${comment.writer == loginMember.memberId  }">
				<button type="button" onclick="replyEdit(${comment.commentNo}, '${comment.content}');">수정</button>
				<button type="button" onclick="replyDelete(${comment.commentNo});">삭제</button>
				
			</c:if>
			</div>
		</c:if>
		</div>
		</c:forEach>
		</div>
	</div>
<!-- 댓글 등록순(기본) 최신순 정렬 (클릭하면 로직 따르게...?) -->


<c:if test="${localdetail.writer eq loginMember.memberId}">
<form:form name="localDeleteFrm"  enctype ="multipart/form-data"  method="post"
	 action="${pageContext.request.contextPath}/local/localDelete.do?${_csrf.parameterName}=${_csrf.token}" >
	 <input type="hidden" name="no" value="${localdetail.no}" >
</form:form>

<script>
//게시글 수정하기
document.querySelector("#update").addEventListener('click', (e) => {
	const no ='${localdetail.no}'
		location.href = '${pageContext.request.contextPath}/local/localUpdate.do?no=' + no;
});

//게시글 삭제하기
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
//게시글 수정하기, 삭제하기, 신고하기 토글
$(function (){
	$("#togglebtn").click(function (){
  	$("#divToggle").toggle();
  });
});
</script>


<script>
//좋아요
	document.querySelector(".hearts").addEventListener('click', (e) => {

		const img = e.target;
		console.log( img );
	
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		
		$.ajax({
		    url : `${pageContext.request.contextPath}/local/localLike.do`,
		    method : 'post',
		    headers,
		    data : { no : '${localdetail.no}',
		             memberId : '<sec:authentication property="principal.username" />'},  //1 또는 0을 받아야 insert or delete를 한다
		    dataType : 'json',
	           success(data){
		    	if(data == 1){
		    		img.src = `${pageContext.request.contextPath}/resources/images/heart_red.png`;
		    	}
		    	else{
		    		img.src = `${pageContext.request.contextPath}/resources/images/heart_empty.png`;
	
		    	}
		    },
		    error(jqxhr, textStatus, err ){
		        console.log(jqxhr, textStatus, err);
		    }   
		})
	}); 
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>