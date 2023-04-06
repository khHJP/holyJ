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
<script>
	//댓글목록(Controller 방식)
	function commentList(){
		$.ajax({
			type:"get",
			url: `${pageContext.request.contextPath}/local/commentList.do`,
			success : function(result){
				$("#commentList").html(result);
			}
		});
	};
	
	
	$(document).on('click', '#commentNewList', function() {
	    $.ajax({
	        type: 'GET',
	        url: `${pageContext.request.contextPath}/local/localNewDetail.do`,
	        data: {no: ${localdetail.no}}, // no 파라미터 값 설정
	        success: function(data) {
	            $('.replyList').html(data);
	        }
	    });
	});
</script>

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
</script>
</head>
<sec:authentication property="principal" var="loginMember"/>
<div class="localboard-container">
	<div class="localboard-wrap">
		<span class="category">${localdetail.localcategory.categoryName}</span>
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
		<div class="div-comment">
			<div id="commentOriList">
			<button id="commentOriList">·등록순</button>
			</div>
			&nbsp;&nbsp;&nbsp;
			<div id="commentNewList">
			<button id="commentNewList">·최신순</button>
			</div>
		</div>
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
								<fmt:formatDate value="${regDate}" pattern="MM.dd HH:mm"/>
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