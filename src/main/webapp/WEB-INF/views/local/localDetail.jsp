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
	$(document).ready(function(){
		commentList2(); // json 리턴방식
		
		//댓글쓰기 버튼 클릭 이벤트
		/*
		$("#btnReply").click(function(){
			var replytext = $("#replytext").val();
			var localNo = "${localdetail.no}";
			const param = {
					'content' : replytext,
					'localNo' : localNo
			};
			//var param = "replytext = " + replytext + "&localNo" + localNo;
			console.log(param);
			<!-- memberId  넣어라 자식아 -->
			
			const csrfHeader = "${_csrf.headerName}";
		    const csrfToken = "${_csrf.token}";
		    const headers = {};
		    headers[csrfHeader] = csrfToken;
		    console.log(csrfHeader);
		    console.log(csrfToken);
			$.ajax({
				type : "post",
				url : `${pageContext.request.contextPath}/local/commentInsert.do`,
				data : {
					content : replytext,
					localNo : localNo
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeader, csrfToken);
				},
				//contentType : "application/json; charset=UTF-8",
				dataType : 'text',
				success : function(){
					alert("댓글이 등록되었습니다.");
					commentList2();
				}
			});
		});*/
	});
	
	//댓글목록(Controller 방식)
	function commentList(){
		$.ajax({
			type:"get",
			url: `${pageContext.request.contextPath}/local/commmentList.do`,
			success : function(result){
				$("#commentList").html(result);
			}
		})
	}
	
	function commentList2(){
		$.ajax({
			type:"get",
			url: `${pageContext.request.contextPath}/local/listJson.do`,
			success : function(result){
				console.log(result);
				var output = "<table>";
				for(var i in result){
					output += "<tr>";
					output += "<td>" + result[i].memberId;
					output += "("+changeDate(result[i].regDate)+")<br>";
					output += result[i].replytext+"</td>";
					output += "<tr>";
				}
				output += "</table>";
				$("#commentList").html(output);
			}
		});
	}
	//날짜 변환 함수 작성
	function changeDate(data){
		date = new Date(parseInt(date));
		year = date.getFullYear();
		month = date.getMonth();
		day = date.getDate();
		hour = date.getHours();
		minute = date.getMinutes();
		strDate = year+"."+month+"."+day+"."+hour+":"+minute;
		return strDate;
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
			<span>·등록순</span>
			&nbsp;&nbsp;&nbsp;
			<span>·최신순</span>
		</div>
		<div id="commentList">
		<c:forEach items="${commentList}" var="comment">
		<!-- 모댓글 -->
		<div class="moComment" style="margin-left:20px;">
		<c:if test="${comment.commentLevel == 1}">
			<i class="bi-three-dots-vertical commentdots"></i>
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
			<p class="commentContent"> ${comment.content }</p>
			<span class="replybtn">답글쓰기</span>
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
				<p class="commentContent">${comment.content}</p>
			</div>
		</c:if>
		</c:forEach>
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

<!--  
<script>
// 댓글 가져오기
const ReplyList = function(no) {
	$.ajax({
		url : `${pageContext.request.contextPath}/local/commentList.do`,
		type : 'get',
		data : { commentNo : cno,
				 memberId : '<sec:authentication property="principal.username" />'},
		succes : funtion(data) {
			
			console.log("댓글 리스트 가져오기 성공");
			
			//댓글 목록을 html로 담기
			let listHtml = "";
			for(const i in data){
				let cno = data[i].commentNo;
				let localNo = data[i].localNo;
				let writer = data[i].writer;
				let refNo = data[i].refNo;
				let commentLevel = data[i].commentLevel;
				let content = data[i].content;
				let regDate = data[i].regDate;
				let profile =  data[i].profile;
				
				console.log(commentLevel);
				
				listHtml += "<div class='row replyrw reply" + cno +"'>";
				
				if(content == ""){
					listHtml += "	<div>";
					listHtml += "		(삭제된 댓글입니다)";
					listHtml += "	</div>";
				} else{
					if(commentLevel == 1){ //모댓글 일 때
						listHtml += "	<div class='col-1'>";
						listHtml += "		<img src="${pageContext.request.contextPath}/resources/upload/profile/${localdetail.member.profileImg}" alt="사용자프로필">";
						listHtml += "	</div>";
						listHtml += "	<div class='rereply-content col-8'>";
						listHtml += "		<div>";
						listHtml += "			<span>";
						listHtml += "				<b>"+writer+"</b>";
						listHtml += "			</span>";
						listHtml += "			<span>";
						listHtml += 				content;
						listHtml += "			</span>";
						listHtml += "	</div>";
						
						if("${localdetail.writer != loginMember.memberId}") {
							listHtml += "		<div>";
							listHtml += "		<a href='#' class='write_reply_start' data-bs-toggle='collapse' data-ba-target = '#re_reply"+cno+" aria-expanded='false' aria-controls='collapseExample'>답글&nbsp;달기</a>";
							listHtml += "		</div>";
						} 
						listHtml += "	<div>";
					} else{			//답글일 때
						listHtml += "	<div class='col-1'>"
						listHtml += "	</div>"
						listHtml += "	<div class='col-1'>";
						listHtml += "		<img src="${pageContext.request.contextPath}/resources/upload/profile/${localdetail.member.profileImg}" alt="사용자프로필">";
						listHtml += "	</div>";
						listHtml += "	<div class='rereply-content"+cno+" col-7'>";
						listHtml += "		<div>";
						listHtml += "			<span>";
						listHtml += "				<b>"+writer+"</b>";
						listHtml += "			</span>";
						listHtml += "			<span>";
						listHtml += 				content;
						listHtml += "			</span>";
						listHtml += "	</div>";
						
						listHtml +="	</div>";
					}
					
					listHtml += "	<div class='col-3 reply-right'>";
					listHtml += "		<div>";
					listHtml += 		regDate;
					listHtml += "		</div>";
					
					//현재 사용자가 이 댓글의 작성자일 때 삭제 버튼이 나온다.
					if("${localdetail.writer == loginMember.memberId}"){
						listHtml += "		<div>";
						//삭제는 cno만 넘겨주면 되지 않나.
						listHtml += "			<a href='javascript:' cno='"+cno+"' commentLevel='"+commentLevel+"' localNo='"+localNo+"' refNo='"+refNo+"' class='reply_delete'>삭제</a>";
						listHtml += "		</div>";
					}
					
					listHtml += "	</div>";
					//댓글에 답글달기
					listHtml += "	<div class='collapse row rereply_write' id='re_reply"+cno+"'>";
					listHtml += "		<div class='col-1'>"
					listHtml += "		</div>"
					listHtml += "		<div class='col-1'>"
					listHtml += "			<img src="${pageContext.request.contextPath}/resources/upload/profile/${localdetail.member.profileImg}" alt="사용자프로필">";
					listHtml += "		</div>"
					listHtml += "		<div class='col-7'>"
					listHtml += "		<input class='w-100 input_rereply_div form-control' id='input_rereply"+cno+"' type='text' placeholder='댓글입력...'>"
					listHtml += "		</div>"
					listHtml += "		<div class='col-3'>"
					
					listHtml += "		<button type='button' class='btn btn-success mb-1 write_rereply' cno='"+cno+"' localNo='"+localNo+"'>답글&nbsp;달기</button>"
					listHtml += "		</div>";
					listHtml += "	</div>";
					//답글입력 끝
				}
				
				listHtml += "	</div>";
			};
			
			//댓글 리스트 부분에 받아온 댓글 리스트 넣기
			$(".reply-list"+cno).html(listHtml);
			
			//답글 작성한 후 답글달기 버튼을 눌렀을 때 그 click event를 아래처럼 jqurey로 처리한다.
			$('button.btn.btn-succes.mb-1.write_rereply').on('click', function(){
				console.log('cno', $(this).attr('cno'));
				console.log('localNo', $(this).attr('localNo'));
				
				//답글을 DB에 저장하는 함수를 호출한다. localNo와 cno를 같이 넘겨주어야한다.
				WriteReReply($(this).attr('localNo'),$(this).attr('cno'));
			});
			
			//삭제버튼을 클릭했을 때
			$('.reply_delete').on('click', function(){
				//모댓글 삭제일 때
				if($(this).attr('commentLevel') == 1){
					DeleteReply($(this).attr('cno'), $(this).attr('localNo'));	
				
			//답글 삭제 일 때
				} else{
					DelteReReply($(this).attr('no'), $(this).attr('localNo'), $(this).attr('refNo'));
				}
			})
		},
		error : function(){
			alert('서버 에러');
		}
		
	});
};

//답글 달기 버튼 클릭시 실행 - 답글 저장 가져오기
const WriteReReply = function(localNo, cno) {
	
	console.log(localNo);
	console.log(cno);
	
	console.log("#input_rereply"+cno).val());
	
	//댓글 입력란 내용 가져오기
	let content = $("#input_rereply"+cno).val();
	content = content.trim();
	
	if(content == ""){
		alert("글을 입력하세요");
	} else{
		$("#input_rereply"+cno).val("");
		
		$.ajax({
			url :`${pageContext.request.contextPath}/local/writeRereply.do`,
			type : 'get',
			data : {
				commnetNo : cno,
				localNo : localNo,
				content : content,
				memberId : '<sec:authentication property="principal.username" />'
			},
			success : function(pto) {
				let reply = pto.reply;
				cosole.log("답글 작성 성공");
				
				//게시물 번호에 해당하는 댓글리스트를 새로 받아오기
				CommentList(localNo);
			},
			error : function() {
				alert('서버 에러');
			}
		});
	};
};

//모댓글 삭제 일때
const DeleteReply = funtion(no, bno){
	//regNo가 cno인 댓글이 있는 경우 content에 null을 넣고 없으면 삭제한다.
	$.ajax({
		url : `${pageContext.request.contextPath}/local/deleteReply.do`,
		type : 'get',
		data : {
			commnetNo : cno,
			localNo : localNo,
			memberId : '<sec:authentication property="principal.username" />'
		},
		success : function(pto){
			let reply = pto.reply;
			console.log("모댓글 삭제 성공");
			CommentList(localNo);
		},
		error : funtion() {
			alert('서버 에러');
		}
	});
};

//답글 삭제 일때
const DeleteReReply = function(cno, localNo, regNo){
	//답글 삭제
	$.ajax({
		url : `${pageContext.request.contextPath}/local/deleteRereply.do`,
		type : 'get',
		data : {
			commnetNo : cno,
			localNo : localNo,
			regNo : regNo,
			memberId : '<sec:authentication property="principal.username" />'
		},
		success : funtion(pto) {
			let reply = pto.reply;
			
			console.log("답글 삭제 성공");
			CommentList(localNo);
		},
		error : funtion() {
			alert('서버 에러');
		}
	});
};

</script>
-->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>